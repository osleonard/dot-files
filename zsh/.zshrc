
# handy aliases

alias g="git"
alias k="kubectl"
alias v="nvim"

eval "$(starship init zsh)"

if [ -r ~/.custom.zshrc ]; then
  source ~/.custom.zshrc
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

export PATH=$PATH:$HOME/bin

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
eval "$(ssh-agent -s)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
