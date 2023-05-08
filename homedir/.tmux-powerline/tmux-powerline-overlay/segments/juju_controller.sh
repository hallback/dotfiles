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
    local LASTPARSEFILE=~/.tmux-powerline/lastparse.juju
    local LASTPARSE=0

    if [ -f "$CTRLCFG" -a -f "$MODLCFG" ] ; then
        LASTCHANGE=$(ls -tn --time-style=+%s "$CTRLCFG" "$MODLCFG" | head -1 | awk '{ print $6 }')
        [ -f "$LASTPARSEFILE" ] && LASTPARSE=$(stat -c %Y "$LASTPARSEFILE")

        if [ $LASTCHANGE -gt $LASTPARSE ] ; then
            jujuctrl=$(grep current-controller "$CTRLCFG" | awk '{ print $2 }')
            # The last cut command removes the username from the model
            jujumodel=$(yq .controllers."$jujuctrl".current-model < "$MODLCFG" | cut -d/ -f2)

            # Include the controller name in the output (or not)
            jujuinfo="$jujuctrl:$jujumodel"
            #jujuinfo="$jujumodel"

            # DEBUG
            #echo "parsed yaml on $(date +%s) lastchange: $LASTCHANGE lastparse: $LASTPARSE" >> ~/.tmux-powerline/parselog

            echo  -n "#[fg=colour${juju_colour}]${juju_symbol} #[fg=colour${TMUX_POWERLINE_CUR_SEGMENT_FG}]${jujuinfo}" \
                | tee "$LASTPARSEFILE"
        else
            # DEBUG
            #echo "just read file $(date +%s) lastchange: $LASTCHANGE lastparse: $LASTPARSE" >> ~/.tmux-powerline/parselog
            cat "$LASTPARSEFILE"
        fi
    fi
}
