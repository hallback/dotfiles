# Only for login shells

# Note to self: also see /etc/profile.d/CUSTOM-allusers-envsetup.sh

# This can add Juju model information to a non Powerline prompt
get_jujuprompt() {
    # Required improvements
    # * must handle if information isn't found
    test -n "$(which yq)" || return
    local CTRLCFG=~/.local/share/juju/controllers.yaml
    local MODCFG=~/.local/share/juju/models.yaml

    if [ -f "$CTRLCFG" -a -f "$MODCFG" ] ; then
        jujuctrl=$(grep current-controller $CTRLCFG | awk '{ print $2 }')
        jujumodel=$(yq .controllers.$jujuctrl.current-model < $MODCFG)
        echo -n "$jujuctrl:$jujumodel"
    fi
}

# If Powerline isn't loaded, add the Juju model info to the standard prompt
if [ -z "$PROMPT_COMMAND" ] ; then
    JUJUPROMPT=$(get_jujuprompt)
    # If jujuprompt produced output, add it to the prompt
    if [ -n "$JUJUPROMPT" ] ; then
        export PS1='$(printf "%*s\r%s" $(( COLUMNS-1 )) "$(get_jujuprompt)")'$PS1
    fi
fi

# Source local stuff we don't want in Git
PRIVATEENV=~/Documents/.private_env
test -f "$PRIVATEENV" && source "$PRIVATEENV"

# Run Neofetch if available
if [ -n "$PS1" -a -x /usr/bin/neofetch ] ; then
    echo
    neofetch --package_managers off --disable gpu
    echo
fi

# ENVIRONMENT VARIABLES
export VISUAL=vim
export EDITOR="$VISUAL"
# So that commands starting with space doesn't end up in history
export HISTCONTROL=ignoredups:ignorespace

# Example, user : "ads samaccountname=abc123"
# Example, group: "ads cn=group456"
ads () { ldapsearch -H "$LDAPURI" -b "$LDAPDN" -D "$LDAPUSER" -W $@ ; }

# Start and stop primary local Juju controller
if [ -n "$JUJUCTRL" ] ; then
    alias jujustart="lxc start $JUJUCTRL"
    alias jujustop="lxc stop $JUJUCTRL"
    alias jujulist="lxc list $JUJUCTRL"
fi

# ALIASES
# Nice calendar
alias outlook="ncal -s DE -y -M -w -b"
alias wjs="watch -n 3 -c juju status --color"
alias oscins="openstack --insecure"
