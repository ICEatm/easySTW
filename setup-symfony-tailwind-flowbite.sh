#!/bin/bash

set -e  # Exit the script if any command fails

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

# Function to handle errors
handle_error() {
    echo "Error occurred at line $1."
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

# Create Symfony project
echo "Creating Symfony project: $PROJECT_NAME..."
if ! symfony new $PROJECT_NAME --webapp; then
    echo "Failed to create Symfony project."
    exit 1
fi

cd $PROJECT_NAME

# Install TailwindCSS, TwigComponents and Flowbite bundles
echo "Installing TailwindCSS and Flowbite bundles..."
if ! composer require symfonycasts/tailwind-bundle; then
    echo "Failed to install symfonycasts/tailwind-bundle."
    exit 1
fi

# Simulate user confirmation for Flowbite installation
if ! echo "a" | composer require tales-from-a-dev/flowbite-bundle; then
    echo "Failed to install tales-from-a-dev/flowbite-bundle."
    exit 1
fi

# Install UxTwigComponent
if ! composer require symfony/ux-twig-component; then
	echo "Failed to install symfony/ux-twig-component"
	exit 1
fi

# Update Twig configuration
echo "Downloading Twig configuration from $TWIG_CONFIG_URL..."
if ! curl -s $TWIG_CONFIG_URL | tee config/packages/twig.yaml > /dev/null; then
    echo "Failed to download Twig configuration."
    exit 1
fi

# Initialize TailwindCSS
echo "Initializing TailwindCSS..."
if ! php bin/console tailwind:init; then
    echo "Failed to initialize TailwindCSS."
    exit 1
fi

# Import Flowbite
echo "Importing Flowbite..."
if ! php bin/console import:require flowbite; then
    echo "Failed to import Flowbite."
    exit 1
fi

# Update app.js to include Flowbite
echo "Downloading app.js from $APP_JS_URL..."
if ! curl -s $APP_JS_URL | tee assets/app.js > /dev/null; then
    echo "Failed to download app.js."
    exit 1
fi

# Update app.css
echo "Downloading app.css from $APP_CSS_URL..."
mkdir -p assets/styles
if ! curl -s $APP_CSS_URL | tee assets/styles/app.css > /dev/null; then
    echo "Failed to download app.css."
    exit 1
fi

# Download TailwindCSS configuration
echo "Downloading TailwindCSS configuration from $TAILWIND_CONFIG_URL..."
if ! curl -s $TAILWIND_CONFIG_URL | tee tailwind.config.js > /dev/null; then
    echo "Failed to download tailwind.config.js."
    exit 1
fi

# Download start_dev.sh script
echo "Downloading start_dev.sh script from $START_DEV_URL..."
if ! curl -s $START_DEV_URL | tee start_dev.sh > /dev/null; then
    echo "Failed to download start_dev.sh."
    exit 1
fi

# Make the start_dev.sh script executable
echo "Making start_dev.sh executable..."
if ! chmod +x start_dev.sh; then
    echo "Failed to make start_dev.sh executable."
    exit 1
fi

echo "Building CSS with TailwindCSS..."
# Run the TailwindCSS build command
if ! php bin/console tailwind:build; then
    echo "Failed to build CSS with TailwindCSS."
    exit 1
fi

echo "Setup complete! You can now start your Symfony server with 'symfony server:start' and view your project."
