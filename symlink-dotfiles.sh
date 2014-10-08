#!/bin/bash
#set -x

cd `dirname $0`/dotfiles
pwd

#which git > /dev/null 2>&1 && git pull

find . -type f -print0 | xargs -0 -n1 | while read name; do
	name="$name"
	link="$HOME${name#.}"
	dir=`dirname "$link"`
	if [ "$dir" != "$HOME" ]; then
		mkdir -p "$dir"
	fi
	if [ -e "$link" -a ! -L "$link" ]; then
		mv "$link" "$link".bak`+%Y-%M-%d_%H-%M-%S`
	elif [ -L "$link" ]; then
		rm "$link"
	fi
	name_full=`readlink -f "$name"`
	ln -sf "$name_full" "$link"
   	ls -l "$link"
done

