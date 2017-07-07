#!/bin/zsh

{
    local conf_dir="${HOME}/.zshconf"
    local cache_path="${conf_dir}/conflist.txt"
    local rcfile="${HOME}/.zshrc"

    local plug_repo="https://github.com/tarjoilija/zgen"

    local plug_dir="${HOME}/.zgen"
    local plug_start="${plug_dir}/zgen.zsh"

    local plugin_list="${conf_dir}/plugins.txt"

    local function get_plug() {
        if [[ $(whence git &>/dev/null) ]]; then
            git clone ${plug_repo} ${plug_dir}
            return ${?}
        else
            echo ".zshrc: git not installed" >&2
            exit 1
        fi
    }

    local function load_conf() {
        source ${plug_start}

        local current_list=(${conf_dir}/*.zsh(om:gs_%_%%_:gs_@_%@_))
        current_list="@${(j:@:)current_list}@"

        (){
            zgen saved || return 1

            [[ -e ${cache_path} ]] || return 1

            [[ $(< ${cache_path}) == ${current_list} ]] || return 1

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

            <<< ${current_list} > ${cache_path}
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
