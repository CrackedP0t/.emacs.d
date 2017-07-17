local function p+() {
    local path_array=(${PATH} ${@})
    export PATH=${(j_:_)path_array}
}

export EDITOR="emacs-or-client"
export VISUAL="emacs-or-client"

export DEVKITPRO="/opt/devkitpro"
export DEVKITARM="${DEVKITPRO}/devkitARM"

export RUST_SRC_PATH="${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

export PATH="${HOME}/.cargo/bin:/${DEVKITARM}/bin:${HOME}/Development/bin:${HOME}/.bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:${PATH}"

# source "${HOME}/Development/Repositories/emsdk-portable/emsdk_env.sh" \
#        > /dev/null

export ANDROID_HOME="/opt/android-sdk"

export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
