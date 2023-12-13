#!/bin/bash

while read line
do
    echo $line;
    if [ ${#line} -ge 3 ]; then
        payload=$(echo $line | sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g' | sed -E 's/(frontend|backend|client|useragent|body|request|status)/\n\t\1/g')
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"\`\`\`$payload\`\`\`\"}"  $SLACK_HOOK_URL 
    fi
done < "${1:-/dev/stdin}"
