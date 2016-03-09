[ -f ~/.Xresources ] && xrdb ~/.Xresources
setxkbmap -option ctrl:nocaps
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option altwin:swap_lalt_lwin
setxkbmap us,fi -option grp:toggle
exec dwm
