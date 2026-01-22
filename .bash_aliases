################################################################
# SHELL SETUP
################################################################
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
eval "$(starship init bash)"

################################################################
# GPG SSH AGENT
################################################################
if [ -z "$SSH_CONNECTION" ] && [ -z "$SSH_CLIENT" ]; then
  export GPG_TTY=$(tty)
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye > /dev/null
fi

################################################################
# PATH
################################################################
PATH="/home/linuxbrew/.linuxbrew/opt/helm@3/bin:$PATH"

################################################################
# ALIASES
################################################################
alias update="sudo bash -c 'apt update && apt dist-upgrade -y && snap refresh'"
alias windows="sudo bash -c 'efibootmgr -n 0000 && reboot'"
alias diff='diff --color=auto'
alias lxc='TERM=xterm-256color lxc'

################################################################
# FUNCTIONS
################################################################
import-gpgsm() {
  gpgsm --import <(openssl x509 -inform DER -in <(pkcs11-tool --read-object --id 03 --type cert) -outform PEM)
}

encrypt() {
  if [[ -f "${1}" ]]; then
    gpgsm --disable-crl-checks --encrypt --armor --recipient "$(gpgsm -k | awk '/aka/ {print $2}')" --output "${1}.asc" "${1}"
  else
    echo "Usage: ${FUNCNAME[0]} <file>"
  fi
}

decrypt() {
  if [[ -f "${1}" ]] && [[ "${1}" == *.asc ]]; then
    gpgsm --disable-crl-checks --decrypt --output "$(basename ${1} .asc)" "${1}"
  else
    echo "Usage: ${FUNCNAME[0]} <file.asc>"
  fi
}
