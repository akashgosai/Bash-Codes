#!/bin/bash
gcc -c add.c sub.c mpy.c div.c
ar cr libas.a add.o sub.o
gcc -shared -o libmd.so mpy.o div.o
gcc -g main.c libas.a $(pwd)/libmd.so
