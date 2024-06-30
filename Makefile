deploy:
	stow -vt $$HOME vim bash i3 apt secrets

secrets: deploy
	secrets-rebuild
