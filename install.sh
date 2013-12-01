#!/bin/bash
# Taken from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

DIR="$HOME/dotfiles"
OLD_DIR="$HOME/dotfiles_old"
FILES="vimrc zshrc tigrc"

echo "Creating $OLD_DIR for backup of any existing dotfiles in $HOME"
mkdir -p $OLD_DIR
echo "..done!"

echo "Changing to the $DIR directory"
cd $DIR
echo "..done!"

for file in $FILES; do
  echo "Moving any existing dotfiles from $HOME to $OLD_DIR"
  mv "$HOME/.$file" "$OLD_DIR"
  echo "Creating symlinks"
  ln -s "$DIR/$file" "$HOME/.$file"
done
