#!/usr/bin/zsh

function pb() {
    for dir in ${(Oa)@}; do
        [[ -d ${dir} ]] && \
            export PATH="${dir}:${PATH}"
    done
}

function pe() {
    for dir in ${@}; do
        [[ -d ${dir} ]] && \
            export PATH="${PATH}:${dir}"
    done
}

export EDITOR="emacs-or-client"
export VISUAL="emacs-or-client"

export DEVKITPRO="/opt/devkitpro"
export DEVKITARM="${DEVKITPRO}/devkitARM"

pb /usr/local/sbin \
   /usr/local/bin \
   /usr/bin \
   /usr/bin/site_perl \
   /usr/bin/vendor_perl \
   /usr/bin/core_perl

pb ${HOME}/.cargo/bin \
   ${DEVKITARM}/bin \
   ${HOME}/Development/bin \
   ${HOME}/.bin

# source "${HOME}/Development/Repositories/emsdk-portable/emsdk_env.sh" \
    #        > /dev/null
