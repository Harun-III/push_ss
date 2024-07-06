#!/bin/bash

gen_nembers () {
	numbers=$(python -c "import random; print(' '.join(map(str, random.sample(range(-999999, 999999), $1))))")
	echo $numbers
}


read -p "Give the max number of instructions: " max
echo $max

prog="./push_swap"

i=0
while (( 1 )); do
	ss="$(gen_nembers $1)"
	$prog $ss > /tmp/temp_file
	number_of_instruction=$(wc -l /tmp/temp_file | awk '{print $1}')
	echo Number of instructions used: $number_of_instruction
	if (( number_of_instruction > $max )); then
		echo number of instruction exceeded the max
		echo -n "The testing line = "
		echo "$ss"
		break
	fi
	 
	output=$($prog $ss | ./checker_Mac $ss)
	if [[ $output == "OK" ]]; then
		echo $output
	else
		echo $output
		echo $1
		break
	fi
	i=$(( i + 1 ))
done
