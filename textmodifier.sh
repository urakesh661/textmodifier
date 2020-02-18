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

echo "1. Append at start of the lines."
echo "2. Append at the end of lines."

echo
echo -n "Choice: "
read choice

echo $choice

case $choice in
	1) append_start ;;
	2) append_end ;;
	*) echo "You have entered wrong choice."
esac

