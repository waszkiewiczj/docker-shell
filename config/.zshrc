# required to refresh tty size for docker
stty cols $COLUMNS rows $LINES

# set path to history file
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Oh My Zsh
plugins=(git docker docker-compose)
ZSH_THEME="powerlevel10k/powerlevel10k"
source "${ZSH}/oh-my-zsh.sh"
[[ ! -f "/config/.p10k.zsh" ]] || source "/config/.p10k.zsh"

# custom path to .vimrc
export VIMINIT="source /config/.vimrc"

# clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
