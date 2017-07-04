#!/usr/bin/zsh

function gi() { curl -Ls https://www.gitignore.io/api/$@ ;}

function bumpconf() {
	file=${1}
}
