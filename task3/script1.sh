#!/bin/bash
awk '{print $1}' files.txt > filenames.txt
awk '{print $2}' files.txt > permissions.txt
awk '{print $3}' files.txt > direct.txt
file='directories.txt'
while read line; do
	if [ ! -d "$line" ];then
  		mkdir $line -p 
	fi
done < $file
cp /dev/null directories.txt
while read line; do
	n="${line: -1}"
	if [[ "$n" == "/" ]]; then
		line=${line%?}
		echo $line >> directories.txt
	else
		echo $line >> directories.txt
	fi
done < direct.txt
file='filenames.txt'
while read line; do
	chmod 777 $line
done < $file

n="$(wc -l < files.txt)"
i=0
while [ "$i" -lt "$n" ]; do
	i=$((i+1))
	echo $i
	d="$(awk 'NR== '$i' {print $1}' directories.txt)"
	f="$(awk 'NR== '$i' {print $1}' filenames.txt)"
	p="$(awk 'NR== '$i' {print $1}' permissions.txt)"
	echo $f
	ext="$(file -b $f)"
	case "$ext" in
		*"PDF"*)
			mkdir -p $d/doc/
			cp $f $d/doc
			chmod -777 $d/doc/$f

			if [[ "$p" == *"R"* ]]
			then
				chmod u+r $d/doc/$f		
			fi
			if [[ "$p" == *"W"* ]]
			then
				chmod u+w $d/doc/$f		
			fi
			if [[ "$p" == *"E"* ]]
			then
				chmod u+x $d/doc/$f		
			fi
			if [[ "$p" == *"N"* ]]
			then
				chmod u-wrx $d/doc/$f		
			fi
		
		;;
	
		*"executable"*)
			mkdir -p $d/bin/
		
			cp $f $d/bin
			chmod -777 $d/bin/$f
		
			if [[ "$p" == *"R"* ]]
			then
				chmod u+r $d/bin/$f		
			fi
			if [[ "$p" == *"W"* ]]
			then
				chmod u+w $d/bin/$f		
			fi
			if [[ "$p" == *"E"* ]]
			then
				chmod u+x $d/bin/$f		
			fi
			if [[ "$p" == *"N"* ]]
			then
				chmod u-wrx $d/bin/$f		
			fi
		;;
	
		*"ASCII"*)
			mkdir -p $d/header/
			cp -f $f $d/header
			chmod -777 $d/header/$f
			if [[ "$p" == *"R"* ]]
			then
				chmod u+r $d/header/$f		
			fi
			if [[ "$p" == *"W"* ]]
			then
				chmod u+w $d/header/$f		
			fi
			if [[ "$p" == *"E"* ]]
			then
				chmod u+x $d/header/$f		
			fi
			if [[ "$p" == *"N"* ]]
			then
				chmod u-wrx $d/header/$f		
			fi
		;;
		*)
			mkdir -p $d/lib/
			cp -f $f $d/lib
			chmod -777 $d/lib/$f
			if [[ "$p" == *"R"* ]]
			then
				chmod u+r $d/lib/$f		
			fi
			if [[ "$p" == *"W"* ]]
			then
				chmod u+w $d/lib/$f		
			fi
			if [[ "$p" == *"E"* ]]
			then
				chmod u+x $d/lib/$f		
			fi
			if [[ "$p" == *"N"* ]]
			then
				chmod u-wrx $d/lib/$f		
			fi
		;;
	esac
done

 

