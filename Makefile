CC=clang++
CFLAGS=

SRC=hazel/src
OBJ=hazel/obj
SRCS=$(wildcard $(SRC)/*.cpp)
OBJS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(SRCS))
HAZEL_BIN=hazel/bin/libhazel.so
SANDBOX_BIN=sandbox/bin/sandbox

all: $(HAZEL_BIN) $(SANDBOX_BIN)

hazel: $(HAZEL_BIN)
sandbox: $(SANDBOX_BIN)

release: CFLAGS=-Wall -O2
release: clean
release: $(HAZEL_BIN)

$(OBJ)/%.o: $(SRC)/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

$(HAZEL_BIN): $(OBJS)
	$(CC) $(CFLAGS) -shared -fPIC $(OBJS) -o $@

$(SANDBOX_BIN):
	$(CC) $(CFLAGS) -I./hazel/src -L./hazel/bin -lhazel -o sandbox/bin/sandbox sandbox/src/SandboxApp.cpp

clean:
	rm -r hazel/bin/* hazel/obj/* sandbox/bin/* sandbox/obj/*
