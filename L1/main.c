#include <stdio.h>
#include <stdlib.h>

// Функция 1: вычисление факториала (итеративно с циклом)
unsigned long long factorial_iter(int n) {
    unsigned long long result = 1;
    for (int i = 2; i <= n; i++) {
        result = result * i;
    }
    return result;
}

// Функция 2: вычисление факториала (рекурсивно)
unsigned long long factorial_rec(int n) {
    if (n <= 1) return 1;
    return n * factorial_rec(n - 1);
}

// Функция 3: числа Фибоначчи (с циклом for)
unsigned long long fibonacci_iter(int n) {
    if (n <= 1) return n;
    unsigned long long a = 0, b = 1, c;
    for (int i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}

int main(int argc, char *argv[]) {
    int n = 10;
    if (argc > 1) {
        n = atoi(argv[1]);
    }
    
    printf("Вычисления для n = %d\n", n);
    printf("Факториал (итеративно): %llu\n", factorial_iter(n));
    printf("Факториал (рекурсивно): %llu\n", factorial_rec(n));
    printf("Число Фибоначчи: %llu\n", fibonacci_iter(n));
    
    return 0;
}