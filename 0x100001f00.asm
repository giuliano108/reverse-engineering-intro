
        ; Section __text
        ; Range: [0x100001f00; 0x10000390a[ (6666 bytes)
        ; File offset : [7936; 14602[ (6666 bytes)
        ; Flags: 0x80000400
        ;   S_REGULAR
        ;   S_ATTR_PURE_INSTRUCTIONS
        ;   S_ATTR_SOME_INSTRUCTIONS



        ; ================ B E G I N N I N G   O F   P R O C E D U R E ================

        ; Variables:
        ;    var_20: -32
        ;    var_30: -48
        ;    var_50: -80


                     sub_100001f00:
0000000100001f00         push       rbp                                         ; CODE XREF=sub_100002380+377, sub_100003770+76
0000000100001f01         mov        rbp, rsp
0000000100001f04         push       r15
0000000100001f06         push       r14
0000000100001f08         push       rbx
0000000100001f09         sub        rsp, 0x58
0000000100001f0d         mov        r14, rsi
0000000100001f10         mov        rbx, rdi
0000000100001f13         mov        r15, qword [___stack_chk_guard_100005048]
0000000100001f1a         mov        r15, qword [r15]
0000000100001f1d         mov        qword [rbp+var_20], r15
0000000100001f21         call       imp___stubs__strlen
0000000100001f26         lea        rdx, qword [rbp+var_30]                     ; argument "md" for method imp___stubs__CC_MD5
0000000100001f2a         mov        rdi, rbx                                    ; argument "data" for method imp___stubs__CC_MD5
0000000100001f2d         mov        esi, eax                                    ; argument "len" for method imp___stubs__CC_MD5
0000000100001f2f         call       imp___stubs__CC_MD5
0000000100001f34         mov        r9d, dword [rbp+var_30]
0000000100001f38         lea        r8, qword [0x100003bd0]                     ; "%u", argument #5 for method imp___stubs____snprintf_chk
0000000100001f3f         xor        ebx, ebx
0000000100001f41         lea        rdi, qword [rbp+var_50]                     ; argument #1 for method imp___stubs____snprintf_chk
0000000100001f45         mov        esi, 0x14                                   ; argument #2 for method imp___stubs____snprintf_chk
0000000100001f4a         mov        edx, 0x0                                    ; argument #3 for method imp___stubs____snprintf_chk
0000000100001f4f         mov        ecx, 0x14                                   ; argument #4 for method imp___stubs____snprintf_chk
0000000100001f54         xor        eax, eax
0000000100001f56         call       imp___stubs____snprintf_chk
0000000100001f5b         mov        rdi, r14                                    ; argument "s" for method imp___stubs__strlen
0000000100001f5e         call       imp___stubs__strlen
0000000100001f63         cmp        rax, 0x18
0000000100001f67         jne        loc_100002037

0000000100001f6d         lea        rbx, qword [rbp+var_50]
0000000100001f71         mov        rdi, rbx                                    ; argument "s" for method imp___stubs__strlen
0000000100001f74         call       imp___stubs__strlen
0000000100001f79         mov        rdi, r14                                    ; argument "s1" for method imp___stubs__strncmp
0000000100001f7c         mov        rsi, rbx                                    ; argument "s2" for method imp___stubs__strncmp
0000000100001f7f         mov        rdx, rax                                    ; argument "n" for method imp___stubs__strncmp
0000000100001f82         call       imp___stubs__strncmp
0000000100001f87         xor        ebx, ebx
0000000100001f89         test       eax, eax
0000000100001f8b         jne        loc_100002037

                     loc_100001f91:
0000000100001f91         mov        al, byte [r14+rbx]                          ; CODE XREF=sub_100001f00+174
0000000100001f95         add        al, 0xd0
0000000100001f97         movzx      ecx, al
0000000100001f9a         cmp        ecx, 0x9
0000000100001f9d         ja         loc_100002035

0000000100001fa3         mov        byte [rbp+rbx+var_70], al
0000000100001fa7         inc        rbx
0000000100001faa         cmp        rbx, 0x18
0000000100001fae         jb         loc_100001f91

0000000100001fb0         xor        eax, eax
0000000100001fb2         xor        ecx, ecx

                     loc_100001fb4:
0000000100001fb4         movzx      edx, byte [rbp+rax+var_66]                  ; CODE XREF=sub_100001f00+195
0000000100001fb9         add        rcx, rdx
0000000100001fbc         inc        rax
0000000100001fbf         cmp        rax, 0x5
0000000100001fc3         jne        loc_100001fb4

0000000100001fc5         cmp        rcx, 0x15
0000000100001fc9         jne        loc_100002035

0000000100001fcb         mov        eax, 0x1
0000000100001fd0         xor        ecx, ecx

                     loc_100001fd2:
0000000100001fd2         movzx      edx, byte [rbp+rcx+var_61]                  ; CODE XREF=sub_100001f00+226
0000000100001fd7         imul       rax, rdx
0000000100001fdb         inc        rcx
0000000100001fde         cmp        rcx, 0x5
0000000100001fe2         jne        loc_100001fd2

0000000100001fe4         xor        ebx, ebx
0000000100001fe6         cmp        rax, 0x1e0
0000000100001fec         jne        loc_100002037

0000000100001fee         xor        eax, eax

                     loc_100001ff0:
0000000100001ff0         movzx      ecx, byte [rbp+rax+var_70]                  ; CODE XREF=sub_100001f00+256
0000000100001ff5         add        rbx, rcx
0000000100001ff8         add        rax, 0x2
0000000100001ffc         cmp        rax, 0x18
0000000100002000         jb         loc_100001ff0

0000000100002002         and        ebx, 0xf
0000000100002005         xor        eax, eax
0000000100002007         mov        ecx, 0x1
000000010000200c         cmp        rbx, 0x3
0000000100002010         mov        ebx, 0x0
0000000100002015         jne        loc_100002037

                     loc_100002017:
0000000100002017         movzx      edx, byte [rbp+rcx+var_70]                  ; CODE XREF=sub_100001f00+295
000000010000201c         add        rax, rdx
000000010000201f         add        rcx, 0x2
0000000100002023         cmp        rcx, 0x18
0000000100002027         jb         loc_100002017

0000000100002029         and        eax, 0xf
000000010000202c         cmp        rax, 0x7
0000000100002030         sete       bl
0000000100002033         jmp        loc_100002037

                     loc_100002035:
0000000100002035         xor        ebx, ebx                                    ; CODE XREF=sub_100001f00+157, sub_100001f00+201

                     loc_100002037:
0000000100002037         cmp        r15, qword [rbp+var_20]                     ; CODE XREF=sub_100001f00+103, sub_100001f00+139, sub_100001f00+236, sub_100001f00+277, sub_100001f00+307
000000010000203b         jne        loc_10000204a

000000010000203d         mov        al, bl
000000010000203f         add        rsp, 0x58
0000000100002043         pop        rbx
0000000100002044         pop        r14
0000000100002046         pop        r15
0000000100002048         pop        rbp
0000000100002049         ret
                        ; endp

                     loc_10000204a:
000000010000204a         call       imp___stubs____stack_chk_fail               ; CODE XREF=sub_100001f00+315
                        ; endp
