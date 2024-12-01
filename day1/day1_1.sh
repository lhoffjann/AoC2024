#!/bin/bash
list_a=""
list_b=""
while read line; do
    list_a+=" $(echo $line | awk '{print $1}' -)"
    list_b+=" $(echo $line | awk '{print $2}' -)"
done < <(cat $1)
list_a_sorted=$(echo $list_a  | tr " " "\n" | sort -g )
list_b_sorted=$(echo $list_b  | tr " " "\n" | sort -g )
sorted_list=$(paste <(printf "%s\n" "${list_a_sorted[@]}") <(printf "%s\n" "${list_b_sorted[@]}") \
    | awk '{printf "%.0f\n", $1 - $2}' \
    | tr -d "-" \
    | paste -sd+ - | bc)

echo $sorted_list
