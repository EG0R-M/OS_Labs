#include <stdio.h>
#include <stdlib.h>
#include "fibonacci.h"

int main(int argc, char *argv[]) {
    int n = 10;
    if (argc > 1) {
        n = atoi(argv[1]);
    }
    
    printf("Вычисления для n = %d\n", n);
    printf("Факториал (итеративно): %llu\n", factorial_iter(n));
    printf("Факториал (рекурсивно): %llu\n", factorial_rec(n));
    printf("Число Фибоначчи (итеративно): %llu\n", fibonacci_iter(n));
    printf("Число Фибоначчи (рекурсивно): %llu\n", fibonacci_rec(n));
    
    return 0;
}