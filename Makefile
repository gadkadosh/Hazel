CXX=clang++
CXXFLAGS=
INCLUDES=-I./hazel/src -I./hazel/vendor/spdlog/include

SRC=hazel/src
OBJ=hazel/obj
SRCS=$(wildcard $(SRC)/*.cpp)
OBJS=$(patsubst $(SRC)/%.cpp,$(OBJ)/%.o,$(SRCS))
HAZEL_BIN=hazel/bin/libhazel.so
SANDBOX_BIN=sandbox/bin/sandbox
PCH=hzpch.h

all: $(HAZEL_BIN) $(SANDBOX_BIN)
hazel: $(HAZEL_BIN)

$(HAZEL_BIN): $(OBJS)
	$(CXX) $(CXXFLAGS) -shared -fPIC $^ -o $@

$(OBJ)/%.o: $(SRC)/%.cpp $(OBJ)/$(PCH).pch
	$(CXX) $(CXXFLAGS) -include-pch $(OBJ)/$(PCH).pch $(INCLUDES) -c $< -o $@

$(OBJ)/$(PCH).pch: $(SRC)/$(PCH)
	$(CXX) $(CXXFLAGS) -x c++-header $^ -o $@

$(SANDBOX_BIN):
	$(CXX) $(CXXFLAGS) $(INCLUDES) -L./hazel/bin -lhazel -o $(SANDBOX_BIN) sandbox/src/SandboxApp.cpp

clean:
	rm -r hazel/bin/* hazel/obj/* sandbox/bin/*
