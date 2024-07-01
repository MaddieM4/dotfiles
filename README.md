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

 * Default settings unless otherwise specified.
 * Did not use updated installer.
 * Custom storage:
   * Reformat target drive, eliminating existing partitions
   * Use as boot device
   * Create a GPT partition (unformatted) in the free space taking rest of drive
   * Create volume group - name it `morgana-vg` (substitute your hostname as applicable) using that partition
   * Create volumes:
     * `morgana-root` 300G ext4
     * `morgana-home` (remainder) ext4
 * Appropriate profile config
 * Install OpenSSH server (don't import keys)
 * Don't install snaps
 * Reboot

### Post-install buildout

```bash
# Ensure basic dependencies
sudo apt install -y git make stow

# Clone this repo, do everything else inside it
cd ~; mkdir -p projects; cd projects
git clone https://github.com/MaddieM4/dotfiles.git
cd dotfiles

# Setting up a minimal CLI system
make bash vim git
```
