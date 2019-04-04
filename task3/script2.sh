#!/bin/bash

last=""
team=""
read team
while true;
do
	wget -O score.xml -q http://static.cricinfo.com/rss/livescores.xml
	grep "$team" score.xml > 1.txt
	sed 's/&amp;/\&/g;' 1.txt > 2.txt
	cut -d ">" -f2  2.txt > 3.txt
	cut -d "<" -f1  3.txt > 4.txt
	sort -u 4.txt > 5.txt
	filename="5.txt"
	#echo "now bai $match" 
	while read now; do	
		#echo "wewedwwe $now"
		flag=0
		s=0
		for word in $now; do
			if [[ $flag == 1 ]]; then
				s=1
				var=$word
				break
			fi
			if [[ "$word" == "$team" ]]; then
				flag=1
			fi
		done
		if [[ $flag == 0 ]]; then
			var=""
		fi
		if [[ $flag == 1 ]]; then
			if [[ $s == 0 ]]; then
				var=""
			fi
		fi	
	
		#echo "var hai $var"
		initial="$(echo $var | head -c 1)"
		#echo $initial
		if [[ $initial == "" ]]; then
			break
		elif [[ $initial == "v" ]]; then
			break
		elif [[ $initial == [0-9] ]]; then
			break
		else
			#echo "no match today"
			continue
		fi
	done < $filename

	if [ "$now" == "" ]; then
		echo "No match right now."
		
	elif [ "$last" == "$now" ]; then

		echo "No updates in score."
	else
		notify-send "$now"
		
	fi
	last="$now"
	sleep 10s
	
done

