
# handy aliases

alias g="git"
alias k="kubectl"
alias v="nvim"

export SDKMAN_DIR="/Users/osleonard/.sdkman"
[[ -s "/Users/osleonard/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/osleonard/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export PATH="$PATH:/Users/osleonard/Library/Application Support/Coursier/bin"

fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit
