CXX=clang++
CXXFLAGS=
INCLUDES=-I./Hazel/src -I./Hazel/vendor/GLFW/include -I./Hazel/vendor/spdlog/include
FRAMEWORKS=-framework Cocoa -framework OpenGL -framework IOKit 

SRC=Hazel/src
OBJ=Hazel/obj
SOURCES=$(shell find $(SRC) -type f -name *.cpp)
OBJECTS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(SOURCES))
HAZEL_BIN=Hazel/bin/libhazel.so
SANDBOX_BIN=sandbox/bin/sandbox
PCH=hzpch.h

all: $(HAZEL_BIN) $(SANDBOX_BIN)

$(HAZEL_BIN): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(FRAMEWORKS) -L./Hazel/vendor/GLFW/src -lglfw3 -shared -fPIC $^ -o $@

$(OBJ)/%.o: $(SRC)/%.cpp $(OBJ)/$(PCH).pch
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ)/$(PCH).pch $(INCLUDES) -c $< -o $@

$(OBJ)/$(PCH).pch: $(SRC)/$(PCH)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -x c++-header $^ -o $@

$(SANDBOX_BIN):
	$(CXX) $(CXXFLAGS) $(INCLUDES) -L./Hazel/bin -lhazel -o $(SANDBOX_BIN) sandbox/src/SandboxApp.cpp

clean:
	rm -r Hazel/bin/* Hazel/obj/* sandbox/bin/*
