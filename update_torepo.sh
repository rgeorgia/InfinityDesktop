FVWM_HOME=$HOME/.fvwm
REPO_FVWM_HOME=$HOME/workspace/InfinityDesktop/create_fvwm_desktop/dot-fvwm/fvwm
CONFIG_HOME_FVWM=$HOME/.config/fvwm3
REPO_CONFIG_FVWM=$HOME/workspace/InfinityDesktop/create_fvwm_desktop/dot-config/fvwm3

cp -r ${FVWM_HOME}/* ${REPO_FVWM_HOME}/.
cp -r ${CONFIG_HOME_FVWM}/* ${REPO_CONFIG_FVWM}/.
