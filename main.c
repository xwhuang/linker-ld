#include <stdio.h>
#include "util.h"
#include "show.h"
#include "print.h"
#ifdef LDORDER
#include "order.h"
#endif

int main(void)
{
#ifdef OORDER
    order_init();
    debug();
#endif

#ifdef NORMAL
    print_init();
#endif

    return 0;
}
