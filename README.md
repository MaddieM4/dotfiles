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
