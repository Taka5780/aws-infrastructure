#!/bin/bash
set -e

echo "ci-cd-app を再起動しています..."
systemctl restart ci-cd-app

echo "----------------------------------------"
echo -n "現在のステータス: "
systemctl is-active ci-cd-app
