# dotfiles
```bash
# install git and clone repo
sudo apt install -y git
git clone --recursive https://github.com/jadams/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# instal apt packages
sudo apt install -y $(< .Aptfile)
# install snap packages
while read -r snap; do sudo snap install ${snap}; done < .Snapfile
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
# install brew packages
brew bundle install --file .Brewfile
# install dotfiles
stow .
# install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

```
