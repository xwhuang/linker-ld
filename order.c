#include <stdio.h>
#include "order.h"

int order_init(void)
{
    printf("order init @%s(%d)\n", __FILE__, __LINE__);
    return 0;
}

int order_debug(void)
{
    printf("**order debug** @%s(%d)\n", __FILE__, __LINE__);
    return 0;
}
