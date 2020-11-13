strings_test:
    call strcmp_test
    ret

; pointer to address name string string
strings_test_name dw 0
strings_test_failed db " failed", 0x0a, 0x0d, 0

strcmp_test:
    mov word [strings_test_name], strcmp_test_equal
    push strcmp_eq_a
    push strcmp_eq_b
    call strcmp
    cmp ax, 1
    jne strcmp_test_fail
    
    mov word [strings_test_name], strcmp_test_inequal
    push strcmp_ineq_a
    push strcmp_ineq_b
    call strcmp
    cmp ax, 0
    jne strcmp_test_fail

    mov word [strings_test_name], strcmp_test_null_equal
    push strcmp_null_eq_a
    push strcmp_null_eq_b
    call strcmp
    cmp ax, 1
    jne strcmp_test_fail

    mov word [strings_test_name], strcmp_test_null_inequal
    push strcmp_null_ineq_a
    push strcmp_null_ineq_b
    call strcmp
    cmp ax, 0
    jne strcmp_test_fail

    ret

    strcmp_test_fail:
        push word [strings_test_name]
        call serial_write_string
        
        push strings_test_failed
        call serial_write_string
        ret


strcmp_test_equal db "strcmp 'abc1234' == 'abc1234'", 0
strcmp_eq_a db "abc1234", 0
strcmp_eq_b db "abc1234", 0

strcmp_test_inequal db "strcmp '1234' != 'hi'", 0
strcmp_ineq_a db "1234", 0
strcmp_ineq_b db "hi", 0

strcmp_test_null_equal db "strcmp '' == ''", 0
strcmp_null_eq_a db 0
strcmp_null_eq_b db 0

strcmp_test_null_inequal db "strcmp '' != 'abc'", 0
strcmp_null_ineq_a db 0
strcmp_null_ineq_b db "abc", 0

startswith_test:
    mov word [strings_test_name], startswith_test_equal
    push startswith_eq_a
    push startswith_eq_b
    call startswith
    cmp ax, 1
    jne startswith_test_fail
    
    mov word [strings_test_name], startswith_test_inequal
    push startswith_ineq_a
    push startswith_ineq_b
    call startswith
    cmp ax, 0
    jne startswith_test_fail

    mov word [strings_test_name], startswith_test_null_equal
    push startswith_null_eq_a
    push startswith_null_eq_b
    call startswith
    cmp ax, 1
    jne startswith_test_fail

    mov word [strings_test_name], startswith_test_null_inequal
    push startswith_null_ineq_a
    push startswith_null_ineq_b
    call startswith
    cmp ax, 0
    jne startswith_test_fail

    ret

    startswith_test_fail:
        push word [strings_test_name]
        call serial_write_string
        
        push strings_test_failed
        call serial_write_string
        ret


startswith_test_equal db "startswith 'abc1234', 'abc'", 0
startswith_eq_a db "abc1234", 0
startswith_eq_b db "abc", 0

startswith_test_inequal db "startswith 'hello', 'hi'", 0
startswith_ineq_a db "hello", 0
startswith_ineq_b db "hi", 0

startswith_test_null_equal db "startswith '', ''", 0
startswith_null_eq_a db 0
startswith_null_eq_b db 0

startswith_test_null_inequal db "startswith '', 'abc'", 0
startswith_null_ineq_a db 0
startswith_null_ineq_b db "abc", 0