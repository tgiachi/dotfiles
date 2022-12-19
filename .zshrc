source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle docker
antigen bundle kubernetes
antigen bundle node
antigen bundle npm
antigen bundle brew
antigen bundle osx

antigen bundle unixorn/git-extra-commands@main
antigen bundle z-shell/zsh-navigation-tools@main
antigen bundle desyncr/auto-ls
antigen bundle MichaelAquilina/zsh-you-should-use

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply
# CONFIGURATION
# Configure if you have AWS code artifact
export CODEARTIFACT_DOMAIN=""
export CODEARTIFACT_OWNER=""

# Multi core make
export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=$(printf "%s " "${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=`./shan.js --get-yargs-completions $args`

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
    fi

    return 0
}
autoload -Uz compinit
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bitcomplete bit

# Find function
_exclude_matches=(bundle .git)
_excludes=''
for _match in $_exclude_matches; do
  _excludes="${_excludes}-name '$_match' -prune -o "
done

eval "
function my_everyday_find() {
  find \$2 \
    $_excludes \
    -name \"*\$1*\"    \
    -print;
}
"
unset _exclude_matches _excludes _match
alias f=my_everyday_find

export PATH="$PATH:/Users/squid/.dotnet/tools"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export PATH="$PATH:/opt/DoomRunner/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/home/$USER/.dotnet/tools"

alias myip="curl -4 icanhazip.com"
alias token="export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain $CODEARTIFACT_DOMAIN --domain-owner $CODEARTIFACT_OWNER --query authorizationToken --output text`"
alias open="xdg-open"
alias disable_fn="echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode"
alias vim="lvim"