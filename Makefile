deploy:
	stow -vt $$HOME vim bash i3 secrets

secrets: deploy
	secrets-rebuild
