# Maddie's Dotfiles

I'm trying to move more and more of my personal computing experience into public
repositories of clean content. That way it's easy to build a new system whenever
I want. Right now the best reference for how to do stuff is:

https://maddiem4.cc/site/setup

One thing that might be nice is making this repo a wizard to entirely replace
that document with true automation. I'd like to do that at some point. In the
meantime, consider that link the instructions for making use of this repo.

## EXPERIMENTAL: From-scratch instructions

I'm working to convert a bunch of copy-paste notes into a single series of
commands to set up a computer starting from a base of Ubuntu 24.04 Server.

### OS install notes

 * Did not use updated installer.
 * Use the whole Toshiba HDD as a volume group.
   * Renaming it to `morgana-vg` required deleting all logical volumes.
   * `morgana-root` 300G ext4
   * `morgana-home` (remainder) ext4
 * Didn't install any snaps, obviously.

### Post-install buildout

```bash
# Clone this repo, do everything else inside it
cd ~; mkdir -p projects; cd projects
git clone https://github.com/MaddieM4/dotfiles.git
cd dotfiles

# Do the early setup necessary for this repo to be able to work
./bootstrap

# Now, install the packages you want (see pkg/available) with Make.
# This adds a layer of dependency management over raw ./enable and ./apply.
make bash

# You will probably be interested in one of the following metapackages:
make system-cli
make system-gui
```
