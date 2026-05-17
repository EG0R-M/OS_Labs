#include "fibonacci.h"

// Итеративный факториал (с циклом for)
unsigned long long factorial_iter(int n) {
    unsigned long long result = 1;
    for (int i = 2; i <= n; i++) {
        result = result * i;
    }
    return result;
}

// Рекурсивный факториал
unsigned long long factorial_rec(int n) {
    if (n <= 1) return 1;
    return n * factorial_rec(n - 1);
}

// Итеративный Фибоначчи (с циклом for)
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

// Рекурсивный Фибоначчи
unsigned long long fibonacci_rec(int n) {
    if (n <= 1) return n;
    return fibonacci_rec(n - 1) + fibonacci_rec(n - 2);
}