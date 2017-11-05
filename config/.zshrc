# export TERM=xterm-256color

# Path to your oh-my-zsh installation.
export ZSH=/home/penguinrage/.oh-my-zsh
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export CLASSPATH="/home/penguinrage/bin:/home/penguinrage/repositories/language_implementation/antlr-4.5.3-complete.jar:/usr/local/bin:$CLASSPATH"
export VISUAL="vim"

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="lambda-mod"
#ZSH_THEME="half-life"
#ZSH_THEME="bullet-train"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump git pep8 ruby arch colored-man extract web-search docker gradle)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="/home/penguinrage/.gem/ruby/2.3.0/bin:/home/penguinrage/anaconda3/bin:$PATH"

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

r=$(($RANDOM%4))
if [ $r -eq 0 ]; 
then 
    LS_COLORS=$LS_COLORS:'di=0;32:' ; export LS_COLORS
elif [ $r -eq 1 ]; 
then 
    LS_COLORS=$LS_COLORS:'di=0;36:' ; export LS_COLORS
elif [ $r -eq 2 ]; 
then 
    LS_COLORS=$LS_COLORS:'di=0;34:' ; export LS_COLORS
else
    LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
fi

# Aliases
alias weather='curl -4 wttr.in/Sydney 2> /dev/null | head -n 37'
alias mySignal="iwconfig wlp1s0 | grep -i --color quality"
alias gg="gdb -tui"
alias diff='colordiff'
## pass options to free ## 
alias meminfo='free -m -l -t'
alias vlive='source venv/bin/activate'
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias mirrorlist='sudo pacman-mirrors -i -m random'
alias docker='sudo docker'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# root vim :)
alias rvim='sudo -E vim'   
## Get server cpu info ##
alias cpuinfo='lscpu'
alias fuckit='git add .; git commit -m "$(curl -s whatthecommit.com/index.txt)"; git push' 
alias diff='colordiff'

# alias elastic_start='systemctl start elasticsearch'
# alias elastic_stop='systemctl stop elasticsearch'
alias ghistory='git log --graph --oneline --all'
# alias postlive='sudo systemctl start postgresql'

## Antlr4
alias grun='java org.antlr.v4.runtime.misc.TestRig'

#export CLASSPATH=".:/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH"
#alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH" org.antlr.v4.Tool'

## get GPU ram on desktop / laptop## 
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[[ -f ~/.extend_cd.bashrc ]] && . ~/.extend_cd.bashrc
# added by travis gem
[ -f /home/penguinrage/.travis/travis.sh ] && source /home/penguinrage/.travis/travis.sh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
