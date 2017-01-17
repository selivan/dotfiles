#!/bin/bash
#set -x

cd `dirname "$0"`

# Update repository if possible
which git >/dev/null && echo "Updating dotfiles repository" && git pull

find . -path './.*' \! -path './.git/*' -type f -print0 | xargs -0 -n1 | while read name; do
	name="$name"
	target=`readlink -f "$name"`
	# remove leading dot from path: ${x#.}
	dotfile="$HOME${name#.}"
	dir=`dirname "$link"`

	# Backup dotfile if it is not a link
	if [ -e "$dotfile" -a ! -L "$dotfile" ]; then
		backup="$dotfile".backup-`date +%Y-%M-%d_%H-%M-%S`
		if mv "$dotfile" "$backup" ; then
			echo "Created backup: $backup"
		else
			echo "ERROR: failed to create backup: $backup"
			exit 1
		fi
	fi

	# Do nothing if link is already ok
	current_link=`readlink -f "$dotfile"`
	[ "$current_link" -eq "$target" ] && continue

	# Create directory if necessary and update symlink
	if mkdir -p "$dir" && ln -sf "$target" "$dotfile"; then
		echo "Symlink updated:" `ls -l "$dotfile"`
	else
		echo "ERROR: failed to create symlink $target"
		exit 1
	fi
done
