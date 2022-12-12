#!/bin/bash

#--- VARIABLES ---#
arr_elvCalories=()
file_inputFile="./input.txt"
index=0
calories=0

#--- FUNCTIONS ---#
getHighestValue() {
	tmpArray=("$@")
	highestValue=$(printf '%s\n' "${tmpArray[@]}" | awk '$1 > m || NR == 1 { m = $1 } END { print m }')
	echo $highestValue
}

deleteValueFromArray() {
	tmpArray=("$@")
	tmpArray=( "${tmpArray[@]/$2}" )
}

getValuesFromFile() {
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
}

#--- RESULTS ---#
getValuesFromFile

caloriesTopOne=$(getHighestValue "${arr_elvCalories[@]}")
echo "Top 1: $caloriesTopOne"

arr_elvCalories=( "${arr_elvCalories[@]/$caloriesTopOne}" )
caloriesTopTwo=$(getHighestValue "${arr_elvCalories[@]}")
echo "Top 2: $caloriesTopTwo"

arr_elvCalories=( "${arr_elvCalories[@]/$caloriesTopTwo}" )
caloriesTopThree=$(getHighestValue "${arr_elvCalories[@]}")
echo "Top 3: $caloriesTopThree"

total=$(($caloriesTopOne + $caloriesTopTwo + $caloriesTopThree))
echo "Total: $total"
