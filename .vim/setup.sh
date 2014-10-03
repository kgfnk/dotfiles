#!/bin/sh
#実行方法
#chmod 755 setup.sh
#./setup.sh
DIR=$(cd $(dirname $0); pwd)
ln -s ${DIR}/after/ ~/.vim/after
ln -s ${DIR}/snippets/ ~/.vim/snippets
ln -s ${DIR}/template/ ~/.vim/template
