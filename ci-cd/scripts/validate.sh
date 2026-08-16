#!/bin/bash

# 1. healthの判定
for i in {1..6}; do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/health")

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "Health: 200 OK"
        break
    fi

    echo "Health: NG (${i}/6) - retry after 5 seconds"

    if [ "$i" -eq 6 ]; then
        exit 1
    fi

    sleep 5
done

# 2. versionの判定
if [ "$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/version")" -eq 200 ]; then
    echo "Version: 200 OK"
else
    echo "Version: NG"
    exit 1
fi

exit 0
