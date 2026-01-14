if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Zinit Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# 3. Zsh Plugins (Syntax, Completions, etc.)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# 4. Snippets (OMZ functionality)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# 5. Completion Initialization
autoload -Uz compinit && compinit
source ~/somewhere/fzf-tab.plugin.zsh
zinit cdreplay -q

# 6. Load fzf-tab (MUST be after compinit)
zinit light Aloxaf/fzf-tab

# 7. Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# Environment & Paths
export EDITOR='nvim'
export VISUAL='nvim'
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export PATH=$PATH:$HOME/.tmux/plugins/tmuxifier/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH="$PATH:$HOME/.local/bin"

# 8. History Settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# 9. Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# 10. Aliases
alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'

# 11. Shell Integrations
eval "$(tmuxifier init -)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# 12. Starship Prompt Initialization (Keep at the very bottom)
eval "$(starship init zsh)"
