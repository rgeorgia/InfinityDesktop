function setXDGenv
	set -xg XDG_CONFIG_HOME "$HOME/.config"
	set -xg XDG_DATA_HOME "$HOME/.local/share"
	set -xg XDG_CACHE_HOME "$HOME/.cache"
end

# Set the search path for programs.
set -gx PATH $HOME/bin /bin /sbin /usr/bin /usr/sbin /usr/X11R7/bin /usr/pkg/bin
set -gx PATH $PATH /usr/pkg/sbin /usr/games /usr/local/bin /usr/local/sbin
set -gx PATH $HOME/.cargo/bin $PATH
set -gx MANPATH /usr/share/man /usr/X11R7/man /usr/pkg/man

# Set environment variables
set -gx EDITOR vim
set -gx QT_QPA_PLARFORMTHEME qt5ct
set -gx QTDIR /usr/pkg/qt5
set -gx VISUAL $EDITOR

setXDGenv
# neofetch
