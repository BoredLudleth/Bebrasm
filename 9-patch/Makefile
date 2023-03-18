all: compile link

compile: patcher.cpp
	g++ -I"D:\libs\SFML-2.5.1\include" -c patcher.cpp -o patcher.o

link: patcher.o
	g++ -LD:\libs\SFML-2.5.1\lib .\patcher.o -o patcher.exe -lmingw32 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-main -lsfml-audio -mwindows