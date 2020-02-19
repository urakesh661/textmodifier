#!/bin/bash

echo -n "Please provide input file: "
read file

if [[ (-z $file) || (! -f $file) ]];then
	echo "You did not provide a domain list or the location of file is invalid!"
	exit
fi

append_start(){

echo -n "Please provide string you want to append at the start: "
read at_start

if [[ (-z $at_start) ]];then
	echo "You did not provide a string to append!"
	exit
fi

append_at_start=$at_start

awk -v append_at_start=$append_at_start '{print append_at_start $0;}' $file > add_start.txt 
	
}

append_end(){

echo -n "Please provide string you want to append at the end: "
read at_end

if [[ (-z $at_end) ]];then
	echo "You did not provide a string to append!"
	exit
fi

append_at_end=$at_end

awk -v append_at_end=$append_at_end '{print $0 append_at_end;}' $file > add_end.txt

}

filter_unique_records(){

sort $file | uniq > filtered_list.txt

}

sort_file(){

cat $file | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > sorted_file.txt

}

search(){

echo -n "Please provide string you want to search: "
read search_text

if [[ (-z $search_text) ]];then
	echo "You did not provide a string to search!"
	exit
fi

grep -i $search_text $file > file.txt

}

echo "1. Append at start of the lines."
echo "2. Append at the end of lines."
echo "3. Remove duplicate records from file."
echo "4. Sort file by line text length."
echo "5. Word to be searched."

echo
echo -n "Choice: "
read choice

echo $choice

case $choice in
	1) append_start ;;
	2) append_end ;;
	3) filter_unique_records ;;
	4) sort_file ;;
	5) search ;;
	*) echo "You have entered wrong choice."
esac
