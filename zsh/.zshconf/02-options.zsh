setopt list_packed
setopt correct
setopt rm_star_silent
setopt hist_ignore_dups
setopt share_history

# bindkey -e
bindkey "^[[3~" delete-char

# no c-s/c-q output freezing
setopt noflowcontrol
# allow expansion in prompts
setopt prompt_subst
# this is default, but set for share_history
setopt append_history
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
# setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# not just at the end
setopt completeinword
# use zsh style word splitting
setopt noshwordsplit
# allow use of comments in interactive code
setopt interactivecomments

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# don't error out when unset parameters are used
setopt unset

setopt nobeep
