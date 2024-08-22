# handy aliases

alias g="git"
alias k="kubectl"
alias v="nvim"


if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
else
        [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$PATH:/Users/osleonard/Library/Application Support/Coursier/bin"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

export PATH=$PATH:$HOME/bin

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
eval "$(starship init zsh)"
eval "$(ssh-agent -s)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set internet proxy
function setproxy() {
  export {http,https}_proxy="http://zproxy-global.shell.com:80"
  export no_proxy='newmotion.com,thenewmotion.com,localhost'
}
# Unset internet proxy
function unsetproxy() {
  unset {http,https}_proxy
  unset no_proxy
}

export JAVA_OPTS="$JAVA_OPTS -Dhttps.proxyHost=zproxy-global.shell.com -Dhttp.proxyHost=zproxy-global.shell.com -Dhttp.proxyPort=8080 -Dhttps.proxyPort=8080 -Dhttp.nonProxyHosts=*.newmotion.com|*.thenewmotion.com|localhost -Djavax.net.ssl.trustStore=$HOME/ca-complete-bundle.jks"
export NODE_EXTRA_CA_CERTS="$HOME/ca-extra-certs.pem"
export SSL_CERT_FILE="$HOME/ca-complete-bundle.pem"
export AWS_CA_BUNDLE="$HOME/ca-complete-bundle.pem"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

complete -o nospace -C /opt/homebrew/bin/terraform terraform
