# ============================================================================
# ФАЙЛ: main_O2.s (ОПТИМИЗАЦИЯ -O2)
# ОСОБЕННОСТИ -O2:
# 1. Переменные живут в регистрах (нет обращений к стеку)
# 2. Нет пролога/эпилога для простых функций
# 3. Разворот циклов (loop unrolling)
# 4. Перестановка инструкций для конвейера
# 5. Выравнивание кода (.p2align)
# 6. Удаление мертвого кода
# ============================================================================

.file	"main.c"			# исходный файл
.text					# секция кода
.p2align 4,,15				# выравнивание до 16 байт
.globl	factorial_iter			# экспортируем символ factorial_iter
.def	factorial_iter;	.scl	2;	.type	32;	.endef
.seh_proc	factorial_iter		# начало SEH пролога (Windows)
factorial_iter:				# метка функции
.seh_endprologue			# конец SEH пролога
	cmpl	$1, %ecx		# сравниваем n (ecx) с 1
	jle	.L4			# если n <= 1, прыгаем на L4
	subl	$2, %ecx		# ecx = n - 2
	movl	$2, %edx		# edx = i = 2
	movl	$1, %eax		# eax = result = 1
	addq	$3, %rcx		# rcx = n + 1 (граница цикла)
.p2align 4,,10				# выравнивание для производительности
.L3:					# метка начала цикла
	imulq	%rdx, %rax		# result = result * i (умножение)
	addq	$1, %rdx		# i++ (инкремент счетчика)
	cmpq	%rcx, %rdx		# сравниваем i с n+1
	jne	.L3			# если не равны, повторяем цикл
	ret				# возвращаем результат (в rax)
.p2align 4,,10				# выравнивание
.L4:					# метка для n <= 1
	movl	$1, %eax		# return 1
	ret				# выход из функции
.seh_endproc				# конец SEH процедуры

.p2align 4,,15				# выравнивание
.globl	factorial_rec			# экспортируем символ
.def	factorial_rec;	.scl	2;	.type	32;	.endef
.seh_proc	factorial_rec		# начало SEH пролога
factorial_rec:				# метка функции
.seh_endprologue			# конец SEH пролога
	movl	$1, %eax		# eax = 1 (предполагаемый результат)
	cmpl	$1, %ecx		# сравниваем n с 1
	jle	.L7			# если n <= 1, прыгаем на L7
	leal	-2(%rcx), %eax		# eax = n - 2
	movslq	%ecx, %r8		# r8 = n (расширяем до 64-bit)
	leaq	-1(%r8), %rdx		# rdx = n - 1
	movq	%rdx, %rcx		# rcx = n - 1
	subq	%rax, %rcx		# rcx = (n-1) - (n-2) = 1
	movl	$1, %eax		# eax = 1 (аккумулятор)
	jmp	.L10			# прыгаем на L10
.p2align 4,,10				# выравнивание
.L11:					# метка тела цикла
	subq	$1, %rdx		# уменьшаем множитель на 1
.L10:					# метка входа в цикл
	imulq	%r8, %rax		# умножаем результат на текущий множитель
	cmpq	%rcx, %rdx		# сравниваем множитель с 1
	movq	%rdx, %r8		# r8 = текущий множитель
	jne	.L11			# если не равно 1, продолжаем цикл
.L7:					# метка выхода
	ret				# возврат результата
.seh_endproc				# конец SEH процедуры

.p2align 4,,15				# выравнивание
.globl	fibonacci_iter			# экспортируем символ
.def	fibonacci_iter;	.scl	2;	.type	32;	.endef
.seh_proc	fibonacci_iter		# начало SEH пролога
fibonacci_iter:				# метка функции
.seh_endprologue			# конец SEH пролога
	cmpl	$1, %ecx		# сравниваем n с 1
	movslq	%ecx, %rax		# rax = n (для возврата, если n<=1)
	jle	.L12			# если n <= 1, прыгаем на L12
	addl	$1, %ecx		# ecx = n + 1 (граница цикла)
	movl	$2, %r8d		# r8d = i = 2 (счетчик)
	movl	$1, %edx		# edx = b = 1 (F(i-1))
	xorl	%r9d, %r9d		# r9d = a = 0 (F(i-2)) XOR быстрее MOV
.p2align 4,,10				# выравнивание для производительности
.L15:					# метка начала цикла
	leaq	(%r9,%rdx), %rax	# rax = a + b (новое число Фибоначчи)
	addl	$1, %r8d		# i++ (инкремент счетчика)
	movq	%rdx, %r9		# r9 = b (старое b становится a)
	cmpl	%r8d, %ecx		# сравниваем i с n+1
	movq	%rax, %rdx		# rdx = c (b становится новым числом)
	jne	.L15			# если не дошли до конца, продолжаем
.L12:					# метка выхода
	ret				# возврат результата
.seh_endproc				# конец SEH процедуры

.def	__main;	.scl	2;	.type	32;	.endef

.section .rdata,"dr"			# секция read-only данных
.align 8					# выравнивание до 8 байт
.LC0:						# строка "Вычисления для n = %d\n"
.ascii "\320\222\321\213\321\207\320\270\321\201\320\273\320\265\320\275\320\270\321\217 \320\264\320\273\321\217 n = %d\12\0"
.align 8					# выравнивание
.LC1:						# строка "Факториал (итеративно): %llu\n"
.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\320\270\321\202\320\265\321\200\320\260\321\202\320\270\320\262\320\275\320\276): %llu\12\0"
.align 8					# выравнивание
.LC2:						# строка "Число Фибоначчи: %llu\n"
.ascii "\320\247\320\270\321\201\320\273\320\276 \320\244\320\270\320\261\320\276\320\275\320\260\321\207\321\207\320\270: %llu\12\0"
.align 8					# выравнивание
.LC3:						# строка "Факториал (рекурсивно): %llu\n"
.ascii "\320\244\320\260\320\272\321\202\320\276\321\200\320\270\320\260\320\273 (\321\200\320\265\320\272\321\203\321\200\321\201\320\270\320\262\320\275\320\276): %llu\12\0"

.section .text.startup,"x"		# секция кода startup
.p2align 4,,15				# выравнивание
.globl	main				# экспортируем main
.def	main;	.scl	2;	.type	32;	.endef
.seh_proc	main			# начало SEH пролога main
main:					# метка main
	pushq	%rsi			# сохраняем rsi (регистр argv)
	.seh_pushreg	%rsi		# SEH информация
	pushq	%rbx			# сохраняем rbx (регистр argc)
	.seh_pushreg	%rbx		# SEH информация
	subq	$40, %rsp		# выделяем 40 байт на стеке
	.seh_stackalloc	40		# SEH информация
	.seh_endprologue		# конец SEH пролога
	movl	%ecx, %ebx		# ebx = argc (сохраняем argc)
	movq	%rdx, %rsi		# rsi = argv (сохраняем argv)
	call	__main			# вызов конструкторов MinGW
	cmpl	$1, %ebx		# сравниваем argc с 1
	jg	.L18			# если argc > 1, прыгаем на L18
	movl	$10, %edx		# edx = 10 (n для printf)
	movl	$10, %ebx		# ebx = 10 (n для вычислений)
	leaq	.LC0(%rip), %rcx	# rcx = адрес строки форматирования
	call	printf			# printf("Вычисления для n = 10\n")
.L19:					# метка начала вычислений
	movl	$2, %eax		# eax = 2 (i)
	movl	$1, %edx		# edx = 1 (result)
.p2align 4,,10				# выравнивание
.L21:					# цикл факториала
	imulq	%rax, %rdx		# result = result * i
	addq	$1, %rax		# i++
	cmpl	%eax, %ebx		# сравниваем i и n
	jge	.L21			# если i <= n, продолжаем
	leaq	.LC1(%rip), %rcx	# rcx = адрес строки "Факториал (итеративно)"
	call	printf			# вывод результата
	leal	-2(%rbx), %edx		# edx = n - 2
	movslq	%ebx, %rcx		# rcx = n
	leaq	-1(%rcx), %rax		# rax = n - 1
	movq	%rax, %r8		# r8 = n - 1
	subq	%rdx, %r8		# r8 = 1
	movl	$1, %edx		# edx = 1
	jmp	.L23			# прыгаем на L23
.p2align 4,,10				# выравнивание
.L29:					# метка продолжения цикла
	subq	$1, %rax		# уменьшаем множитель
.L23:					# метка входа в цикл
	imulq	%rcx, %rdx		# умножаем
	cmpq	%r8, %rax		# сравниваем с 1
	movq	%rax, %rcx		# перемещаем множитель
	jne	.L29			# продолжаем
	leaq	.LC3(%rip), %rcx	# строка "Факториал (рекурсивно)"
	call	printf			# вывод результата
	addl	$1, %ebx		# ebx = n + 1
	movl	$2, %ecx		# ecx = 2 (i)
	movl	$1, %eax		# eax = 1 (b)
	xorl	%r8d, %r8d		# r8 = 0 (a)
.p2align 4,,10				# выравнивание
.L24:					# цикл Фибоначчи
	leaq	(%r8,%rax), %rdx	# rdx = a + b
	addl	$1, %ecx		# i++
	movq	%rax, %r8		# r8 = b
	cmpl	%ebx, %ecx		# сравниваем i с n+1
	movq	%rdx, %rax		# rax = c
	jne	.L24			# продолжаем
.L25:					# метка вывода
	leaq	.LC2(%rip), %rcx	# строка "Число Фибоначчи"
	call	printf			# вывод результата
	xorl	%eax, %eax		# eax = 0 (return 0)
	addq	$40, %rsp		# очищаем стек
	popq	%rbx			# восстанавливаем rbx
	popq	%rsi			# восстанавливаем rsi
	ret				# выход из main
.L18:					# обработка аргумента командной строки
	movq	8(%rsi), %rcx		# rcx = argv[1]
	call	atoi			# преобразуем строку в число
	leaq	.LC0(%rip), %rcx	# адрес строки заголовка
	movl	%eax, %ebx		# ebx = n
	movl	%eax, %edx		# edx = n для printf
	call	printf			# вывод заголовка
	cmpl	$1, %ebx		# сравниваем n с 1
	jg	.L19			# если n > 1, идем на вычисления
	leaq	.LC1(%rip), %rcx	# строка для факториала
	movl	$1, %edx		# результат = 1
	call	printf			# выводим 1
	movl	$1, %edx		# результат = 1
	leaq	.LC3(%rip), %rcx	# строка для рекурсивного
	call	printf			# выводим 1
	movslq	%ebx, %rdx		# rdx = n
	jmp	.L25			# выводим Фибоначчи и выходим
.seh_endproc				# конец SEH процедуры
.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
.def	printf;	.scl	2;	.type	32;	.endef
.def	atoi;	.scl	2;	.type	32;	.endef



# ===================================================================
                [Что ищем + Где находится + Пример строки]
Циклы:
.L3, .L15, .L21, .L24, .L29
jne .L3
-----------------------------
Переменные в регистрах:
%eax, %ebx, %ecx, %edx, %r8d, %r9d
movl $2, %edx
-----------------------------
Условные переходы:
jle, jg, jge, jne
jle .L4
-----------------------------
Безусловный переход:
jmp
jmp .L10
-----------------------------
Сравнения:
cmp, cmpl, cmpq
cmpl $1, %ecx
-----------------------------
Вызов функций:
call
call printf
-----------------------------
Строковые литералы:
.LC0, .LC1, .LC2, .LC3
.ascii "..."