export function gi() { curl -Ls https://www.gitignore.io/api/$@ ;}

export function bumpconf() {
    file=${1}
}

export function mm2in() {
    print $(( ${1} * 0.0393701 ))
}

prefix_file="${HOME}/.config/wineswitch"
prefix_dir="${HOME}/.prefixes"

export function wineswitch() {
    if [[ ${1} != "" ]]; then
        echo ${1} > ${prefix_file}
        export WINEPREFIX="${prefix_dir}/${1}"
    else
        rm ${prefix_file}
        unset WINEPREFIX
    fi
}

if [[ -e ${prefix_file} ]]; then
    export WINEPREFIX="${prefix_dir}/$(< ${prefix_file})"
else
    unset WINEPREFIX
fi

local alias_file="${conf_dir}/10-aliases.zsh"

export function aa() {
    if (( ${#} != 2)); then
        print "Usage: aa ALIAS COMMAND"
        print "Alias ALIAS to COMMAND and append to conf file."
        return 1
    fi

    echo "\nalias ${1}='${2}'" >> ${alias_file}

    alias ${1}=${2}
}

export function plasma-restart() {
    kquitapp5 plasmashell
    kstart5 plasmashell &> /dev/null

    disown
}
