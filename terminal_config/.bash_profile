source ~/.git-completion.bash
source ~/.git-prompt.sh

txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtrst='\[\e[0m\]'    # Text Reset

GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=exfxcxdxHxegedabagacGx
export ANDROID_HOME=/usr/local/Caskroom/android-sdk/25.2.3
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME=/usr/local/Caskroom/android-sdk/25.2.3
export JAVA_HOME=/Library/Java/Home

export PS1="\n"$txtred$USER" 🍺  "$txtgrn"\w "'$(
		if [[ $(__git_ps1) =~ \*\)$ ]]; then
		# a file has been modified but not added
			echo "'$txtylw'"$(__git_ps1 "(%s)")
		elif [[ $(__git_ps1) =~ \+\)$ ]]; then
		# a file has been added, but not commited
			echo "'$txtpur'"$(__git_ps1 "(%s)")
		# the state is clean, changes are commited
		else
			echo "'$txtcyn'"$(__git_ps1 "(%s)")
		fi)'"\n"$txtblu"=> "$txtrst

#################################
# Functional Shortcuts          #
#################################

# Create a directory and enter it immediately
mkcd () {
  mkdir $1
  cd $1
}
# Enter a directory and list contents including hidden files
cdl () {
  cd $1
  ls
}
# Open with Chrom
chrome () {
  open -a "Google Chrome" "$1"
}
# Change Directories to parent and list
ls.. () {
	cd ..
	ls
}
# Git add commit all at once
gacm (){
	git add -A
	git commit -m "$1"
}

# Git clone, enter directory and immediately live-serve. is "lsq" is provided
#   as an argument
gc (){
  git clone $1 $2
  cdl $2
  if [ "$3" = "lsq" ]
  then
    live-server index.html
  fi
}

seturl (){
  git remote set-url origin $1
}
addurl (){
  git remote add origin $1
}
#################################
# Aliases                       #
#################################


alias ll='ls -lah'
alias gg='git status -s'
alias dm="cdl ~/devmtn"
alias ..="cdl .."
alias lsq='live-server --cors --port=8081'
alias gs='git status'
alias ga='git add -A'
alias gcm='git commit -m'
alias gb='git branch'
alias gco='git checkout'
alias gp='git push'
alias gr='git remote -v'
alias gpom="git push origin master"
alias prof="code ~/.bash_profile"
alias reprof=". ~/.bash_profile"
alias .="code ."
alias src="source ~/.bash_profile"
alias start="yarn start"
alias build="yarn build"

alias f='open -a Finder ./'
