# Output file name
BIN_NAME = ndstool

# Dirs with source code
COMMON_SRC_DIR = source

# Find all .c and .s files
COMMON_SRC_FILES = $(wildcard $(COMMON_SRC_DIR)/*.cpp) $(wildcard $(COMMON_SRC_DIR)/*.c)

CFLAGS =	-Wall

# List all object files
OBJ_FILES =  $(patsubst %.cpp,%.o, $(patsubst %.c,%.o, $(COMMON_SRC_FILES)))

# Build rules
$(BIN_NAME): $(OBJ_FILES)
	$(CXX) -o $@ $^

%.o: %.cpp
	$(CXX) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# General rules
.PHONY: all clean rebuild install

all: $(BIN_NAME)

clean:
	rm -rf $(OBJ_FILES) $(BIN_NAME)

rebuild: clean all

PREFIX ?= /usr/local
install: $(BIN_NAME)
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 $(BIN_NAME) $(DESTDIR)$(PREFIX)/bin/
