#!/bin/bash
input="$1"

n="$(wc -l < $input)"
file="file.txt"

echo "set args $input" > $file
echo "set pagination off" >> $file
echo "b add" >> $file
echo "b sub" >> $file
echo "b mpy" >> $file
echo "b div" >> $file
echo "run" >> $file
i=0
while [ "$i" -lt "$n" ]; do
	i=$((i+1))
		echo "info all-registers" >> $file
		echo "c" >> $file
	done
echo "quit" >> $file
gdb --command=$file ./a.out
rm $file
