#!/usr/bin/zsh

local function error() {
	if [[ ${1} != "" ]]; then
		print "\n${@}" >&2
	fi

	exit 1
}

local function assert() {
	if [[ ! ${2} =~ "[[:digit:]]+" ]]; then
		error "assert: invalid arguments [${:-'${^@}'}]"
	fi

	local code=${2}

	if (( ${code} != 0 )); then
		error $1
	fi

	return 0
}

whence stow &>/dev/null
assert "stow is not installed" $?

local -A args

zparseopts -A args -M -E -D -K \
		   -dir: d:=-dir \
		   -target: t:=-target \
		   -install I=-install \
		   -delete D=-delete \
		   -reset R=-reset \
		   -action: a:=-action
assert "zparseopts failed" $?

local -A opts=(dir . target .. action install)

for arg val in "${(@kv)args}"; do
	local opt=${arg/--/}
	opts[${opt}]=${val}

	case ${opt} in
		dir)
			[[ -d ${val} ]]
			assert "'dir' is not a directory" $?
			;;

		target)
			[[ -d ${val} ]]
			assert "'target' is not a directory" $?
			;;

		install|delete|reset)
			opts[action]=${opt}
			unset "opts[${opt}]"
			;;

		action)
			[[ ${val} =~ "install|delete" ]]
			assert "'action' can only be 'install', 'delete', or reset" $?
			;;
	esac
done

local packages=(${opts[dir]}/*(/:t))

local -A verbmap=(install installing delete deleting reset resetting)
local -A stowmap=(install stow delete delete reset restow)

local actionverb=${verbmap[${opts[action]}]}
local stowopt=${stowmap[${opts[action]}]}

for package in ${packages}; do
	print -n "${actionverb} ${package}... "

	local stowout=$(stow \
		--${stowopt} \
		-d ${opts[dir]} \
		-t ${opts[target]} \
		${package} \
		2>&1 1>/dev/null)
	assert "stow failed" $?

	[[ ${stowout} == "" ]]
	assert "stow warning: '${stowout}'" $?

	print "done"
done
