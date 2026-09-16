#include <time.h>

void now_and_here(time_t *now, const char **here) {
    *now = time(NULL);
    *here = __FILE__;
}
