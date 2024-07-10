Maddie's Dotfiles
=================

This is a bunch of configuration information I use on my machines. It's finally
stripped-down and sleek, moving a lot of package complexity to my PPA.

To take full advantage of these tools, it's recommended to follow these steps:

```bash
# Install my PPA, if you haven't yet
curl https://ppa.maddiem4.cc/setup-ppa.sh | sh

# Install the packaged version of the sys files
sudo apt install mm4cc-dotfiles

# Configure and apply your configuration
dotfiles configure && dotfiles apply
```

The original version of this repo is still available under the `spaghetti` git
tag. It has a few things I still need to crib from for `mm4cc-pkg` metapackages.

### Machine build instructions

So far I've been using Ubuntu Server 24.04, and optionally wrangling it to have
desktop functionality. For reproducibility reasons, here's my recipe:

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

And then, at this point, I'd do the instructions at the top of this document.
