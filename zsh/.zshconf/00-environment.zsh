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

pb /usr/local/sbin \
   /usr/local/bin \
   /usr/bin \
   /usr/bin/site_perl \
   /usr/bin/vendor_perl \
   /usr/bin/core_perl

pb ${HOME}/.cargo/bin \
   ${DEVKITARM}/bin \
   ${HOME}/Development/bin \
   ${HOME}/.bin \
   ${HOME}/.gem/ruby/2.4.0/bin

export EDITOR="emacsclient"
export VISUAL="emacsclient"

export DEVKITPRO="/opt/devkitpro"
export DEVKITARM="${DEVKITPRO}/devkitARM"

export GPG_TTY=$(tty)

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
