CXX=clang++
CXXFLAGS=-g -std=c++17
INCLUDES=-I./hazel/src -I./hazel/vendor/GLFW/include -I./hazel/vendor/glad/include -I./hazel/vendor/spdlog/include -I./hazel/vendor/imgui -I./hazel/vendor/glm
FRAMEWORKS=-framework Cocoa -framework IOKit
LIBS=-L./hazel/vendor/GLFW/src -lglfw3 -L./hazel/vendor/glad/src -lglad -L./hazel/vendor/imgui -limgui
DEFINES=-DGLFW_INCLUDE_NONE

SRC=hazel/src
OBJ=hazel/obj
HZ_SOURCES=$(shell find $(SRC) -type f -name *.cpp)
HZ_OBJECTS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(HZ_SOURCES))
HAZEL_BIN=hazel/bin/libhazel.a
SANDBOX_BIN=sandbox/bin/sandbox
PCH=hzpch.h

all: $(HAZEL_BIN) $(SANDBOX_BIN)

$(HAZEL_BIN): $(HZ_OBJECTS)
	mkdir -p $(dir $@)
	ar rv $(HAZEL_BIN) $(HZ_OBJECTS)
	ranlib $(HAZEL_BIN)

$(OBJ)/%.o: $(SRC)/%.cpp $(OBJ)/$(PCH).pch
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ)/$(PCH).pch $(INCLUDES) $(DEFINES) -c $< -o $@

$(OBJ)/$(PCH).pch: $(SRC)/$(PCH)
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -x c++-header $^ -o $@

$(SANDBOX_BIN):
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(FRAMEWORKS) $(LIBS) -o $@ sandbox/src/SandboxApp.cpp $(HAZEL_BIN)

clean:
	rm -r hazel/bin hazel/obj sandbox/bin
