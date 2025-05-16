#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "libasm_test.h"
#include "list.h"

// Utility function to create a new integer
int *new_int(int value) {
    int *ptr = malloc(sizeof(int));
    if (ptr)
        *ptr = value;
    return ptr;
}

// Compare function for integers
int cmp_int(void *a, void *b) {
    return (*(int*)a - *(int*)b);
}

// Free function for integers
void free_int(void *data) {
    free(data);
}

// Print list of integers
void print_list(t_list *list) {
    printf("[");
    while (list) {
        printf("%d", *(int*)list->data);
        list = list->next;
        if (list)
            printf(", ");
    }
    printf("]\n");
}

// Free entire list
void free_list(t_list *list) {
    t_list *tmp;
    while (list) {
        tmp = list->next;
        free_int(list->data);
        free(list);
        list = tmp;
    }
}

// Test ft_atoi_base
void test_atoi_base() {
    printf("\n===== Testing ft_atoi_base =====\n");
    
    struct {
        char *str;
        char *base;
        int expected;
    } tests[] = {
        {"42", "0123456789", 42},
        {"2a", "0123456789abcdef", 42},
        {"-101010", "01", -42},
        {"   +42", "0123456789", 42},
        {"\t\n\r\f\v-42", "0123456789", -42},
        {"-2A", "0123456789ABCDEF", -42},
        {"invalid", "01", 0},
        {"42", "0", 0},                  // Invalid base (too short)
        {"42", "011", 0},                // Invalid base (duplicate)
        {"42", "0+", 0},                 // Invalid base (has '+')
        {"42", "0-", 0},                 // Invalid base (has '-')
        {"42", "0 ", 0},                 // Invalid base (has space)
        {"++42", "0123456789", 42},      // Multiple + signs
        {"+-42", "0123456789", -42}      // +- signs
    };
    
    for (size_t i = 0; i < sizeof(tests)/sizeof(tests[0]); i++) {
        int result = ft_atoi_base(tests[i].str, tests[i].base);
        printf("Test %zu: str=\"%s\", base=\"%s\"\n", i + 1, tests[i].str, tests[i].base);
        printf("  Expected: %d, Got: %d - %s\n\n", 
               tests[i].expected, result,
               (result == tests[i].expected) ? "OK" : "KO");
    }
}

// Test ft_list_push_front
void test_list_push_front() {
    printf("\n===== Testing ft_list_push_front =====\n");
    
    // Test with empty list
    printf("Test 1: Push to empty list\n");
    t_list *list = NULL;
    ft_list_push_front(&list, new_int(42));
    printf("  Expected: [42], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list && *(int*)list->data == 42 && list->next == NULL) ? "OK" : "KO");
    
    // Test push to non-empty list
    printf("Test 2: Push to non-empty list\n");
    ft_list_push_front(&list, new_int(21));
    printf("  Expected: [21, 42], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list && *(int*)list->data == 21 && 
                               list->next && *(int*)list->next->data == 42) ? "OK" : "KO");
    
    // Test multiple pushes
    printf("Test 3: Multiple pushes\n");
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(5));
    printf("  Expected: [5, 10, 21, 42], Got: ");
    print_list(list);
    
    // Clean up
    free_list(list);
}

// Test ft_list_size
void test_list_size() {
    printf("\n===== Testing ft_list_size =====\n");
    
    // Test with NULL list
    printf("Test 1: NULL list\n");
    t_list *list = NULL;
    int size = ft_list_size(list);
    printf("  Expected: 0, Got: %d - %s\n\n", size, (size == 0) ? "OK" : "KO");
    
    // Test with single element
    printf("Test 2: Single element list\n");
    ft_list_push_front(&list, new_int(42));
    size = ft_list_size(list);
    printf("  Expected: 1, Got: %d - %s\n\n", size, (size == 1) ? "OK" : "KO");
    
    // Test with multiple elements
    printf("Test 3: Multiple element list\n");
    ft_list_push_front(&list, new_int(21));
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(5));
    size = ft_list_size(list);
    printf("  Expected: 4, Got: %d - %s\n\n", size, (size == 4) ? "OK" : "KO");
    
    // Clean up
    free_list(list);
}

// Test ft_list_sort
void test_list_sort() {
    printf("\n===== Testing ft_list_sort =====\n");
    
    // Test with NULL list
    printf("Test 1: NULL list\n");
    t_list *list = NULL;
    ft_list_sort(&list, cmp_int);
    printf("  Expected: [], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list == NULL) ? "OK" : "KO");
    
    // Test with single element
    printf("Test 2: Single element list\n");
    ft_list_push_front(&list, new_int(42));
    ft_list_sort(&list, cmp_int);
    printf("  Expected: [42], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list && *(int*)list->data == 42 && list->next == NULL) ? "OK" : "KO");
    free_list(list);
    list = NULL;
    
    // Test with already sorted list
    printf("Test 3: Already sorted list\n");
    ft_list_push_front(&list, new_int(30));
    ft_list_push_front(&list, new_int(20));
    ft_list_push_front(&list, new_int(10));
    ft_list_sort(&list, cmp_int);
    printf("  Expected: [10, 20, 30], Got: ");
    print_list(list);
    free_list(list);
    list = NULL;
    
    // Test with reverse sorted list
    printf("Test 4: Reverse sorted list\n");
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(20));
    ft_list_push_front(&list, new_int(30));
    ft_list_sort(&list, cmp_int);
    printf("  Expected: [10, 20, 30], Got: ");
    print_list(list);
    free_list(list);
    list = NULL;
    
    // Test with random order list
    printf("Test 5: Random order list\n");
    ft_list_push_front(&list, new_int(30));
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(50));
    ft_list_push_front(&list, new_int(20));
    ft_list_push_front(&list, new_int(40));
    ft_list_sort(&list, cmp_int);
    printf("  Expected: [10, 20, 30, 40, 50], Got: ");
    print_list(list);
    
    // Clean up
    free_list(list);
}

// Test ft_list_remove_if
void test_list_remove_if() {
    printf("\n===== Testing ft_list_remove_if =====\n");
    
    // Test with NULL list
    printf("Test 1: NULL list\n");
    t_list *list = NULL;
    int ref = 42;
    ft_list_remove_if(&list, &ref, cmp_int, free_int);
    printf("  Expected: [], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list == NULL) ? "OK" : "KO");
    
    // Test with single matching element
    printf("Test 2: Single matching element\n");
    ft_list_push_front(&list, new_int(42));
    ft_list_remove_if(&list, &ref, cmp_int, free_int);
    printf("  Expected: [], Got: ");
    print_list(list);
    printf("  Result: %s\n\n", (list == NULL) ? "OK" : "KO");
    
    // Test with multiple elements, one match
    printf("Test 3: Multiple elements, one match\n");
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(42));
    ft_list_push_front(&list, new_int(30));
    ft_list_remove_if(&list, &ref, cmp_int, free_int);
    printf("  Expected: [30, 10], Got: ");
    print_list(list);
    free_list(list);
    list = NULL;
    
    // Test with multiple elements, multiple matches
    printf("Test 4: Multiple elements, multiple matches\n");
    ft_list_push_front(&list, new_int(42));
    ft_list_push_front(&list, new_int(10));
    ft_list_push_front(&list, new_int(42));
    ft_list_push_front(&list, new_int(30));
    ft_list_push_front(&list, new_int(42));
    ft_list_remove_if(&list, &ref, cmp_int, free_int);
    printf("  Expected: [30, 10], Got: ");
    print_list(list);
    
    // Clean up
    free_list(list);
}

int main(void) {
    printf("========== LIBASM BONUS TESTER ==========\n");
    
    test_atoi_base();
    test_list_push_front();
    test_list_size();
    test_list_sort();
    test_list_remove_if();
    
    printf("\n========== ALL BONUS TESTS COMPLETED ==========\n");
    return 0;
}