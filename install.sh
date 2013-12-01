#!/bin/bash
# Taken from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

DIR="~/dotfiles"
OLD_DIR="~/dotfiles_old"
FILES="vimrc zshrc"

echo "Creating $OLD_DIR for backup of any existing dotfiles in $HOME"
mkdir -p $OLD_DIR
echo "..done!"

echo "Changing to the $DIR directory"
cd $DIR
echo "..done!"

for file in $FILES; do
  echo "Moving any existing dotfiles from ~ to $OLD_DIR"
  mv "~/.$file $OLD_DIR"
  echo "Creating symlinks"
  ln -s "$DIR/$file" "~/.$file"
done
