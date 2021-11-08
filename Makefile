CXX=clang++
CXXFLAGS=-g -std=c++17
INCLUDES=-I./Hazel/src -I./Hazel/vendor/GLFW/include -I./Hazel/vendor/glad/include -I./Hazel/vendor/spdlog/include -I./Hazel/vendor/imgui -I./Hazel/vendor/glm
FRAMEWORKS=-framework Cocoa -framework OpenGL -framework IOKit 
DEFINES=-DGLFW_INCLUDE_NONE

SRC=Hazel/src
OBJ=Hazel/obj
SOURCES=$(shell find $(SRC) -type f -name *.cpp)
OBJECTS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(SOURCES))
HAZEL_BIN=Hazel/bin/libhazel.dylib
SANDBOX_BIN=sandbox/bin/sandbox
PCH=hzpch.h

all: $(HAZEL_BIN) $(SANDBOX_BIN)

$(HAZEL_BIN): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(FRAMEWORKS) -L./Hazel/vendor/GLFW/src -L./Hazel/vendor/glad/src -L./Hazel/vendor/imgui -lglfw3 -lglad -limgui -shared -fpic $^ -o $@

$(OBJ)/%.o: $(SRC)/%.cpp $(OBJ)/$(PCH).pch
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ)/$(PCH).pch $(INCLUDES) $(DEFINES) -c $< -o $@

$(OBJ)/$(PCH).pch: $(SRC)/$(PCH)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -x c++-header $^ -o $@

$(SANDBOX_BIN):
	$(CXX) $(CXXFLAGS) $(INCLUDES) -L./Hazel/bin -lhazel -o $@ sandbox/src/SandboxApp.cpp

clean:
	rm -r Hazel/bin/* Hazel/obj/* sandbox/bin/*
