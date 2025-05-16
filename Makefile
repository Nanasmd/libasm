# Configuration
NAME = libasm.a
CC = gcc
NASM = nasm
NASM_FLAGS = -f elf64
AR = ar
AR_FLAGS = rcs
RM = rm -f

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m

# Directories
MAND_DIR = mandatory
BONUS_DIR = bonus
TEST_DIR = tests

# Source files exactement comme dans votre structure
MAND_SRCS = ft_read.s \
            ft_strcmp.s \
            ft_strcpy.s \
            ft_strdup.s \
            ft_strlen.s \
            ft_write.s

BONUS_SRCS = ft_atoi_base.s \
             ft_list_push_front.s \
             ft_list_remove_if.s \
             ft_list_size.s \
             ft_list_sort.s

# Add directory prefix to source files
MAND_SRCS_PATH = $(addprefix $(MAND_DIR)/, $(MAND_SRCS))
BONUS_SRCS_PATH = $(addprefix $(BONUS_DIR)/, $(BONUS_SRCS))

# Object files
MAND_OBJS = $(MAND_SRCS_PATH:.s=.o)
BONUS_OBJS = $(BONUS_SRCS_PATH:.s=.o)

# Test files 
TEST_MAIN = $(TEST_DIR)/test_main.c
TEST_BONUS = $(TEST_DIR)/test_bonus.c
TEST_HEADERS = $(TEST_DIR)/libasm_test.h $(TEST_DIR)/list.h

# Build rules
%.o: %.s
	@printf "$(GREEN)Compiling $<...$(NC)\n"
	$(NASM) $(NASM_FLAGS) $< -o $@

all: $(NAME)

# Utilisation de règle à ordre unique pour éviter le relink
$(NAME): $(MAND_OBJS)
	@printf "$(GREEN)Creating library $(NAME)...$(NC)\n"
	$(AR) $(AR_FLAGS) $@ $?
	@printf "$(GREEN)Library $(NAME) created successfully$(NC)\n"

# Utilisation de $? pour ajouter uniquement les fichiers modifiés
bonus: $(NAME) $(BONUS_OBJS)
	@printf "$(GREEN)Adding bonus functions to library...$(NC)\n"
	$(AR) $(AR_FLAGS) $(NAME) $(BONUS_OBJS)
	@printf "$(GREEN)Bonus functions added successfully$(NC)\n"

# Tests
test: $(NAME)
	@printf "$(BLUE)Running mandatory tests...$(NC)\n"
	@if [ -f $(TEST_MAIN) ]; then \
		$(CC) -Wall -Wextra -Werror -o test_main $(TEST_MAIN) -L. -lasm; \
		./test_main; \
	else \
		printf "$(RED)Test file $(TEST_MAIN) not found.$(NC)\n"; \
	fi

test_bonus: bonus
	@printf "$(BLUE)Running bonus tests...$(NC)\n"
	@if [ -f $(TEST_BONUS) ]; then \
		$(CC) -Wall -Wextra -Werror -o test_bonus $(TEST_BONUS) -L. -lasm; \
		./test_bonus; \
	else \
		printf "$(RED)Test file $(TEST_BONUS) not found.$(NC)\n"; \
	fi

# Cleaning rules
clean:
	@printf "$(YELLOW)Cleaning object files...$(NC)\n"
	$(RM) $(MAND_OBJS) $(BONUS_OBJS)
	$(RM) test_main test_bonus

fclean: clean
	@printf "$(YELLOW)Cleaning library...$(NC)\n"
	$(RM) $(NAME)

re: fclean all

# Help target
help:
	@printf "$(GREEN)Available commands:$(NC)\n"
	@printf "  $(BLUE)make$(NC)          - Build the library\n"
	@printf "  $(BLUE)make bonus$(NC)    - Build with bonus functions\n"
	@printf "  $(BLUE)make test$(NC)     - Run tests for mandatory part\n"
	@printf "  $(BLUE)make test_bonus$(NC) - Run tests for bonus part\n"
	@printf "  $(BLUE)make clean$(NC)    - Remove object files\n"
	@printf "  $(BLUE)make fclean$(NC)   - Remove object files and library\n"
	@printf "  $(BLUE)make re$(NC)       - Rebuild the library\n"
	@printf "  $(BLUE)make help$(NC)     - Show this help message\n"

.PHONY: all bonus clean fclean re test test_bonus help