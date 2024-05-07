[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh


# init homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# init starship
eval "$(starship init zsh)"

# GPG fix tty
GPG_TTY=$(tty)
export GPG_TTY

# ASDF for python install
. $HOME/.asdf/asdf.sh

# ZSH auto_suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH syntax_highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# ls alternative setup
eval "$(g --init zsh)"
