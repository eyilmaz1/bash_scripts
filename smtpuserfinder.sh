#!/bin/bash

names=($(cat names.txt)); total_names=${#names[@]}; batch_size=10; for ((i = 0; i < $total_names; i += batch_size)); do start_index=$i; end_index=$((i + batch_size - 1)); if ((end_index >= total_names)); then end_index=$((total_names - 1)); fi; ( sleep 10; echo "EHLO user"; sleep 1; for ((j = start_index; j <= end_index; j++)); do echo "VRFY ${names[j]}"; sleep 1; done; echo "quit" ) | telnet $ip 25; done
