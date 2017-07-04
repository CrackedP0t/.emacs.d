#!/bin/zsh

{
    local conf_dir="${HOME}/.zshconf"
    local conf_cache="${conf_dir}/confhash.md5"

    local plug_repo="https://github.com/tarjoilija/zgen"

    local plug_dir="${HOME}/.zgen"
    local plug_start="${plug_dir}/zgen.zsh"

    local function getplug() {
        if [[ $(whence git) ]]; then
            git clone ${plug_repo} ${plug_dir}
            return $?
        else
            echo ".zshrc: git not installed" >&2
            exit 1
        fi
    }

    local function loadconf() {
        source ${plug_start}

        local conf_files=(${conf_dir}/*.zsh)

        local cache_hash=$([[ -e ${conf_cache} ]] \
                               && < ${conf_cache} || < "")
        

        
        local conf_hash=$([[ ${cache_hash} != "" ]] \
            && ${$(md5sum < ${conf_files})[1,-2]} \
                   || ${conf_hash})

        if ! zgen saved || [[ ! -e ${conf_cache} \
                                  || ${conf_hash} != ${cache_hash} ]]; then
        
            for file in ${conf_files}; do
                echo "file: ${file}"
                source ${file}
            done

            zgen save

            >! ${conf_cache} <<< ${conf_hash}
        fi
    }

    mkdir -p ${conf_dir}

    if [[ ! -e ${plug_start} ]]; then
        getplug
        loadconf
    else
        loadconf
    fi
}
