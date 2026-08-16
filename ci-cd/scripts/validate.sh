#!/bin/bash

# 1. healthの判定
if [ "$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/health")" -eq 200 ]; then
    echo "Health: 200 OK"
else
    echo "Health: NG"
    exit 1
fi

# 2. versionの判定
if [ "$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/version")" -eq 200 ]; then
    echo "Version: 200 OK"
else
    echo "Version: NG"
    exit 1
fi

exit 0
