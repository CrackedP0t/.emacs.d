{
    local rc_file="${HOME}/.zshrc"

    local plug_repo="https://github.com/tarjoilija/zgen"

    local plug_dir="${HOME}/.zgen"
    local plug_start="${plug_dir}/zgen.zsh"

    local local_plugin_dir="${conf_dir}/plugins"
    local local_theme="${conf_dir}/theme"

    local function get_plug() {
        if [[ $(whence git) ]]; then
            git clone ${plug_repo} ${plug_dir}
            return ${?}
        else
            echo $?
            echo ".zshrc: git not installed" >&2
            exit 1
        fi
    }

    local function load_conf() {
        ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)

        source ${plug_start}

        if ! zgen saved; then
            zgen load "zsh-users/zsh-completions"
            zgen load "zsh-users/zsh-syntax-highlighting"
            zgen load "zsh-users/zsh-autosuggestions"

            zgen save
        fi


        for file in ${conf_dir}/[2-9]*.zsh; do
            source ${file}
        done
    }

    local function setup_prompt() {
        PROMPT=$'%(0?..%F{1}%?) %F{blue}%~/ %F{gray}❯%f '
        # PROMPT=$'\ek%~/ >\e\\%(0?..%F{1}%?) %F{blue}%~/ %F{gray}❯%f '
    }

    mkdir -p ${conf_dir}

    if [[ ! -e ${plug_start} ]]; then
        get_plug
    fi

    load_conf

    setup_prompt

    zstyle ':completion:*' insert-tab false
}

function preexec() {
    echo -n "\ek${1}\e\\"
}

# added by travis gem
[ -f /home/elaina/.travis/travis.sh ] && source /home/elaina/.travis/travis.sh
