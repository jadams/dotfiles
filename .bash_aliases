################################################################
# SHELL SETUP
################################################################
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
eval "$(starship init bash)"

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
importsm() {
  gpgsm --import <(openssl x509 -inform DER -in <(pkcs11-tool --read-object --id 03 --type cert) -outform PEM)
}

encryptsm() {
  if [[ -f "${1}" ]]; then
    gpgsm --disable-crl-checks --encrypt --armor --recipient "$(gpgsm -k | awk '/ID:/ {id=$2} /key usage: keyEncipherment/ {if (id) print id; exit}')" --output "${1}.asc" "${1}"
  else
    echo "Usage: ${FUNCNAME[0]} <file>"
  fi
}

decryptsm() {
  if [[ -f "${1}" ]] && [[ "${1}" == *.asc ]]; then
    gpgsm --disable-crl-checks --decrypt --output "$(basename ${1} .asc)" "${1}"
  else
    echo "Usage: ${FUNCNAME[0]} <file.asc>"
  fi
}
