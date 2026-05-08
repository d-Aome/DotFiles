
# 2. Zinit Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"


# 3. Zsh Plugins (Syntax, Completions, etc.)
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# 4. Snippets (OMZ functionality) in background
zinit wait'1' lucid for \
     OMZL::git.zsh \
     OMZP::git \
     OMZP::sudo \
     OMZP::archlinux \
     OMZP::aws \
     OMZP::kubectl \
     OMZP::kubectx \
     OMZP::command-not-found

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


export NVM_DIR="$HOME/.nvm"
# Define a function to load NVM on demand
load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Create "dummy" functions that load the real NVM when called
nvm() { unset -f nvm node npm npx; load_nvm; nvm "$@" }
node() { unset -f nvm node npm npx; load_nvm; node "$@" }
npm() { unset -f nvm node npm npx; load_nvm; npm "$@" }
npx() { unset -f nvm node npm npx; load_nvm; npx "$@" }

export VCPKG_ROOT=$HOME/vcpkg
export PATH="$VCPKG_ROOT:$PATH"

# 12. Starship Prompt Initialization (Keep at the very bottom)
eval "$(starship init zsh)"
