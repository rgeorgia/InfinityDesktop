# Set the search path for programs.
set -gx PATH $HOME/bin /bin /sbin /usr/bin /usr/sbin /usr/X11R7/bin /usr/pkg/bin
set -gx PATH $PATH /usr/pkg/sbin /usr/games /usr/local/bin /usr/local/sbin
set -gx PATH $HOME/.cargo/bin $PATH
set -gx MANPATH /usr/share/man /usr/X11R7/man /usr/pkg/man

# Set environment variables
set -Ux EDITOR vim
set -Ux QT_QPA_PLARFORMTHEME qt5ct
set -Ux QTDIR /usr/pkg/qt5
set -Ux VISUAL $EDITOR

# Set XDG variables
set -Ux XDG_CONFIG_DIRS /usr/pkg/etc/xdg
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_MENU_PREFIX 
set -Ux XDG_SESSION_DESKTOP fvwm3
set -Ux XDG_SESSION_TYPE x11
set -Ux XDG_CURRENT_DESKTOP fvwm
set -Ux XDG_SESSION_CLASS user
set -Ux XDG_RUNTIME_DIR /tmp/run/rgeorgia
set -Ux XDG_DATA_DIRS $HOME/.local/share /usr/pkg/share /usr/pkg/emul/linux/usr/share

# starship
starship init fish | source
