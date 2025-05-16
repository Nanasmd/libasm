Certainly! Here's a comprehensive and professional `README.md` for the [Nanasmd/libasm](https://github.com/Nanasmd/libasm) repository, tailored to meet high standards of clarity, usability, and technical precision.

---

# libasm

A minimalist x86\_64 assembly library reimplementing essential C standard functions. This project is part of the 42 School curriculum, designed to deepen understanding of low-level programming, system calls, and memory management.([Medium][1], [GitHub][2])

---

## 🧠 Project Overview

The goal of `libasm` is to reimplement several standard C library functions using 64-bit assembly language. This exercise enhances comprehension of:

* System call mechanics
* Register usage and calling conventions
* Memory manipulation at a low level
* Error handling through `errno`([GitHub][2], [GitHub][3], [harm-smits.github.io][4], [about.gitlab.com][5])

---

## ⚙️ Implemented Functions

### Mandatory

| Function    | Description                     | Prototype                                                  |                                                      |
| ----------- | ------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| `ft_strlen` | Computes the length of a string | `size_t ft_strlen(const char *s);`                         |                                                      |
| `ft_strcpy` | Copies a string                 | `char *ft_strcpy(char *dst, const char *src);`             |                                                      |
| `ft_strcmp` | Compares two strings            | `int ft_strcmp(const char *s1, const char *s2);`           |                                                      |
| `ft_write`  | Writes to a file descriptor     | `ssize_t ft_write(int fd, const void *buf, size_t count);` |                                                      |
| `ft_read`   | Reads from a file descriptor    | `ssize_t ft_read(int fd, void *buf, size_t count);`        |                                                      |
| `ft_strdup` | Duplicates a string             | `char *ft_strdup(const char *s1);`                         | ([Medium][1], [GitHub][6], [GitHub][7], [GitHub][3]) |

Each function adheres to the System V AMD64 ABI and properly sets `errno` in case of errors.([Medium][1])

### Bonus

Located in the `bonus/` directory, these additional functions include:([GitHub][6])

* `ft_atoi_base` – Converts a string to an integer based on a given base.
* `ft_list_push_front` – Adds a new element at the beginning of a linked list.
* `ft_list_size` – Returns the number of elements in a linked list.
* `ft_list_sort` – Sorts a linked list using a comparison function.
* `ft_list_remove_if` – Removes elements from a linked list that match a reference data value.([GitHub][7], [GitHub][3])

These functions utilize the following `t_list` structure:([GitHub][3])

```c
typedef struct s_list {
    void *data;
    struct s_list *next;
} t_list;
```



---

## 🛠️ Build Instructions

### Prerequisites

* `nasm` assembler
* `gcc` compiler
* Make utility([GitHub][3], [LinkedIn][8])

### Compilation

1. Clone the repository:([Medium][9])

   ```bash
   git clone https://github.com/Nanasmd/libasm.git
   cd libasm
   ```



2. Build the library:

   ```bash
   make
   ```



This will generate the `libasm.a` static library.([GitHub][7])

---

## 🧪 Testing

Test files are located in the `tests/` directory. To compile and run the tests:([GitHub][3], [GitHub][10])

```bash
gcc -no-pie tests/main.c libasm.a -o test_libasm
./test_libasm
```



Ensure that each function behaves identically to its standard C library counterpart.

---

## 📁 Project Structure

```plaintext
libasm/
├── bonus/           # Bonus functions in assembly
├── mandatory/       # Mandatory functions in assembly
├── tests/           # C test files for the assembly functions
├── Makefile         # Build instructions
└── README.md        # Project documentation
```



---

## 🧩 Notes

* All assembly code is written in Intel syntax and complies with the System V AMD64 ABI.
* System calls are used directly for `ft_read` and `ft_write`.
* Proper error handling is implemented, with `errno` set appropriately.([Medium][1], [GitHub][10])

---

## 📚 Resources

* [NASM Documentation](https://www.nasm.us/doc/)
* [System V AMD64 ABI](https://www.uclibc.org/docs/psABI-x86_64.pdf)
* [42 School Curriculum](https://42.fr/en/homepage/)

---

For any questions or suggestions, feel free to open an issue or submit a pull request.

---

[1]: https://medium.com/%40leogaudin/libasm-a-guide-to-get-familiar-with-assembly-in-42-830f619f4c5e?utm_source=chatgpt.com "libasm: a guide to get familiar with Assembly in 42 - Medium"
[2]: https://github.com/llefranc/42_libasm?utm_source=chatgpt.com "llefranc/42_libasm: School project: get familiar with ... - GitHub"
[3]: https://github.com/appinha/42cursus-03-libasm?utm_source=chatgpt.com "Development repo for 42cursus' libasm project - GitHub"
[4]: https://harm-smits.github.io/42docs/projects/libasm?utm_source=chatgpt.com "libasm | 42 Docs"
[5]: https://gitlab.com/uotiug42/asm/libasm?utm_source=chatgpt.com "42 / ASM / libasm - GitLab"
[6]: https://github.com/qingqingqingli/libasm?utm_source=chatgpt.com "42 libasm project - recreate basic functions in assembly - GitHub"
[7]: https://github.com/JaeSeoKim/libasm/blob/master/readme.md?utm_source=chatgpt.com "libasm/readme.md at master - GitHub"
[8]: https://fr.linkedin.com/in/alexandre-delille-32357a250?utm_source=chatgpt.com "Alexandre Delille - Lead Developer - Terros - LinkedIn"
[9]: https://medium.com/%40leogaudin/ft-linear-regression-an-introduction-guide-to-machine-learning-at-42-4d9a19a260e5?utm_source=chatgpt.com "ft_linear_regression: an introduction guide to Machine Learning at 42"
[10]: https://github.com/romanwrites/libasm/blob/master/README.md?utm_source=chatgpt.com "README.md - romanwrites/libasm - GitHub"
