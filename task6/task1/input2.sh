#!/bin/bash
cat /dev/null > final.txt
#code for taking arguements
cfile=$1
file=$2
gcc -fprofile-arcs -ftest-coverage $cfile


#code for line frequency

n1=5
j=0
while [ "$j" -lt "$n1" ]; do
	j=$((j+1))
	d="$(awk 'NR== '$j' {print $0}' $file)"
	./a.out $d >temp77.txt
	gcov -b $cfile > A77.txt
	
	awk -F':' '{print $1 $2 $3 $4}' $cfile.gcov > test.txt
	file="test.txt"
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
	#rm $file
	cut -d "%" -f 1,2 t3.txt --output-delimiter=',' >t2.txt
	awk -F',' '{print $2,$1}' t2.txt > t3.txt
	cut -d " " -f 1,2 t3.txt --output-delimiter=',' > t2.txt
	n2="$(wc -l < t2.txt)"
	i2=0
	while [ "$i2" -lt "$n2" ]; do
		i2=$((i2+1))
		d="$(awk 'NR== '$i2' {print $0}' t2.txt)"
		echo "$d,$j" >> final.csv
	done
	
done
	
	#mv t1.txt linefrequency.txt
	#mv t2.txt linebias.txt
	rm t3.txt A77.txt temp77.txt t2.txt final.txt


