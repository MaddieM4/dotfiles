OBSIDIAN_VERSION:=1.6.5
OBSIDIAN_URL:=https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-amd64.deb
OBSIDIAN_DEB:=obsidian/.apt/debs/obsidian.deb

#CMD_STOW=$(stow -vt $HOME -d packages/enabled)

list:
	@echo "The following metapackages are available:"
	@echo " - system-cli"
	@echo " - system-gui"
	@echo ""
	@echo "Additionally, the following packages are available:"
	@(cd pkg/available && ls | sed -e 's/^/ - /')
	@echo ""
	@echo "Use 'make [pkg]' to install any package or metapackage."

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

system-cli: deploy # TODO


# -----------------------------------------------------------------------------
#  New-style builds, proven on my rebuild
# -----------------------------------------------------------------------------
.PHONY: bash vim git
bash:
	./enable bash
	./apply
	sudo cp resources/local-profile.sh /etc/profile.d/
	@echo "You may want to 'source /etc/profile.d/local-profile.sh' now"

vim:
	./enable vim
	./apply

SECRETS_ENV_GIT=pkg/available/git/.profile.d/secrets-env-git
$(SECRETS_ENV_GIT):
	mkdir -p $(shell dirname $(SECRETS_ENV_GIT))
	resources/secrets-git > $(SECRETS_ENV_GIT)
git: $(SECRETS_ENV_GIT)
	./enable git
	./apply
	git-configure

wallpapers:
	./enable wallpapers
	./apply
