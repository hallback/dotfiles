# Prints current Juju model if it could be detected.

# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

juju_symbol="🪄"
juju_colour="220"


run_segment() {
	tmux_path=$(get_tmux_cwd)
	cd "$tmux_path"
	result=""
	if [ -n "${juju_location=$(__parse_juju)}" ]; then
		result="$juju_location"
	fi

	if [ -n "$result" ]; then
		echo "${result}"
	fi
	return 0
}


# Show Juju controller and model.
__parse_juju() {
    local CTRLCFG=~/.local/share/juju/controllers.yaml
    local MODLCFG=~/.local/share/juju/models.yaml

	if [ ! -f $CTRLCFG ]; then
		return
	fi

    if [ -f $CTRLCFG ] ; then
            jujuctrl=$(grep current-controller $CTRLCFG | awk '{ print $2 }')
    fi
    if [ -f $MODLCFG ] ; then
            jujumodel=$(yq .controllers.$jujuctrl.current-model < $MODLCFG)
    fi

    #jujuinfo="$jujuctrl:$jujumodel"
    jujuinfo="$jujumodel"

	echo  -n "#[fg=colour${juju_colour}]${juju_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${jujuinfo}"
}
