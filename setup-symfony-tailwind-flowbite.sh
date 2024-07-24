#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <project_name>"
    echo "Name should be your project name"
    exit 1
fi

# Define URLs for configuration files
TAILWIND_CONFIG_URL="https://raw.githubusercontent.com/ICEatm/easySTW/main/files/tailwind.config.js"
START_DEV_URL="https://raw.githubusercontent.com/ICEatm/easySTW/main/files/start_dev.sh"
TWIG_CONFIG_URL="https://raw.githubusercontent.com/ICEatm/easySTW/main/files/twig.yaml"
APP_CSS_URL="https://raw.githubusercontent.com/ICEatm/easySTW/main/files/app.css"
APP_JS_URL="https://raw.githubusercontent.com/ICEatm/easySTW/main/files/app.js"

PROJECT_NAME=$1

# Create Symfony project
echo "Creating Symfony project: $PROJECT_NAME..."
symfony new $PROJECT_NAME --webapp

cd $PROJECT_NAME

# Install TailwindCSS and Flowbite bundles
echo "Installing TailwindCSS and Flowbite bundles..."
composer require symfonycasts/tailwind-bundle

# Simulate user confirmation for Flowbite installation
echo "a" | composer require tales-from-a-dev/flowbite-bundle

# Update Twig configuration
echo "Downloading Twig configuration from $TWIG_CONFIG_URL..."
curl -s $TWIG_CONFIG_URL | tee config/packages/twig.yaml > /dev/null

# Initialize TailwindCSS
echo "Initializing TailwindCSS..."
php bin/console tailwind:init

# Import Flowbite
echo "Importing Flowbite..."
php bin/console import:require flowbite

# Update app.js to include Flowbite
echo "Downloading app.js from $APP_JS_URL..."
curl -s $APP_JS_URL | tee assets/app.js > /dev/null

# Update app.css
echo "Downloading app.css from $APP_CSS_URL..."
mkdir -p assets/styles
curl -s $APP_CSS_URL | tee assets/styles/app.css > /dev/null

# Download TailwindCSS configuration
echo "Downloading TailwindCSS configuration from $TAILWIND_CONFIG_URL..."
curl -s $TAILWIND_CONFIG_URL | tee tailwind.config.js > /dev/null

# Download start_dev.sh script
echo "Downloading start_dev.sh script from $START_DEV_URL..."
curl -s $START_DEV_URL | tee start_dev.sh > /dev/null

# Make the start_dev.sh script executable
chmod +x start_dev.sh

echo "Building CSS with TailwindCSS..."
# Run the TailwindCSS build command
php bin/console tailwind:build

echo "Setup complete! You can now start your Symfony server with 'symfony server:start' and view your project."
