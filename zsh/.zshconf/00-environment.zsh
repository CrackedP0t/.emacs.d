#!/usr/bin/zsh

export EDITOR="emacs-or-client"
export VISUAL="emacs-or-client"

export DEVKITPRO="/opt/devkitpro"
export DEVKITARM="${DEVKITPRO}/devkitARM"

export PATH="${DEVKITARM}/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:${PATH}"
