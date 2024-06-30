# Secrets system

These tools populate some secrets into your current bash environment. It's based on
integration with the OnePassword CLI. To refresh your secrets stash, run:

```bash
secrets-rebuild
```

This information is untracked in the `dotfiles` git repo on purpose, allowing you
to build your secrets file without having anything revealing in a public repo.
