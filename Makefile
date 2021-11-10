CXX=clang++
CXXFLAGS=-g -std=c++17
INCLUDES=-I./Hazel/src -I./Hazel/vendor/GLFW/include -I./Hazel/vendor/glad/include -I./Hazel/vendor/spdlog/include -I./Hazel/vendor/imgui -I./Hazel/vendor/glm
FRAMEWORKS=-framework Cocoa -framework IOKit
LIBS=-L./Hazel/vendor/GLFW/src -lglfw3 -L./Hazel/vendor/glad/src -lglad -L./Hazel/vendor/imgui -limgui
DEFINES=-DGLFW_INCLUDE_NONE

SRC=Hazel/src
OBJ=Hazel/obj
HZ_SOURCES=$(shell find $(SRC) -type f -name *.cpp)
HZ_OBJECTS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(HZ_SOURCES))
HAZEL_BIN=Hazel/bin/libhazel.a
SANDBOX_BIN=sandbox/bin/sandbox
PCH=hzpch.h

all: $(HAZEL_BIN) $(SANDBOX_BIN)

$(HAZEL_BIN): $(HZ_OBJECTS)
	ar rv $(HAZEL_BIN) $(HZ_OBJECTS)
	ranlib $(HAZEL_BIN)

$(OBJ)/%.o: $(SRC)/%.cpp $(OBJ)/$(PCH).pch
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ)/$(PCH).pch $(INCLUDES) $(DEFINES) -c $< -o $@

$(OBJ)/$(PCH).pch: $(SRC)/$(PCH)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -x c++-header $^ -o $@

$(SANDBOX_BIN):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(FRAMEWORKS) $(LIBS) -o $@ sandbox/src/SandboxApp.cpp $(HAZEL_BIN)

clean:
	rm -r Hazel/bin/* Hazel/obj/* sandbox/bin/*
