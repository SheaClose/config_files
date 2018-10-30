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
export PATH=$PATH:/usr/local/bin/:/Users/sheaclose/Library/Android/sdk/platform-tools
export NODE_ENV=development
export JAVA_HOME=/Library/Java/Home
export ANDROID_SDK=/Users/sheaclose/Library/Android/sdk
export PS1="\n"$txtred$USER" 🍺  "$txtgrn"\w "'$(
        if [[ $(__git_ps1) =~ \*\)$ ]]; then
            echo "'$txtylw'"$(__git_ps1 "(%s)")
        elif [[ $(__git_ps1) =~ \+\)$ ]]; then
            echo "'$txtpur'"$(__git_ps1 "(%s)")
        else
            echo "'$txtcyn'"$(__git_ps1 "(%s)")
        fi)'"\n"$txtblu"=> "$txtrst
# #################################
# # Functions                     #
# #################################
addurl (){
  echo $1
  git remote add origin $1
}

gacm (){
  git add -A
  git commit -m "$1"
}

generateThatGreenDot (){
  # echo -n 'Generate new green dot? Y/N ---> '
  # read GRABTHATDOT
  # if [ $GRABTHATDOT = "Y" ]
  # then BOOL="Y"
  # elif [ $GRABTHATDOT = "y" ]
  # then BOOL="Y"
  # else BOOL="N"
  # fi 
  # if [ $BOOL = "Y" ]
  # then
    echo "$(curl -s https://cbsg.sourceforge.io/cgi-bin/live | grep -Eo '^<li>.*</li>' | sort -r | tail -n1)" >> ~/devmtn/personal/commit_thing/index.html 
    echo "$(date -u)" >> ~/devmtn/personal/commit_thing/commit.log
    git -C ~/devmtn/personal/commit_thing add .
    git -C ~/devmtn/personal/commit_thing commit -m "$(curl -s whatthecommit.com/index.txt)"
    git -C ~/devmtn/personal/commit_thing push origin master
  # fi
}

nodeman (){
  nodemon --inspect $1
}

cdl () {
  cd $1
  ls
}

ref (){
  rm -rf $1
  mkdir $1
  ls
}

# example of piping exit codes to other commands.
# lintandcommit (){
#   eslint lint | 
#   if [ "$?" = 0 ]
#   then gacm $1
#   fi
# }

chrome () {
  open -a "Google Chrome" "$1"
}

gc (){
  git clone "$1" && cd "$(basename -s .git "$1")"
  if [ "$2" = "lsq" ]
  then
    live-server index.html
  fi
}

seturl (){
  git remote set-url origin $1
}

removegitref (){
  git filter-branch --tree-filter "rm -rf $1" --prune-empty HEAD
  git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
  git add .gitignore
  git commit -m "Removing $1 from git history"
  git gc
}

mkcd () {
  mkdir $1
  cd $1
}

trash(){
  mv $1 ~/.Trash 
}

createParcelApp(){
  mkdir $1
  cd $1
  mkdir src
  mkdir public
  cp ~/templates/index.html ./public
  cp ~/templates/index.js ./src
  cp ~/templates/App.js ./src
  cp ~/templates/package.json ./package.json
  npm i
  echo 'All done, open in your favorite code editor and run with npm run start'
}

# #################################
# # Aliases                       #
# #################################
alias .="code ."
alias remove="rm -rf"
alias gs="git status"
alias start="npm run start"
alias dev="npm run dev"
alias gb="git branch"
alias gp="git push"
alias gps="git push --set-upstream origin master"
alias ll="ls -lah"
alias psql="sudo -u postgres SheaClose"
alias tldrpages="code ~/devmtn/Personal/open_source/tldr"
alias dogco="ssh root@104.236.202.251"
alias gpom="git push origin master"
alias lsq="live-server --cors --port=8081"
alias photos="cd ~/Pictures/Photos\ Library.photoslibrary/Masters/"
alias f="open -a Finder ./"
alias gr="git remote -v"
alias prof="code ~/.bash_profile"
alias src="source ~/.bash_profile"
alias mongostart="mongod --fork --syslog"
alias please="npm"
# generateThatGreenDot
