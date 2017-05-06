int sub_100001f00(int arg0, int arg1) {
    r14 = arg1;
    var_20 = *___stack_chk_guard;
    CC_MD5(arg0, strlen(arg0), var_30);
    rbx = 0x0;
    __snprintf_chk(var_50, 0x14, 0x0, 0x14, "%u", var_30);
    if (strlen(r14) != 0x18) goto loc_100002037;

loc_100001f6d:
    rbx = 0x0;
    if (strncmp(r14, var_50, strlen(var_50)) != 0x0) goto loc_100002037;

loc_100001f91:
    rax = *(int8_t *)(r14 + rbx) + 0xd0;
    if ((rax & 0xff) > 0x9) goto loc_100002035;

loc_100001fa3:
    *(int8_t *)(rbp + rbx + 0xffffffffffffff90) = rax;
    rbx = rbx + 0x1;
    if (rbx < 0x18) goto loc_100001f91;

loc_100001fb0:
    rax = 0x0;
    rcx = 0x0;
    do {
            rcx = rcx + (*(int8_t *)(rbp + rax + 0xffffffffffffff9a) & 0xff);
            rax = rax + 0x1;
    } while (rax != 0x5);
    if (rcx == 0x15) {
            rax = 0x1;
            rcx = 0x0;
            do {
                    rax = rax * (*(int8_t *)(rbp + rcx + 0xffffffffffffff9f) & 0xff);
                    rcx = rcx + 0x1;
            } while (rcx != 0x5);
            rbx = 0x0;
            if (rax == 0x1e0) {
                    rax = 0x0;
                    do {
                            rbx = rbx + (*(int8_t *)(rbp + rax + 0xffffffffffffff90) & 0xff);
                            rax = rax + 0x2;
                    } while (rax < 0x18);
                    rax = 0x0;
                    rcx = 0x1;
                    COND = (rbx & 0xf) != 0x3;
                    rbx = 0x0;
                    if (!COND) {
                            do {
                                    rax = rax + (*(int8_t *)(rbp + rcx + 0xffffffffffffff90) & 0xff);
                                    rcx = rcx + 0x2;
                            } while (rcx < 0x18);
                            rbx = (rax & 0xf) == 0x7 ? 0x1 : 0x0;
                    }
            }
    }
    else {
            rbx = 0x0;
    }
    goto loc_100002037;

loc_100002037:
    if (*___stack_chk_guard == var_20) {
            rax = rbx;
    }
    else {
            rax = __stack_chk_fail();
    }
    return rax;

loc_100002035:
    rbx = 0x0;
    goto loc_100002037;
}
