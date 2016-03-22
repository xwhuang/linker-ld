#include <stdio.h>
#include "debug.h"
#include "order.h"

static int bug0(void)
{
    return 0;
}

int bug1 (void)
{
    return 1;
}

int debug(void)
{
    printf("debug @%s (Line %d)\n", __FILE__, __LINE__);
    return 0;
}


