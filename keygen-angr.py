import unicorn
import simuvex
import angr
import md5

def email_hash(email):
    m = md5.new()
    m.update(email)
    return m.digest()

VALIDATE_FUNCTION_ADDR = 0x100001f00
EMAIL = "a@b.com\x00"
EMAIL_HASH = email_hash(EMAIL.rstrip(b'\0'))
KEY_NUM_DIGITS = 24

def cc_md5(state):
    # rdx "md" for method imp___stubs__CC_MD5
    state.memory.store(state.regs.rdx, state.se.BVV(EMAIL_HASH, len(EMAIL_HASH)*8))

def strlen(state):
    buff = state.se.any_str(state.memory.load(state.regs.rdi, 1024))
    term_idx = buff.find(b'\0')
    state.regs.rax = term_idx

def snprintf(state):
    # rdi       argument #1 for method imp___stubs____snprintf_chk
    # esi       argument #2 for method imp___stubs____snprintf_chk
    # edx       argument #3 for method imp___stubs____snprintf_chk
    # ecx       argument #4 for method imp___stubs____snprintf_chk
    # r8  "%u", argument #5 for method imp___stubs____snprintf_chk
    # r9d       [rbp+var_30]    md5 hash
    assert state.se.any_str(state.memory.load(state.regs.r8, 2)) == '%u'
    string = "%u\x00" % state.se.any_int(state.regs.r9)
    string_bvv = state.se.BVV(string, len(string) * 8)
    state.memory.store(state.regs.rdi, string_bvv)

def strncmp_copy_hash(state):
    n = state.regs.rdx
    s2 = state.se.any_str(state.memory.load(state.regs.rsi, n)).rstrip(b'\0')
    string_bvv = state.se.BVV(s2, len(s2) * 8)
    state.memory.store(state.regs.rdi, string_bvv)

    s1 = state.se.any_str(state.memory.load(state.regs.rdi, n)).rstrip(b'\0')
    s2 = state.se.any_str(state.memory.load(state.regs.rsi, n)).rstrip(b'\0')
    if s1 == s2:
        state.regs.eax = 0
    else:
        state.regs.eax = 1


p = angr.Project('CrackMe.app/Contents/MacOS/CrackMe', load_options={'auto_load_libs':False})

state = p.factory.blank_state(addr=VALIDATE_FUNCTION_ADDR,
                              remove_options={simuvex.o.LAZY_SOLVES})

# (lldb) expression -f p -- (char*)$rdi
# (char *) $75 = 0x0000000100d3d120 "a@b.com"
EMAIL_ADDR = 0x100d3d120
email = state.se.BVV(EMAIL, len(EMAIL) * 8)
state.memory.store(EMAIL_ADDR, email)

# (lldb) expression -f p -- (char*)$rsi
# (char *) $76 = 0x0000000100d23d40 "54321"
KEY_ADDR=0x100d23d40
key = []
for i in xrange(0, KEY_NUM_DIGITS + 1):
    b = state.se.BVS('key%d' % i, 8)
    key.append(b)
    state.memory.store(KEY_ADDR + i, key[-1])
    state.add_constraints(b >= ord('0'), b <= ord('9'))
state.memory.store(KEY_ADDR + KEY_NUM_DIGITS, state.se.BVV(b'\0', 8))

# 0x100001f2f <+47>:  e8 fa 19 00 00  callq  0x10000392e  ; symbol stub for: CC_MD5
p.hook(0x100001f2f, cc_md5, length=5)

# 0000000100001f21         call       imp___stubs__strlen
# 0000000100001f5e         call       imp___stubs__strlen
# 0000000100001f74         call       imp___stubs__strlen
p.hook(0x100001f21, strlen, length=5)
p.hook(0x100001f5e, strlen, length=5)
p.hook(0x100001f74, strlen, length=5)

# 0000000100001f56         call       imp___stubs____snprintf_chk
p.hook(0x100001f56, snprintf, length=5)

# 0000000100001f82         call       imp___stubs__strncmp
p.hook(0x100001f82, strncmp_copy_hash, length=5)

# 000000010000204a         call       imp___stubs____stack_chk_fail
p.hook(0x10000204a, lambda: None, length=5)

state.regs.rdi=EMAIL_ADDR
state.regs.rsi=KEY_ADDR
path = p.factory.path(state)

pg = p.factory.path_group(path)
pg.explore(find=0x100002033, avoid=(0x100002037,0x100002035))

assert len(pg.found) == 1

# We are @ 0x100002033, but we also want bl (the return value to be non-zero)
#   000000010000202c         cmp        rax, 0x7
#   0000000100002030         sete       bl
# ->0000000100002033         jmp        loc_100002037

found = pg.found[0]

# ipdb> found.state.regs.bl
# <BV8 0#7 .. (if (key11_12_8[3:0] == __add__(9, (15 * key13_14_8[3:0]), (15 * key15_16_8[3:0]), (15 * key17_18_8[3:0]), (15 * key19_20_8[3:0]), (15 * key21_22_8[3:0]), (15 * key23_24_8[3:0]))) then 1 else 0)>

found.state.add_constraints(found.state.regs.bl != 0)
pg = p.factory.path_group(found)
pg.explore(find=0x100002037)

assert len(pg.found) == 1
found = pg.found[0]

# ipdb> found.state.memory.load(KEY_ADDR, KEY_NUM_DIGITS)
# <BV192 0x33383934343432353439#80 .. key10_11_8 .. key11_12_8 .. key12_13_8 .. key13_14_8 .. key14_15_8 .. key15_16_8 .. key16_17_8 .. key17_18_8 .. key18_19_8 .. key19_20_8 .. key20_21_8 .. key21_22_8 .. key22_23_8 .. key23_24_8>
# ipdb> found.state.se.any_str(found.state.memory.load(KEY_ADDR, KEY_NUM_DIGITS))
# '389444254990075435188938'
# ipdb>

print 'email: ' + EMAIL
print 'code : ' + found.state.se.any_str(found.state.memory.load(KEY_ADDR, KEY_NUM_DIGITS))
print
