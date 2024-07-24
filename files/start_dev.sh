#!/bin/bash

# Start Symfony server in the background
echo "Starting Symfony server..."
symfony server:start -d

# Check if the server started successfully
if [ $? -eq 0 ]; then
    echo "Symfony server started successfully."
else
    echo "Failed to start Symfony server."
    exit 1
fi

# Execute Tailwind build command in the background
echo "Executing Tailwind build..."
php bin/console tailwind:build --watch &

# Executing the messenger consumer
# If you are using any kind of mailer
# This queue will automatically process the mails async
php bin/console messenger:consume async

# Stream the Symfony server logs
echo "Streaming Symfony server logs..."
symfony server:log
