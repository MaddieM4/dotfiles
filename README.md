# Maddie's Dotfiles

To rebuild a machine, start with Ubuntu Server 24.04 installed as follows:

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
cd ~; mkdir -p projects/f; cd projects
git clone https://github.com/MaddieM4/dotfiles.git
cd dotfiles

# Setting up a minimal CLI system:
make bash vim git

# You may find it useful to turn on a password manager:
make 1password

# To expand that into a graphical system, do this next:
make lxqt wallpapers

# I'm going to make sure I have per-host recipes as well.
make katarina
make morgana
```

# A few observations

This project is a bit of an abuse of both `make` and `stow`, and I fully know it. I'm trying
to fill a gap that neither of them are entirely adequate for: setting up a system that requires
both package installation and personal customization, both managed in a maintainable and somewhat
reproducible way. I'm not too bothered about this being a messy bag of hacks, for one important
reason: it's given me a better firsthand sense of what my package/system management tooling needs
to handle well, what the requirements will be.

That said, I'll be using this for awhile, as my own "real" solutions to these problems will take
a long time to come to fruition. In the meantime, the "do prebuild stuff in Makefile" pattern
works alright, and I need to make sure all packages support it.
