#include <stdio.h>
#include "util.h"
#include "show.h"

int show_init(void)
{
    printf("## init show\n");
    util_init();

    return 0;
}
