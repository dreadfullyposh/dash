# Dash

## What is Dash

Dash is a simple Docker Compose wrapper command used for managing a Docker-based local development environment. 

This is a fork of https://github.com/IFTTT/dash, originally created by IFTTT.

Dash provides two primary features:

- A globally-accessible wrapper command for `docker-compose` called `dev`
- A centralized set of Docker containers to for running a local development environment, including an Nginx reverse proxy server, DNSMasq DNS server, MailHog, and MySQL.

This repository was presented at ExpressionEngine Conference 2018 by Jeremy Gimbel as part of a session entitled *A Docker-based Development Environment Even I Can Understand*

The slides from the presentation can be found here: https://www.slideshare.net/JeremyGimbel/a-dockerbased-development-environment-even-i-can-understand-120725992

The video of this presentation can be seen here: https://youtu.be/kVygjAc1Yv4

## Dash Directory Structure
Explanation of the files in this repository.

    .
    ├── certs           # Stores certificates
    ├── data            # Data storage for persistant volumes (MySQL data, etc)
    ├── docker          # Stores custom Dockerfiles for use within the Dash services
    │   ├── nginx       # Stores Dockerfile and conf files for nginx-proxy
    │   │   ├── Dockerfile
    ├── example         # Stores example docker-compose.yml file for projects
    │   ├── public      # Example document root, contains simple index.php for demo purposes
    │   ├── docker-compose.yml
    ├── config.sample.yml       # Sample config for customizing Dash with additional central service stacks
    ├── dash.yml                # Docker compose file for configuring the Dash services
    ├── dev                     # Script for controlling dash
    ├── generatecertificate.sh  # Script for generating wildcard self-signed certificate
    └── openssl.cnf             # Config file used by generatecertificate.sh

## Installation

Dash and the associated installation instructions have been created for use on Mac OS X. While Docker and the Dash script should work correctly on other operating systems, your mileage may vary and some tweaking may be needed.

- Step 1: Install Docker
- Step 2: Clone this project to a directory of your choice `git clone git@github.com:dreadfullyposh/dash`
- Step 3: Add the Dash directory (that you just cloned) to your path.
- Step 4: Create a Docker network for your Dash setup by running `docker network create dash`
- Step 5: Setup SSL
    - Run the script `./generatecertificate.sh`
- Step 5: Run `dev dash up` from your terminal. You should see several containers start up in the terminal.

## SSL

Since most sites are now running using SSL, it's advisable to also run your local development environment using SSL. Luckily that's super easy with Dash and it's underlying nginx-proxy Docker container.

An example configuration for a wildcard certificate for `*.localtest.me` is included in the `certs` directory. A bash script file is also included for generating your certificate using that configuration. Simple add execute permission to the script file `chmod +x generatecertificate.sh` and then run the script `./generatecertificate.sh`. The certificate and key will be generated in the certs directory.

After generating your certificates, Dash will automatically pick them up. You will want to open `Keychain Access` on your Mac and drag the generated certificate into your keychain, then adjust the settings to always trust the certificate, in order to avoid scary warnings from Chrome and Safari. Note: Firefox doesn't play nicely, and you'll have to trust the certificate in the browser separately if you use it.

## Project Setup

- Step 1: Copy the `docker-compose.yml` file from the `example` directory in Dash to the root of your project repository.
- Step 2: Adjust the environment variables for WEB_DOCUMENT_ROOT and VIRTUAL_HOST appropriately.
- Step 3: Run `dev up`. The Dash containers will start first, if they aren't already, then your project containers will start.

## Workflow

- With the Dash directory added to your path, you can now access the `dev` command from anywhere on your machine. `dev` is simply a wrapper for `docker-compose` 
- By default `dev commandname` will operate on the docker-compose.yml file in the current directory or above in the directory tree. Using `dev dash commandname` will operate on the Dash services.
- The source code running inside a project container is syncronized via a volume in docker-compose.yml. Normally the project repository directory on your hard drive gets mapped to a directory one level above the document root in your container. 
- You can use text editors and Git clients on the host machine, and shouldn't need to SSH in to work in the Docker machine or the container. If you do, you're probably doing something wrong.
- That said, you should not need to run any application code directly from your host machine. Try to force yourself to find a containerized way of accomplishing things. This includes running `composer` or `npm`
- Your SSH identity from the host machine will be forwarded into the guest machine.

## Changing Domains

By default we use `*.localtest.me` which is a publicly-available domain that always resolves to `127.0.0.1` (https://weblogs.asp.net/owscott/introducing-testing-domain-localtest-me).

Included in `dash.yml` is a commented out DNSMasq service, which can be used to customize this domain, but  a few extra steps are required. Uncomment that section of `dash.yml` and customize the TLD you'd like to use.

Then, configure your Mac to resolve `*.yourtld` domains via the DNSMasq server included with Dash:
    1. Create a `resolver` directory in `/etc`. If it does not already exist
    2. Add a text file named `yourtld` in that directory.
    3. Append `nameserver 127.0.0.1` to that file (`/etc/resolver/yourtld`)
    4. Restart your Mac

After changing domains, you'll need to adjust the `./generatecertificate.sh` script and `openssl.cnf` to match your new domain and re-run the script to re-generate your certificates.    
    

## Dash Shared Services

### MySQL

Since MySQL is running on its own container in the Dash, accessing it is a little different than on a traditional local development environment.

From your host machine, using Sequel Pro, the mysql command line client or any other tool:

- **Hostname:** 127.0.0.1 (be sure you're connecting via network not socket)
- **Username:** root
- **Password:** root

From any other container running in Docker:

- **Hostname:** mysql (this is the name of the MySQL service in dash.yml)
- **Username:** root
- **Password:** root

### MailHog

MailHog is an email testing tool that acts as an SMTP server. Your applications can then send email through MailHog instead of a real SMTP server, and you can access any sent messages from the MailHog control panel.

When Dash is running, the MailHog control panel is configured to be accessible at: https://mailhog.localtest.me

Configure your applications to use MailHog as their SMTP server:

- **Hostname:** mailhog
- **Port Number:** 1025

### PHPMyAdmin

PHPMyAdmin is a web-based MySQL client.

PHPMyAdmin is accessible at: https://phpmyadmin.localtest.me (http if you haven't configured SSL)

The login credentials are already set, so you should not need to login when you open PHPMyAdmin. If you do change the root password for MySQL, make sure you also update it for the PHPMyAdmin container as well.
