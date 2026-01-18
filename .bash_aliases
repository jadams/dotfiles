eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
eval "$(starship init bash)"

if [ -z "$SSH_CONNECTION" ] && [ -z "$SSH_CLIENT" ]; then
  export GPG_TTY=$(tty)
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye > /dev/null
fi

PATH="/home/linuxbrew/.linuxbrew/opt/helm@3/bin:$PATH"

update="sudo bash -c 'apt update && apt dist-upgrade -y && snap refresh'"
windows="sudo bash -c 'efibootmgr -n 0000 && reboot'"
