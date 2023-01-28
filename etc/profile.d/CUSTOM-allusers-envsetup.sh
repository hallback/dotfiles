if [ -f /usr/share/powerline/bindings/bash/powerline.sh ] ; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

alias ls='ls --color -F'

export PATH=$HOME/bin:$PATH

# As I typically set Region, Numbers, Time, Currency and Measurement to en_SE.UTF-8
# in KDE, these will become C.UTF-8 in a shell probably since it is not a valid locale.
#
# LC_ALL remains unset.
#
# From scratch on any system:
# locale-gen sv_SE.UTF-8
# locale-gen en_US.UTF-8
# update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en
# locale | egrep ^LC_ | grep -v LC_ALL | sed 's/=.*/=sv_SE.UTF-8/g' >> /etc/default/locale
#
# More info: https://help.ubuntu.com/community/Locale
#
if [ -f /etc/default/locale ] ; then
    source /etc/default/locale
fi
