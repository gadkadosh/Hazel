CXX=clang++
CXXFLAGS=-g -std=c++17
INCLUDES=-I./hazel/src -I./hazel/vendor/GLFW/include -I./hazel/vendor/glad/include -I./hazel/vendor/spdlog/include -I./hazel/vendor/imgui -I./hazel/vendor/glm
FRAMEWORKS=-framework Cocoa -framework IOKit
LIBS=-L./hazel/vendor/GLFW/src -lglfw3 -L./hazel/vendor/glad/src -lglad -L./hazel/vendor/imgui -limgui
DEFINES=-DGLFW_INCLUDE_NONE

SRC_DIR=hazel/src
OBJ_DIR=hazel/obj
SRCS=$(shell find $(SRC_DIR) -type f -name *.cpp)
PCH=hzpch.h
OBJS=$(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))
HAZEL_BIN=hazel/bin/libhazel.a
SANDBOX_BIN=sandbox/bin/sandbox

all: $(HAZEL_BIN) $(SANDBOX_BIN)

$(HAZEL_BIN): $(OBJS)
	mkdir -p $(dir $@)
	ar rv $(HAZEL_BIN) $(OBJS)
	ranlib $(HAZEL_BIN)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(OBJ_DIR)/$(PCH).pch
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ_DIR)/$(PCH).pch $(INCLUDES) $(DEFINES) -c $< -o $@

$(OBJ_DIR)/$(PCH).pch: $(SRC_DIR)/$(PCH)
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -x c++-header $^ -o $@

$(SANDBOX_BIN): $(HAZEL_BIN)
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(FRAMEWORKS) $(LIBS) -o $@ sandbox/src/SandboxApp.cpp $(HAZEL_BIN)

clean:
	rm -r hazel/bin hazel/obj sandbox/bin
