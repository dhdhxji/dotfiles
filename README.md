Warning: This repo created for personal use not for public, it may contain unstable changes which break everything, so no warranties of any kind [(c)](https://opensource.org/license/mit/)

Initially, the goal of this repo was for storing my main setup dotfiles, but now my ultimate goal is to store the overall local environment setup here, which includes the software I use, configs for it etc and automate the installation process in the new machines as much as possible. Possibly it will leverage the distrobox w/ export for each individual piece of software required, or smth like ansible. But other ways to do so are under consideration...


### Containers approach (Just thoughts)
In general, each utility configured by this approach will be run in separate container, which can have huge disk footprint... But is very simple to set up and have small amount of requirements to target system: container system (docker/podman/etc) and arch support by used containers (and possibly some tool to manage all of that, which btw also can be run inside container. Recursion=))

To properly function on the target system this approach requires a few things (generally should be indistinguishable from the regular software):
* Software inside the container should have access to host filesystem
  * Access to the home directory handled automatically by distrobox, may be possible to mount other root entries
* Software inside container should be able to run host's software (with proper SElinux permissions...)
  * Possible with [`distrobox-host-exec`](https://github.com/89luca89/distrobox/blob/main/docs/usage/distrobox-host-exec.md)
* Software inside container should have access to hosts peripherals and network devices
* From the host POV software inside container shouldn't be distinguishable from regular software. It should run as native app (for example `nvim` comand on host should exec something like `podman run -it --rm my-neovim-image`)
  * Can be done with `distrobox-export` or custom script (can also manage updates, image building, etc...)
* Full access to host filesystem (Unix Domain Sockets, etc)