set fish_greeting

set TERM "xterm-256color" # Sets the terminal type
set -xU LS_COLORS "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34:su=0:sg=0:tw=0:ow=0:"

set -x EDITOR 'nvim'

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan
set PATH $PATH (find ~/.sdkman/candidates/*/current/bin -maxdepth 0)

### Aliases
alias k kubectl
alias g git
command -qv nvim && alias vim nvim

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

