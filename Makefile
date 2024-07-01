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
.PHONY: bash vim git ntfy 1password chuck wallpapers
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
git: $(SECRETS_ENV_GIT) bash
	./enable git
	./apply
	git-configure

SECRETS_ENV_NTFY=pkg/available/ntfy/.profile.d/secrets-env-ntfy
$(SECRETS_ENV_NTFY):
	mkdir -p $(shell dirname $(SECRETS_ENV_NTFY))
	resources/secrets-ntfy > $(SECRETS_ENV_NTFY)
ntfy: $(SECRETS_ENV_NTFY) bash
	./enable ntfy
	./apply

1password: bash
	./enable 1password
	./apply
	op-configure

pkg/available/chuck/projects/f/chuck:
	mkdir -p pkg/available/chuck/projects/f
	cd pkg/available/chuck/projects/f && git clone https://github.com/ccrma/chuck.git
pkg/available/chuck/projects/f/chuck/src/chuck: pkg/available/chuck/projects/f/chuck
	sudo apt install -y build-essential bison flex libsndfile1-dev \
	  libasound2-dev libpulse-dev libjack-jackd2-dev
	cd pkg/available/chuck/projects/f/chuck/src/ && make linux-all
chuck: bash pkg/available/chuck/projects/f/chuck/src/chuck
	./enable chuck
	./apply

wallpapers:
	./enable wallpapers
	./apply
