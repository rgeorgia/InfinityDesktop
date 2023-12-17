FVWM_HOME=$HOME/.fvwm
REPO_FVWM_HOME=$HOME/workspace/InfinityDesktop/create_fvwm_desktop/dot-fvwm/fvwm
CONFIG_HOME_FVWM=$HOME/.config/fvwm3
REPO_CONFIG_FVWM=$HOME/workspace/InfinityDesktop/create_fvwm_desktop/dot-config/fvwm3

cp -r ${REPO_FVWM_HOME}/* ${FVWM_HOME}/.
cp -r ${REPO_CONFIG_FVWM}/* ${CONFIG_HOME_FVWM}/.
