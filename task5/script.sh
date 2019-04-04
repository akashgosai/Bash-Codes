#!/bin/bash
cat /dev/null > final2.txt
len=""
flag=0

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

gcc -pg "$cfile" -o testgprof
n="$(wc -l < $file)"
i=0
while [ "$i" -lt "$n" ]; do
	cat /dev/null > fun.txt
	
	i=$((i+1))
	d="$(awk 'NR== '$i' {print $0}' $file)"
	if [[ $d != " " ]]; then
		echo "Running testcase: $d"
		echo "Testcase $i" >> final2.txt
	fi
	./testgprof $d  
	gprof -q -b  testgprof gmon.out > result.txt
	sed '1,7d' result.txt | sed 's/ \+/ /g' > 3.txt 

	while read line;do
		
		if [[ $line == -* ]]; then
			flag=0
			continue
		fi
		if [[ $line == [* ]]; then
			flag=1		
			len="$(echo $line | wc -w)"
			words=($line)
			if [[ $len -ge 2 ]]; then
				headfun="$(echo ${words[-2]})"
			fi
			

		elif [[ $flag == 1 ]]; then
			len="$(echo $line | wc -w)"
			words=($line)
			if [[ $len -ge 2 ]]; then
				echo $headfun ${words[-2]} >> fun.txt
			fi
			
		fi	



	done < 3.txt
	gprof -p -b testgprof gmon.out > flat.txt
	sed '1,5d' flat.txt > flat1.txt
	 
	cat /dev/null > temp
	cat /dev/null > final.txt


	while read line; do
		for word in $line; do
			useful="$(grep " $word" flat1.txt)"
			array=($useful)
			if [[ ${array[2]} == "" ]]; then
				echo -n $word,"0.00", >> final.txt
			else
				echo -n $word,${array[2]}, >> final.txt
			fi
		done
		printf "\n" >> final.txt
	done < fun.txt
	sed 's/.$//' final.txt >> final2.txt
done
rm -f result.txt a77.txt 3.txt flat.txt flat1.txt final.txt fun.txt temp 
mv final2.txt callgraph.txt






