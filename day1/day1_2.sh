#!/bin/bash
grep_pattern(){
    read foo
    echo "$foo hello" 
}
list_a=""
list_b=""
while read line; do
    list_a+=" $(echo $line | awk '{print $1}' -)"
    list_b+=" $(echo $line | awk '{print $2}' -)"
done < <(cat $1)
list_a_sorted=$(echo $list_a  | tr " " "\n" | sort -g )
list_b_sorted=$(echo $list_b  | tr " " "\n" | sort -g )
set -x
printf "%s\n" "${list_a_sorted[@]}" \
    |  xargs -I {} sh -c 'echo "{} $(grep -o "\b{}\b" <<<"$0" | wc -l)"' "$list_b_sorted" \
    | awk '{printf "%.0f\n", $1 * $2}' \
    | paste -sd+ - | bc





