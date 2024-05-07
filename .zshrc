[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh


# Init Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Init Starship
eval "$(starship init zsh)"

# GPG fix tty
GPG_TTY=$(tty)
export GPG_TTY

# ASDF for Python install
. $HOME/.asdf/asdf.sh

# Auto-Suggestions for ZSH
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh