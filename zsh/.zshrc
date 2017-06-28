#!/bin/zsh

local conf_dir="${HOME}/.zshconf"
local plug_dir="${HOME}/.zgen"
local plug_init="${plug_dir}/zgen.zsh"

local plug_repo="https://github.com/tarjoilija/zgen"

local function getplug() {
	if [[ $(whence git) ]]; then
		git clone ${plug_repo} ${plug_dir}
		return $?
	else
		throw ".zshrc: git not installed"
	fi
}

local function loadconf() {
	source ${plug_init}

	local conf_files=(${conf_dir}/*.zsh)

	echo ${conf_files}

	local conf_state=(${conf_files})

	echo ${conf_state}

	if ! zgen saved; then
		for file in ${conf_files}; do
			source ${file}
			echo "Loaded ${file}"
		done

		zgen save
	fi
}

mkdir -p ${conf_dir}

if [[ ! -e ${plug_init} ]]; then
	getplug
	loadconf
else
	loadconf
fi
