/*********************************************************************
 *
 *      Some routines just dumped here by djm..can't be bothered to
 *      find proper place for them!
 *
 *********************************************************************
 */

#include "ccdefs.h"
#include "utstack.h"

/* Generic change suffix routine */


void changesuffix(char *name, char *suffix)
{
    size_t j;
    j = strlen(name) - 1;
    while (j && name[j - 1] != '.')
        j--;

    if (j) {
        name[j - 1] = '\0';
    }
    strcat(name, suffix);
}


static stackaddr  *stack;

/* Set up the stack references... */

void initstack()
{
    stack = NULL;
}

/* Retrieve last item on the stack */

stackaddr *retrstk(stackaddr *stacked)
{
    stackaddr *elem;

    if ( !STACK_EMPTY(stack) ) {
        STACK_POP(stack, elem);
        *stacked = *elem;
        FREENULL(elem);
        return stacked;
    }
    return NULL; 
}

/* Insert an item onto the stack */

void addstk(LVALUE* lval)
{
    stackaddr *elem = MALLOC(sizeof(*elem));

    elem->sym = lval->symbol;
    elem->flags = lval->flags;
    elem->base_offset = lval->base_offset;

    STACK_PUSH(stack, elem);
}

