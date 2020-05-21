.syntax unified
.cpu cortex-m4
.thumb

#define P0_DATA #2
#define P1_DATA #3
#define P2_DATA #2
#define P3_DATA #3


// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
data: .asciz "kernel started!\n"
final: .asciz "Value in register #5: "

.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

//calculation
// (a&b) >> + c!

lab2:
	push {lr}
	//calc
	mov r0, P0_DATA
	mov r1, P1_DATA
	mov r2, P2_DATA
	mov r3, P3_DATA
	bl Calc
	pop {pc}
Calc:
	push {r4, r5, lr}
	mov r4, r0
	//save D0
	rev r0, r0
	and r1, r2
	lsr r1, 1
	adds r0, r1
	//calc factorial
	mov r5, r0
	mov r0, r4
	//D0
	//bl Factorial
	add r0, r5
	pop {r4, r5, pc}

ldr r0, =final
bl dbgput
mov r0, r5
bl dbgput_num

end:
b end

Factorial:
	push {r4}
	mov r4, 3
	.fact_calc:
		mul r4, r0
		subs r0, #1
		bne .fact_calc
	mov r0, r4
	pop {r4}
	bx lr



