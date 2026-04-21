
CC      = clang++
CFLAGS  = -std=c++17 -Wall -O2 -I/opt/homebrew/Cellar/glfw/3.4/include
LDFLAGS = -lglfw -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo -L/opt/homebrew/Cellar/glfw/3.4/lib

hello: main.o
	$(CC) $(CFLAGS) main.o -o hello $(LDFLAGS)

main.o: main.cpp
	$(CC) $(CFLAGS) -c main.cpp

run: hello
	./hello

clean:
	rm -f *.o hello
