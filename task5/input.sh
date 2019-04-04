#!/bin/bash

#code for taking arguements

if [ "$#" -lt 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi
if [ "$#" == 1 ]; then
	cfile=$1
	echo "0" > a77.txt
	file='a77.txt'
fi
if [ "$#" == 2 ]; then
    cfile=$1
    file=$2
fi
if [ "$#" -gt 2 ]; then
    echo "Illegal number of parameters"
    exit 1
fi
gcc -fprofile-arcs -ftest-coverage $cfile

#code for line frequency

n="$(wc -l < $file)"
i=0
while [ "$i" -lt "$n" ]; do
	i=$((i+1))
	d="$(awk 'NR== '$i' {print $0}' $file)"
	./a.out $d >temp77.txt
done
gcov -a $cfile > A77.txt
awk -F':' '{print $2,$1}' $cfile.gcov > t1.txt
awk -F' ' '{print $1,$2}' t1.txt > t2.txt
cut -d " " -f 1,2 t2.txt --output-delimiter='-' >t1.txt
awk -F'-' '{print $1,$2}' t1.txt > t2.txt
rm t1.txt temp77.txt
cp /dev/null t1.txt
file='t2.txt'
n="$(wc -l < $file)"
i=0
while [ "$i" -lt "$n" ]; do
	d1="$(awk 'NR== '$i' {print $1}' $file)"
	i=$((i+1))
	d2="$(awk 'NR== '$i' {print $1}' $file)"
	if [[ "$d1" != "$d2" ]]; then
		f="$(awk 'NR== '$i' {print $1,$2}' $file)"
		echo "$f" >> t1.txt
	fi
done < $file
awk '{print $0" -"}' t1.txt > t2.txt  
awk -F' ' '{print $1,$2}' t2.txt > t3.txt
cut -d " " -f 1,2 t3.txt --output-delimiter=',' >t1.txt
rm -f t2.txt t3.txt a77.txt

#code for line bias

gcov -b $cfile > A77.txt
file='test.txt'
awk -F':' '{print $1 $2 $3 $4}' $cfile.gcov > $file
cp /dev/null t3.txt
n="$(wc -l < $file)"
i=0
while [ "$i" -lt "$n" ]; do
	i=$((i+1))
	d="$(awk 'NR== '$i' {print $1 $2 $3}' $file)"
	if [[ "$d" == "branch0taken" ]]; then
		f1="$(awk 'NR== '$((i-1))' {print $2}' $file)"
		f2="$(awk 'NR== '$i' {print $4}' $file)"
		echo "$f2$f1" >> t3.txt
	fi
done < $file
rm $file
cut -d "%" -f 1,2 t3.txt --output-delimiter=',' >t2.txt
awk -F',' '{print $2,$1}' t2.txt > t3.txt
cut -d " " -f 1,2 t3.txt --output-delimiter=',' >t2.txt
mv t1.txt linefrequency.txt
mv t2.txt linebias.txt
rm t3.txt A77.txt


