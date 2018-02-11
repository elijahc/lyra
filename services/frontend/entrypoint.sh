#!/bin/sh

echo "Waiting for mongodb..."

while ! nc -z mongodb 27017; do
    sleep 0.1
done

echo "mongodb started started"

bundle exec puma
