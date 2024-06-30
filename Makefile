OBSIDIAN_VERSION:=1.6.5
OBSIDIAN_URL:=https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-amd64.deb
OBSIDIAN_DEB:=obsidian/.apt/debs/obsidian.deb

deploy:
	stow -vt $$HOME vim bash i3 apt secrets

secrets: deploy
	secrets-rebuild

$(OBSIDIAN_DEB): deploy
	mkdir -p $(shell dirname $(OBSIDIAN_DEB))
	wget "$(OBSIDIAN_URL)" -O $(OBSIDIAN_DEB)

obsidian: $(OBSIDIAN_DEB) deploy
	stow -vt $$HOME obsidian
	apt-reinstall
