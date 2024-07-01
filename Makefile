list:
	@echo "The following metapackages are available:"
	@echo " - system-cli"
	@echo " - system-gui"
	@echo ""
	@echo "Additionally, the following packages are available:"
	@(cd pkg/available && ls | sed -e 's/^/ - /')
	@echo ""
	@echo "Use 'make [pkg]' to install any package or metapackage."

# -----------------------------------------------------------------------------
#  New-style builds, proven on my rebuild
# -----------------------------------------------------------------------------
.PHONY: bash vim git ntfy 1password chuck i3 lxqt wallpapers
bash:
	./enable bash
	./apply
	sudo cp resources/local-profile.sh /etc/profile.d/
	@echo "You may want to 'source /etc/profile.d/local-profile.sh' now"

vim:
	./enable vim
	./apply

devtools:
	sudo apt install -y \
		tree links neofetch inetutils-traceroute net-tools \
		nodejs npm golang docker.io python3

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

sddm:
	sudo apt install -y sddm nm-tray dbus-user-session dbus-x11 \
		task-lxqt-desktop wpasupplicant xorg

i3: sddm
	sudo apt install -y i3 xfce4-terminal nitrogen picom
	./enable i3
	./apply

lxqt: sddm
	sudo apt install -y \
		dbus-user-session \
		dbus-x11 \
		task-lxqt-desktop \
		lxqt

wallpapers:
	./enable wallpapers
	./apply

OBSIDIAN_VERSION:=1.6.5
OBSIDIAN_URL:=https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-amd64.deb
OBSIDIAN_DEB:=pkg/available/obsidian/Downloads/obsidian.deb
$(OBSIDIAN_DEB):
	wget "$(OBSIDIAN_URL)" -O $(OBSIDIAN_DEB)
obsidian: $(OBSIDIAN_DEB)
	sudo dpkg --install $(OBSIDIAN_DEB)
	./enable obsidian
	./apply

# -----------------------------------------------------------------------------
#  Host recipes
# -----------------------------------------------------------------------------

# Relatively clean dev machine
morgana: bash vim 1password git ntfy chuck i3 lxqt wallpapers obsidian devtools

# All that and a bag of streamin' tools (TODO)
katarina: morgana
