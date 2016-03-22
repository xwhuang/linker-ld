#include <stdio.h>
#include "util.h"
#include "print.h"
#ifdef AORDER
#include "show.h"
#endif

int print_init(void)
{
    printf("## init print @%s(Line %d)\n", __FILE__, __LINE__);
#ifdef AORDER
    show_init();
#endif
    return 0;
}
