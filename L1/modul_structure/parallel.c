#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include "fibonacci.h"

// Структура для передачи данных в процесс
struct ProcessData {
    int n;
    char task[20];
};

// Функция, которую будет выполнять дочерний процесс
void do_work(int n, const char* task) {
    // Открываем мьютекс
    HANDLE hMutex = OpenMutex(SYNCHRONIZE, FALSE, "Global\\LabMutex");
    
    if (hMutex == NULL) {
        return;
    }
    
    WaitForSingleObject(hMutex, INFINITE);
    
    FILE* f = fopen("result.txt", "a");
    if (f != NULL) {
        if (strcmp(task, "factorial") == 0) {
            fprintf(f, "Факториал %d:\n", n);
            fprintf(f, "  Итеративно: %llu\n", factorial_iter(n));
            fprintf(f, "  Рекурсивно: %llu\n", factorial_rec(n));
            fprintf(f, "\n");
        } else if (strcmp(task, "fibonacci") == 0) {
            fprintf(f, "Число Фибоначчи %d: %llu\n", n, fibonacci_iter(n));
            fprintf(f, "\n");
        }
        fclose(f);
    }
    
    ReleaseMutex(hMutex);
    CloseHandle(hMutex);
}

int main(int argc, char *argv[]) {
    // Определяем, как запущена программа
    if (argc == 3) {
        // Запущена как дочерний процесс
        int n = atoi(argv[1]);
        do_work(n, argv[2]);
        return 0;
    }
    
    // Запущена как родительский процесс
    int n = 10;
    if (argc > 1) {
        n = atoi(argv[1]);
    }
    
    printf("ПАРАЛЛЕЛЬНЫЕ ПРОЦЕССЫ ДЛЯ n = %d\n", n);
    
    // Создаем мьютекс
    HANDLE hMutex = CreateMutex(NULL, FALSE, "Global\\LabMutex");
    
    // Создаем/очищаем общий файл
    FILE* f = fopen("result.txt", "w");
    fprintf(f, "РЕЗУЛЬТАТЫ ВЫЧИСЛЕНИЙ\n\n");
    fclose(f);
    
    // Получаем путь к текущему исполняемому файлу
    char exe_path[MAX_PATH];
    GetModuleFileName(NULL, exe_path, MAX_PATH);
    
    // Запускаем дочерний процесс для факториала
    char cmd1[MAX_PATH + 50];
    sprintf(cmd1, "\"%s\" %d factorial", exe_path, n);
    
    STARTUPINFO si1 = { sizeof(si1) };
    PROCESS_INFORMATION pi1;
    CreateProcess(NULL, cmd1, NULL, NULL, FALSE, 0, NULL, NULL, &si1, &pi1);
    
    // Запускаем дочерний процесс для Фибоначчи
    char cmd2[MAX_PATH + 50];
    sprintf(cmd2, "\"%s\" %d fibonacci", exe_path, n);
    
    STARTUPINFO si2 = { sizeof(si2) };
    PROCESS_INFORMATION pi2;
    CreateProcess(NULL, cmd2, NULL, NULL, FALSE, 0, NULL, NULL, &si2, &pi2);
    
    // Ждем завершения процессов
    WaitForSingleObject(pi1.hProcess, INFINITE);
    WaitForSingleObject(pi2.hProcess, INFINITE);
    
    // Закрываем handles
    CloseHandle(pi1.hProcess);
    CloseHandle(pi1.hThread);
    CloseHandle(pi2.hProcess);
    CloseHandle(pi2.hThread);
    CloseHandle(hMutex);
    
    // Выводим результат
    printf("\nРЕЗУЛЬТАТ ИЗ ОБЩЕГО ФАЙЛА\n");
    char buffer[256];
    FILE* out = fopen("result.txt", "r");
    while (fgets(buffer, sizeof(buffer), out)) {
        printf("%s", buffer);
    }
    fclose(out);
    
    return 0;
}