#---
#事前準備
#---
#Homebrewを最新版へアップデート
update
#Formulaを更新
upgrade
#---
#リポジトリ追加
#---
#公式以外のバージョン
tap homebrew/dupes
#最新バージョンのFormula
tap homebrew/versions
#バイナリ配布用
tap homebrew/binary
# cask
tap phinze/homebrew-cask
tap caskroom/cask
tap peco/peco
#---
# パッケージのインストール
#---
# コマンド群
install coreutils
install diffutils
# コマンド
install curl
install wget
install zsh
install git
install openssl
install readline
install zsh-completions
#install brew-cask
install caskroom/cask/brew-cask
install markdown
install ag
install ctags
install w3m
install tree
install sl
install vim --with-lua --override-system-vi
#install macvim
install ricty
install peco
# プログラム言語
install rbenv
install ruby-build
install lua
install python
#フォント
install fontforge
install fontconfig
install freetype
#---
#アプリのインストール
#---
cask install adobe-reader --force
cask install google-chrome --force
cask install google-japanese-ime --force
cask install dropbox --force
cask install github --force
cask install skitch --force
cask install iterm2 --force
cask install sublime-text --force
cask install bettertouchtool --force
cask install karabiner --force
cask install cheatsheet --force
cask install kobito --force
cask install alfred --force
# alfredから検索可能にする
cask alfred link --force
cask install xtrafinder --force
cask install shiftit --force
cask install xquartz --force
cask install yorufukurou --force
cask install virtualbox --force
cask install vagrant --force
cask install dash --force
cask install atom
#古いバージョンを削除
cleanup
