# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Set theme to powerlevel10k (p10k)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Speed up shell startup by loading the prompt before everything else.
if [[ -r "$HOME/.p10k.zsh" ]]; then
  source "$HOME/.p10k.zsh"
fi

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom Aliases
alias ll='ls -la'
alias gs='git status'

# Environment Variables
export EDITOR="vim"
export LANG="en_US.UTF-8"

# Enable command history sharing across all terminal sessions
setopt SHARE_HISTORY

# Enable case-insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Set up NERDTree (if needed for Neovim, for example)
# nmap <C-n> :NERDTreeToggle<CR>

# Enable syntax highlighting plugin
if [ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable autosuggestions plugin
if [ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Path customization (optional)
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Source any additional custom configurations if needed
if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi