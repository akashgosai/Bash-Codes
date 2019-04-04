#!/bin/bash
cp /dev/null link.txt
ps -ef >usrbinout.txt
awk '{print $2, $8 }' usrbinout.txt > final1.txt
grep -e " /bin" -e " /usr/bin" final1.txt > final2.txt
filename='final2.txt'
n=1
while read line; do
s=($line)
ls -l ${s[1]} >>link.txt
n=$((n+1))
done < $filename
awk '{print $1,$2,$9 }' link.txt > col1.txt
sort -k 2 final2.txt > a1.txt
sort -k 3 col1.txt > a2.txt
join -1 2 -2 3 a1.txt a2.txt > finalanswer.txt
sort -u finalanswer.txt > f.txt
cut -d " " -f 1,2,3,4 f.txt --output-delimiter=',' >finalanswer2.txt
rm usrbinout.txt final1.txt final2.txt link.txt col1.txt finalanswer.txt f.txt a1.txt a2.txt
