## Set values
# Hide welcome message & ensure we are reporting fish as shell
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x SHELL /usr/pkg/bin/fish

# Use bat for man pages
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT "-c"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

function setXDGenv
	set -gx XDG_CONFIG_HOME "$HOME/.config"
	set -gx XDG_DATA_HOME "$HOME/.local/share"
	set -gx XDG_CACHE_HOME "$HOME/.cache"
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
# set vi key bindings
fish_vi_key_bindings


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

## Starship prompt
# if status --is-interactive
#   source (/usr/pkg/bin/starship init fish --print-full-init | psub)
# end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | string trim --right --chars=/)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


## Useful aliases
# Replace ls with eza
alias ls 'eza -al --color=always --group-directories-first --icons' # preferred listing
alias lsz 'eza -al --color=always --total-size --group-directories-first --icons' # include file size
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# Common use
alias grep 'ugrep --color=auto'
alias egrep 'ugrep -E --color=auto'
alias fgrep 'ugrep -F --color=auto'
