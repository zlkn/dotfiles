/* C — syntax sampler */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define ARRAY_LEN(a) ((int)(sizeof(a)/sizeof((a)[0])))
#define LOG(fmt, ...) fprintf(stderr, "[%s:%d] " fmt "\n", __FILE__, __LINE__, __VA_ARGS__)

typedef enum { RED=1, GREEN=2, BLUE=3 } Color;

typedef struct {
    int x, y;
} Point;

static inline double distance(Point a, Point b) {
    int dx = a.x - b.x, dy = a.y - b.y;
    return (double)(dx*dx + dy*dy) > 0 ? sqrt((double)(dx*dx + dy*dy)) : 0.0;
}

int apply(int (*op)(int,int), int a, int b) { return op ? op(a,b) : 0; }
int add(int a,int b){ return a+b; }

int main(void) {
    const char *s = "hello-world";
    if (strstr(s, "hello") && strchr(s, '-')) {
        Point p = {0,1}, q = {2,3};
        double d = distance(p,q);
        int xs[] = {1,2,3};
        int sum = 0; for (int i=0; i<ARRAY_LEN(xs); ++i) sum += xs[i];
        LOG("color=%d dist=%.2f sum=%d", (int)RED, d, sum);
        printf("%.*s\n", 5, s); /* print prefix */
    }
    return apply(add, 4, 5) == 9 ? EXIT_SUCCESS : EXIT_FAILURE;
}
