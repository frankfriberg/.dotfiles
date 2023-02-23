export ZSH="$HOME/.config/oh-my-zsh"
ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
ZSH_THEME="franks"
plugins=(git brew macos zsh-syntax-highlighting colored-man-pages)
source $ZSH/oh-my-zsh.sh
autoload -Uz vcs_info
export PATH="$HOME/tools/lua-language-server/bin/macOS:$PATH"
export PATH="$PATH:/Users/ff/Library/Python/3.9/bin"
