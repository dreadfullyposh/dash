# Dash

## What is Dash

`Dash` is a simple Docker Compose wrapper command used for managing a Docker-based local development environment. This is a fork of https://github.com/IFTTT/dash.

Dash provides a centralized set of services for an Nginx reverse proxy server, DNSMasq, MailHog and MySQL.

`Dash` was presented at ExpressionEngine Conference 2018 by Jeremy Gimbel. Slides from the presentation can be found here: xxx

## Installation

`Dash` and the associated installation instructions have been created for use on Mac OS X. While components of it should work correctly on other operating systems, your mileage may vary.

- Step 1: Install Docker
- Step 2: Clone this project to a directory of your choice git clone git@github.com:dreadfullyposh/dash
- Step 3: Add the Dash directory to your path.
- Step 4: Create a Docker network for your Dash setup by running `docker network create dash`
- Step 5: Configure your Mac to resolve *.test domains via the DNSMasq server included with Dash:
  1. Create a `resolver` directory in `/etc`. If it already exists, that's fine.
  2. Add a file named `test` in that directory with your text editor.
  3. Open that file and type `nameserver 127.0.0.1`. Save.
  4. You will have to restart your Mac for the resolver to take effect.
- Step 6: Run `dev dash up`. You should see several containers start up in the terminal.

## SSL

Since most sites are now running using SSL, it's advisable to also run your local development environment using SSL. Luckily that's super easy with Dash and it's underlying nginx-proxy Docker container.

An example configuration for a wildcard certificate for `*.dev.vmg` is included in the `certs` directory. A bash script file is also included for generating your certificate using that configuration. Simple add execute permission to the script file `chmod +x generatecertificate.sh` and then run the script `./generatecertificate.sh`.

After generating your certificates, Dash will automatically pick them up. You will want to open `Keychain Access` on your Mac and drag the generated certificate into your keychain, then adjust the settings to always trust the certificate, in order to avoid scary warnings from Chrome and Safari. Note: Firefox doesn't play nicely, and you'll have to trust the certificate in the browser separately if you use it.

## Project Setup

- Step 1: Copy the `docker-compose.yml` file from the `example` directory in Dash to the root of your project repository.
- Step 2: Adjust the environment variables for WEB_DOCUMENT_ROOT and VIRTUAL_HOST appropriately.
- Step 3: Run `dev up`. The Dash containers will start first, if they aren't already, then your project containers will start.

## Workflow

- The source code running inside a project container is loaded from the directory on your hard drive. You can use text editors and Git clients on the host machines, and shouldn't need to work in the guest machine or the container.
- You should not need to run any application code directly from your host machine. Try to force yourself to find a containerized way of accomplishing things.
- Your SSH identity from the host machine will be forwarded into the guest machine.
