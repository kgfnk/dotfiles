export LANG=ja_JP.UTF-8
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt auto_menu
setopt pushd_ignore_dups
setopt correct
setopt list_packed
#setopt list_types

#ビープを消す
setopt nobeep
#リスト保管時のビープを消す
setopt nolistbeep
# aliasでも保管できるようにする
setopt complete_aliases

#autoload predict-on
#predict-on
setopt noautoremoveslash
PROMPT="%/%% "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
#ヒストリに同じコマンドを残さない
setopt hist_ignore_all_dups
#ヒストリ保存時、余計なスペースを削除する
setopt hist_reduce_blanks
setopt share_history        # share command history data

### nvim
alias vim="nvim"
export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR=nvim
export PAGER=vimpager
export MANPAGER=vimpager
alias less=$PAGER

# key bind
#bindkey -v
bindkey "^R" history-incremental-search-backward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# path
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=$PATH:${HOME}/.cabal/bin:$PATH
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/Applications/VMware\ Fusion.app/Contents/Library

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH

# docker
#export DOCKER_HOST=tcp://127.0.0.1:2375

### zsh

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u
fpath=(/usr/local/Library/Contributions/brew_bash_completion.sh $fpath)

### hub
eval "$(hub alias -s)"

### color
# 名前で色を付けるようにする
autoload colors
colors

# ターミナルを256色へ変更
export TERM='xterm-256color'
# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#色設定
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#node
export PATH=$PATH:$HOME/.nodebrew/current/bin
export PATH=$PATH:node_modules/.bin/

## alias
alias ls="ls --color=auto"
alias l="ls -lAFh"
alias ll="ls -l"
alias la="ls -la"
alias alt="ls -alt"
#delはゴミ箱へ移動
alias del='mydel'
function mydel() { mv $1 ~/.Trash }
alias df='df -h'
alias gs='git status'
#alias find=gfind

# 移動したらすぐls -lah
# ただしファイルなどが20より多かった場合はlsで簡易表示
function chpwd() {
    if [ 10 -gt `ls -1 | wc -l` ]; then
        ls -lah
    else
        ls
    fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
