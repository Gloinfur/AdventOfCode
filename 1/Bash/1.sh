#!/bin/bash

#--- VARIABLES ---#
arr_elvCalories=()
file_inputFile="./input.txt"
index=0
calories=0

#--- LOOP ---#
while IFS= read -r line
do
	if [ ! -z $line ]
	then
		calories=$(($calories + $line))
	elif [ -z $line ]
	then
		(( index += 1 ))
		arr_elvCalories[$index]=$calories
		calories=0
	fi
done < "$file_inputFile"

#--- RESULTS ---#
caloriesTopOne=$(printf '%s\n' "${arr_elvCalories[@]}" | awk '$1 > m || NR == 1 { m = $1 } END { print m }')
echo "Top 1:"
echo $caloriesTopOne

arr_elvCalories=( "${arr_elvCalories[@]/$caloriesTopOne}" )
caloriesTopTwo=$(printf '%s\n' "${arr_elvCalories[@]}" | awk '$1 > m || NR == 1 { m = $1 } END { print m }')
echo "Top 2:"
echo $caloriesTopTwo

arr_elvCalories=( "${arr_elvCalories[@]/$caloriesTopTwo}" )
caloriesTopThree=$(printf '%s\n' "${arr_elvCalories[@]}" | awk '$1 > m || NR == 1 { m = $1 } END { print m }')
echo "Top 3:"
echo $caloriesTopThree

total=$(($caloriesTopOne + $caloriesTopTwo + $caloriesTopThree))
echo "Top 3 elves in total:"
echo $total
