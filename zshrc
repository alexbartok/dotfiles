# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
        miekg/lean
        zsh-users/zsh-completions src
        zsh-users/zsh-history-substring-search
        zsh-users/zsh-syntax-highlighting
        zsh-users/zsh-autosuggestions
        supercrabtree/k
        skx/sysadmin-util
        zsh-users/zsh-completions
        changyuheng/zsh-interactive-cd
        zpm-zsh/colors
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    # zgen load zsh-users/zsh-completions src

    # theme
    # zgen oh-my-zsh themes/arrow

    # save all to init script
    zgen save
fi
####################

# history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt share_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
# expand aliases inline
globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}
zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# screen welcome
if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
  detached_screens=$(screen -list | grep Detached)
  if [ ! -z "$detached_screens" ]; then
    echo "+---------------------------------------+"
    echo "| Detached screens are available:       |"
    echo "$detached_screens"
    echo "+---------------------------------------+"
  fi
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
alias k="k -h"
alias mc='LANG=en_EN.UTF-8 mc'
source ~/.zgen/zpm-zsh/colors-master/colors.plugin.zsh
export CLICOLOR=1
export CLICOLOR_FORCE=1
export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export PATH="/usr/local/sbin:$PATH"
