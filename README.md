[![Open Source at IFTTT](http://ifttt.github.io/images/open-source-ifttt.svg)](http://ifttt.github.io)

![Dash](https://raw.githubusercontent.com/IFTTT/dash/images/images/dash.png "Dash")

# Dash

## What is this for?

`Dash` is a simpple Docker Compose wrapper command used in developing applications at IFTTT.

## The tl;dr Version

    # Step 1: Install the Docker for Mac Stable Channel DMG
    # Step 2: Install [d4m-nfs](https://github.com/IFTTT/d4m-nfs)
    # Step 3: Clone this project to a directory of your choice
    git clone git@github.com:IFTTT/dash
    # Step 4: Add the Dash directory to your path.
    # Step 5: Start a new shell and cd to a project that uses [Docker Compose](https://docs.docker.com/compose/)
    dev up

## Workflow

- The source code running inside a project container is loaded from the directory on your hard drive. You can use text editors and Git clients on the host machines, and shouldn't need to work in the guest machine or the container.
- You should not need to run any application code directly from your host machine. Try to force yourself to find a containerized way of accomplishing things.
- Your SSH identify from the host machine will be forwarded into the guest machine.
- Run `dev help` for lots of help

### Troubleshooting

#### When in doubt, restart Docker

Random issues can sometimes be solved by restarting the Docker VM and your containers with the UI.

#### NFS Mount Issues

Follow the instructions in [d4m-nfs](https://github.com/IFTTT/d4m-nfs) (you may need to re-run them if you've restarted Docker).

## Contributors

* [Nicholas Silva](https://github.com/silvamerica), creator.

## Contributing

1. Fork it ( https://github.com/IFTTT/dash/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

`Dash` is available under the MIT license. See the LICENSE file for more info.

Copyright 2017 IFTTT Inc.
