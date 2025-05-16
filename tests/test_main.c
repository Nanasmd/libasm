#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include "libasm_test.h"

void test_ft_strlen(void) {
    printf("\n===== Testing ft_strlen =====\n");
    const char *tests[] = {"", "Hello", "This is a test", "Test with\0hidden nulls"};
    
    for (int i = 0; i < 4; i++) {
        size_t lib_result = strlen(tests[i]);
        size_t ft_result = ft_strlen(tests[i]);
        printf("Test %d: \"%s\"\n", i + 1, tests[i]);
        printf("  strlen: %zu, ft_strlen: %zu - %s\n\n", 
               lib_result, ft_result, 
               (lib_result == ft_result) ? "OK" : "KO");
    }
}

void test_ft_strcpy(void) {
    printf("\n===== Testing ft_strcpy =====\n");
    const char *tests[] = {"", "Hello", "Test with spaces", "Multiple\nLines"};
    char buffer1[100];
    char buffer2[100];
    
    for (int i = 0; i < 4; i++) {
        char *lib_result = strcpy(buffer1, tests[i]);
        char *ft_result = ft_strcpy(buffer2, tests[i]);
        
        printf("Test %d: \"%s\"\n", i + 1, tests[i]);
        printf("  strcpy: \"%s\", ft_strcpy: \"%s\" - %s\n", 
               buffer1, buffer2, 
               (strcmp(buffer1, buffer2) == 0) ? "OK" : "KO");
        printf("  Return value check: %s\n\n", 
               (buffer2 == ft_result) ? "OK" : "KO");
    }
}

void test_ft_strcmp(void) {
    printf("\n===== Testing ft_strcmp =====\n");
    struct {
        const char *s1;
        const char *s2;
    } tests[] = {
        {"", ""}, {"Hello", "Hello"}, {"Hello", "World"}, 
        {"abc", "abd"}, {"Hello", ""}, {"", "Hello"}
    };
    
    for (int i = 0; i < 6; i++) {
        int lib_result = strcmp(tests[i].s1, tests[i].s2);
        int ft_result = ft_strcmp(tests[i].s1, tests[i].s2);
        
        printf("Test %d: \"%s\" vs \"%s\"\n", i + 1, tests[i].s1, tests[i].s2);
        printf("  strcmp: %d, ft_strcmp: %d - ", lib_result, ft_result);
        
        if ((lib_result < 0 && ft_result < 0) || 
            (lib_result > 0 && ft_result > 0) || 
            (lib_result == 0 && ft_result == 0)) {
            printf("OK\n\n");
        } else {
            printf("KO\n\n");
        }
    }
}

void test_ft_write(void) {
    printf("\n===== Testing ft_write =====\n");
    const char *test_str = "Hello, world!";
    int len = strlen(test_str);
    
    // Test valid file descriptor
    printf("Test 1: Writing to stdout\n");
    printf("  Original write: ");
    int lib_result = write(1, test_str, len);
    printf("\n  ft_write: ");
    int ft_result = ft_write(1, test_str, len);
    printf("\n  Return values - write: %d, ft_write: %d - %s\n\n", 
           lib_result, ft_result, 
           (lib_result == ft_result) ? "OK" : "KO");
    
    // Test invalid file descriptor
    printf("Test 2: Invalid file descriptor\n");
    lib_result = write(-1, test_str, len);
    int lib_errno = errno;
    errno = 0;
    ft_result = ft_write(-1, test_str, len);
    int ft_errno = errno;
    
    printf("  Return values - write: %d (errno: %d), ft_write: %d (errno: %d) - %s\n\n", 
           lib_result, lib_errno, ft_result, ft_errno, 
           (lib_result == ft_result && lib_errno == ft_errno) ? "OK" : "KO");
}

void test_ft_read(void) {
    printf("\n===== Testing ft_read =====\n");
    
    // Create a test file
    int fd = open("test.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    write(fd, "Hello, world!", 13);
    close(fd);
    
    // Test valid read
    char buffer1[20] = {0};
    char buffer2[20] = {0};
    
    fd = open("test.txt", O_RDONLY);
    int lib_result = read(fd, buffer1, 13);
    close(fd);
    
    fd = open("test.txt", O_RDONLY);
    int ft_result = ft_read(fd, buffer2, 13);
    close(fd);
    
    printf("Test 1: Reading from file\n");
    printf("  read: \"%s\" (ret: %d), ft_read: \"%s\" (ret: %d) - %s\n\n", 
           buffer1, lib_result, buffer2, ft_result, 
           (strcmp(buffer1, buffer2) == 0 && lib_result == ft_result) ? "OK" : "KO");
    
    // Test invalid file descriptor
    lib_result = read(-1, buffer1, 13);
    int lib_errno = errno;
    errno = 0;
    ft_result = ft_read(-1, buffer2, 13);
    int ft_errno = errno;
    
    printf("Test 2: Invalid file descriptor\n");
    printf("  Return values - read: %d (errno: %d), ft_read: %d (errno: %d) - %s\n\n", 
           lib_result, lib_errno, ft_result, ft_errno, 
           (lib_result == ft_result && lib_errno == ft_errno) ? "OK" : "KO");
    
    // Clean up
    unlink("test.txt");
}

void test_ft_strdup(void) {
    printf("\n===== Testing ft_strdup =====\n");
    const char *tests[] = {"", "Hello", "A longer test string"};
    
    for (int i = 0; i < 3; i++) {
        char *lib_result = strdup(tests[i]);
        char *ft_result = ft_strdup(tests[i]);
        
        printf("Test %d: \"%s\"\n", i + 1, tests[i]);
        printf("  strdup: \"%s\", ft_strdup: \"%s\" - %s\n\n", 
               lib_result, ft_result, 
               (strcmp(lib_result, ft_result) == 0) ? "OK" : "KO");
        
        free(lib_result);
        free(ft_result);
    }
}

int main(void) {
    printf("========== LIBASM TESTER ==========\n");
    
    test_ft_strlen();
    test_ft_strcpy();
    test_ft_strcmp();
    test_ft_write();
    test_ft_read();
    test_ft_strdup();
    
    printf("\n========== ALL TESTS COMPLETED ==========\n");
    return 0;
}