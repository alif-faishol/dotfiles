#!/bin/bash

HOMEDIR=$HOME
DOTFILEDIR="dotfiles"

symlink_dotfile() {
  dest=$HOMEDIR/$(dirname $1)
  mkdir -p $dest; ln -s $1 $dest
}

dotfiles=$(find $DOTFILEDIR -type f -print | cut -d/ -f2- 2> /dev/null)

if [[ $dotfiles  ]]; then
  echo "Symlinking dotfiles..."

  for dotfile in $dotfiles; do
    echo "$dotfile"
    symlink_dotfile $dotfile
  done

  echo "All set!"

else
  echo "You don't have anything in '$DOTFILEDIR', bro-tato"
fi
