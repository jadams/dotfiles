# dotfiles
```
sudo apt install -y git
git clone --recursive https://github.com/jadams/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo apt install -y $(< .Aptfile)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
brew bundle install --file .Brewfile
stow .
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

```
