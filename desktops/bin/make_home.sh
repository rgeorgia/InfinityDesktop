mkdir -p $HOME/Document $HOME/Downloads $HOME/Templates $HOME/Videos $HOME/Pictures/backgrounds $HOME/Nowhere
mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/sakura
mkdir -p $HOME/.fluxbox
mkdir -p $HOME/.config/openbox
cp -r ../fluxbox/* $HOME/.fluxbox/.
cp -r ../openbox/* $HOME/.config/openbox/.
cp -r ../netbsd/dot-config/fish/* $HOME/.config/fish/.
cp -r ../netbsd/dot-config/sakura/* $HOME/.config/sakura/.
