#include <stdio.h>
#include "CrackMe/validate.h"

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: ./cli_validate email code\n");
        return(1);
    }

    if (validate(argv[1], argv[2])) {
        printf("valid!\n");
    } else {
        printf("nope\n");
    }
}
