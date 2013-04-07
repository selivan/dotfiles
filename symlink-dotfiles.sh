#!/bin/bash
#set -x

cd "$PWD"

which git && git pull

function bcp_link() {
# incorrect parameter
[ -z "$1" ] && return
# if file is not symlink
if [ ! -L ~/"$1" ]; then 
	mv -f ~/"$1" ~/"$1.bak"
else
	rm -f  ~/"$1"
fi
ln -sf "$PWD"/"$1" ~/"$1"
ls -og ~/"$1"
}

files=(\
.config/htop/htoprc \
.config/mc/ini \
.bash_logout \
.bashrc \
.inputrc \
.screenrc \
.vimrc \
)

for f in ${files[*]}; do
	bcp_link $f
done

