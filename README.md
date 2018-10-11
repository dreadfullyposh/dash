# Dash

## What is this for?

`Dash` is a simple Docker Compose wrapper command used in developing applications at Vector. This is a fork of https://github.com/IFTTT/dash.

Dash provides a centralized set of services for an Nginx reverse proxy server, DNSMasq, MailHog and MySQL. 

## The tl;dr Version

- Step 1: Install the Docker
- Step 2: Clone this project to a directory of your choice git clone git@github.com:dreadfullyposh/dash
- Step 3: Add the Dash directory to your path.
- Step 4: Create a Docker network for your Dash setup by running `docker network create dash`
- Step 5: Configure your Mac to resolve *.test domains via the DNSMasq server included with Dash:
  1. Create a `resolver` directory in `/etc`. If it already exists, that's fine.
  2. Add a file named `test` in that directory.
  3. Open that file and type `nameserver 127.0.0.1`. Save.
- Step 6: Restart terminal, `cd` into a project that uses [Docker Compose](https://docs.docker.com/compose/), and run `dev up`.
- Step 6b: If you're having issues, try restarting your mac.

## Workflow

- The source code running inside a project container is loaded from the directory on your hard drive. You can use text editors and Git clients on the host machines, and shouldn't need to work in the guest machine or the container.
- You should not need to run any application code directly from your host machine. Try to force yourself to find a containerized way of accomplishing things.
- Your SSH identify from the host machine will be forwarded into the guest machine.
- Run `dev help` for lots of help


## SSL

Since most sites are now running using SSL, it's advisable to also run your local development environment using SSL. Luckily that's super easy with Dash and it's underlying nginx-proxy Docker container.

An example configuration for a wildcard certificate for `*.dev.vmg` is included in the `certs` directory. A bash script file is also included for generating your certificate using that configuration. Simple add execute permission to the script file `chmod +x generatecertificate.sh` and then run the script `./generatecertificate.sh`.

After generating your certificates, Dash will automatically pick them up. You will want to open `Keychain Access` on your Mac and drag the generated certificate into your keychain, then adjust the settings to always trust the certificate, in order to avoid scary warnings from Chrome and Safari. Note: Firefox doesn't play nicely, and you'll have to trust the certificate in the browser separately if you use it.


### Troubleshooting

#### When in doubt, restart Docker

Random issues can sometimes be solved by restarting the Docker VM and your containers with the UI.
