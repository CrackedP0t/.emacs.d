#!/bin/zsh

{
    local conf_dir="${HOME}/.zshconf"
    local cache_path="${conf_dir}/cache.txt"
    local rc_file="${HOME}/.zshrc"

    local plug_repo="https://github.com/tarjoilija/zgen"

    local plug_dir="${HOME}/.zgen"
    local plug_start="${plug_dir}/zgen.zsh"

    local plugin_list="${conf_dir}/plugins.txt"

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
        source ${plug_start}

        local last_modified=(${conf_dir}/*.zsh(om[1]))
        local current_cache="$(zstat +mtime -- \
                                       ${last_modified})@${last_modified}"

        (){
            zgen saved || return 1

            [[ -e ${cache_path} ]] || return 1

            [[ $(< ${cache_path}) = ${~current_cache} ]] || return 1

            return 0
        }
        local conf_current=${?}

        if [[ ${conf_current} -eq 0 ]]; then
            zgen apply &>/dev/null
        else
            echo "Reloading configuration..."
            for file in ${conf_dir}/*.zsh; do
                source ${file}
            done

            zgen save &>/dev/null

            <<< ${current_cache} > ${cache_path}
        fi
    }

    mkdir -p ${conf_dir}

    if [[ ! -e ${plug_start} ]]; then
        get_plug
        load_conf
    else
        load_conf
    fi
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/elaina/.sdkman"
[[ -s "/home/elaina/.sdkman/bin/sdkman-init.sh" ]] && source "/home/elaina/.sdkman/bin/sdkman-init.sh"
