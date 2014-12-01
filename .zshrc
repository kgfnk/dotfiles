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
##
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
#ヒストリに同じコマンドを残さない
setopt hist_ignore_all_dups
#ヒストリ保存時、余計なスペースを削除する
setopt hist_reduce_blanks
setopt share_history        # share command history data
bindkey -v
bindkey "^R" history-incremental-search-backward
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

export PATH=/usr/local/bin:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=$PATH:${HOME}/.cabal/bin:$PATH
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export PATH=$PATH:/usr/local/share/npm/bin

export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
export DOCKER_HOST=tcp://127.0.0.1:2375

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u
fpath=(/usr/local/Library/Contributions/brew_bash_completion.sh $fpath)
eval "$(rbenv init -)"
eval "$(hub alias -s)"

# 名前で色を付けるようにする
autoload colors
colors

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ファイル補完候補に色を付ける
 zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#色設定
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#alias
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias alt="ls -alt"
#delはゴミ箱へ移動
alias del='mydel'
function mydel() { mv $1 ~/.Trash }
alias df='df -h'
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
# [コマンドラインでcdとかしたら勝手にlsするシェルスクリプト | girigiribauer.com](http://girigiribauer.com/archives/724)

function agvim ( {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
})

# python
export WORKON_HOME=~/.virtualenvs
. /usr/local/bin/virtualenvwrapper.sh
