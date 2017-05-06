//
//  validate.c
//  CrackMe
//
//  Created by Giuliano Cioffi on 4/17/17.
//  Copyright © 2017 Giuliano Cioffi. All rights reserved.
//

#include <CommonCrypto/CommonCrypto.h>
#include <stdio.h>

#include "validate.h"
#define VDT_N_DIGITS 24

bool validate(const char *email, const char *code) {
    char digest[CC_MD5_DIGEST_LENGTH];
    char email_hash_string[20]; 
    uint8_t digits[VDT_N_DIGITS];
    uint32_t *email_hash;
    uint64_t i, s, p;

    CC_MD5(email, (CC_LONG)strlen(email), (unsigned char *)digest);
    email_hash = (uint32_t *)digest;
    snprintf(email_hash_string, sizeof(email_hash_string), "%u", *email_hash);

    if (strlen(code) != VDT_N_DIGITS) return false;

    if (strstr(code, email_hash_string) != code) return false;

    for (i = 0; i < VDT_N_DIGITS; i++) {
        char c = code[i];
        if (c < '0' || c > '9') return false;
        digits[i] = code[i] - '0';
    }

    s = 0;
    for (i = 10; i < 15; i++) {
        s += digits[i];
    }
    if (s != 21) return false;

    p = 1;
    for (i = 15; i < 20; i++) {
        p *= digits[i];
    }
    if (p != 480) return false;

    s = 0;
    for (i = 0; i < VDT_N_DIGITS; i++) {
        s += digits[i];
        i++;
    }
    if (s % 16 != 3) return false;

    s = 0;
    for (i = 1; i < VDT_N_DIGITS; i++) {
        s += digits[i];
        i++;
    }
    if (s % 16 != 7) return false;

    return true;
}
