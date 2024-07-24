# Symfony TailwindCSS and Flowbite Setup

This repository provides a shell script to quickly set up a Symfony project with TailwindCSS and Flowbite. The script automates the installation and configuration of the necessary bundles and files, making it easier to get started with these tools in your Symfony project.

## Features

- **Symfony Project Creation**: Creates a new Symfony project using Symfony CLI.
- **TailwindCSS Integration**: Installs and initializes TailwindCSS with the provided configuration.
- **Flowbite Integration**: Installs and sets up Flowbite for enhanced UI components.
- **Configuration Files**: Downloads and applies the necessary configuration files for Twig, TailwindCSS, and app assets.

## Prerequisites

Before running the script, ensure that you have the following installed:

- **Symfony CLI**: [Symfony CLI installation guide](https://symfony.com/download)
- **Composer**: [Composer installation guide](https://getcomposer.org/download/)
- **curl**: Most systems come with curl installed. If not, [install curl](https://curl.se/download.html).

## Usage

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/ICEatm/easySTW.git
    cd your-repo-name
    ```

2. **Run the Script**:

    Make sure the script is executable:

    ```bash
    chmod +x setup-symfony-tailwind-flowbite.sh
    ```

    Execute the script by providing your project name as an argument:

    ```bash
    ./setup-symfony-tailwind-flowbite.sh <project_name>
    ```

    Replace `<project_name>` with the desired name for your Symfony project.

## Script Overview

The script performs the following actions:

1. **Creates a New Symfony Project**:
    ```bash
    symfony new $PROJECT_NAME --webapp
    ```

2. **Installs TailwindCSS and Flowbite Bundles**:
    ```bash
    composer require symfonycasts/tailwind-bundle
    echo "a" | composer require tales-from-a-dev/flowbite-bundle
    ```

3. **Updates Twig Configuration**:
    Downloads and replaces `config/packages/twig.yaml` with the configuration from the specified URL.

4. **Initializes TailwindCSS**:
    ```bash
    php bin/console tailwind:init
    ```

5. **Imports Flowbite**:
    ```bash
    php bin/console import:require flowbite
    ```

6. **Updates `app.js` and `app.css`**:
    Downloads and replaces `assets/app.js` and `assets/styles/app.css` with the files from the provided URLs.

7. **Downloads and Makes Executable `start_dev.sh`**:
    Downloads the `start_dev.sh` script and makes it executable.

8. **Builds TailwindCSS**:
    ```bash
    php bin/console tailwind:build
    ```

## Contributing

Feel free to contribute by submitting issues or pull requests. Please ensure that any changes are thoroughly tested before submitting.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or support, please contact me at discord: .keyof
