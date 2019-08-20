# #################################
# # Functions                     #
# #################################
addurl (){
  echo $1
  git remote add origin $1
}

gacm (){
  message=""
  for x in $*
  do
    message+="$x "
  done
  message="$(echo $message | sed -e 's/[[:space:]]*$//')"
  echo $message
  git commit -am "${message}"
}

nodeman (){
  nodemon --inspect $1
}
#  This will allow you to change directories, and automatically see what files are contained within it
#  ex. cdl path/to/directory
cdl () {
  cd $1
  ls
}
# This will clone a github repo and enter it automatically
# ex. gc https://github.com/SheaClose/gradResources.git
gc (){
  git clone "$1" && cd "$(basename -s .git "$1")"
}

seturl (){
  git remote set-url origin $1
}

removegitref (){
  echo $1
  git filter-branch --tree-filter "rm -rf $1" --prune-empty HEAD
  git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
  git add .gitignore
  git commit -m "Removing $1 from git history"
  git gc
}
# Make a new directory and automatically enter it.
mkcd () {
  mkdir $1
  cd $1
}

trash(){
  mv $1 ~/.Trash 
}

mobileStart() {
  open ios/Fanguru.xcworkspace/;
  npx react-native start;
}
# gpb(){
#   git push origin $(git name-rev --name-only HEAD)
#   git checkout dev
# }

# example of piping exit codes to other commands.
gpb(){
  git push origin $(git name-rev --name-only HEAD) | 
  if [ "$?" = 0 ]
  then 
    git checkout dev
  fi
}

rename (){
  find . -type f -maxdepth 1 -print0 | while read -d $'\0' file; do mv "$file" "$( echo "$file" | sed "s/\.\/$1/$2/" )" ; done
  ls
}
# git push to whatever branch you are currently on.
# replaces `git push origin master/dev/feature_branch`
gpc(){
  echo            "****************************************"
  echo pushing to $(git branch | grep \* | cut -d ' ' -f2)
  echo            "****************************************"
  git push origin $(git branch | grep \* | cut -d ' ' -f2)
}
# git push to whatever branch you are currently on.
# replaces `git push origin master/dev/feature_branch`
gpcf(){
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  printf "You're about to ${RED}FORCE push${NC} to ${RED}$(git branch | grep \* | cut -d ' ' -f2),${NC} are you ${RED}SURE?!${NC}\n"
  echo 'Press [enter] to continue, ctrl-c to exit'
  read answer
  git push origin $(git branch | grep \* | cut -d ' ' -f2) --force
}
# git pulls whatever branch you are currently on
# replaces `git push origin master/dev/feature_branch`
gpoc(){
  echo            "****************************************"
  echo pulling from $(git branch | grep \* | cut -d ' ' -f2)
  echo            "****************************************"
  git pull origin $(git branch | grep \* | cut -d ' ' -f2)
}

deploy(){
  gacm 'testing auto-deploy'
  start=$(git symbolic-ref --short -q HEAD)
  if [ -z $1 ]; then 
    echo 'Type branches you want to include [Enter: current-branch]'
    read branches
    if [ -z $branches ]; then exit 1; fi;
    for branch in $branches; 
      do echo $branch; 
      git checkout -B $branch;
      gpc
    done
  else
    for branch in "$@"; 
      do echo $branch; 
      git checkout -B $branch;
      gpc
    done
  fi;
  git checkout $start;
}
deployForce(){
  gacm 'testing auto-deploy'
  start=$(git symbolic-ref --short -q HEAD)
  if [ -z $1 ]; then 
    echo 'Type branches you want to include [Enter: current-branch]'
    read branches
    if [ -z $branches ]; then exit 1; fi;
    for branch in $branches; 
      do echo $branch; 
      git checkout -B $branch;
      git push origin $branch --force
    done
  else
    for branch in "$@"; 
      do echo $branch; 
      git checkout -B $branch;
      git push origin $branch --force
    done
  fi;
  git checkout $start;
}

dbuild(){
  echo "Type the name of your Docker Image [ENTER:(git branch name)]:"
  read image
  if [ -z $image ]; then image=$(git branch | grep \* | cut -d ' ' -f2); fi;
  ports=''
  echo "Type the container port number [ENTER: 4000]:"
  read expose
  if [ -z $expose ]; then expose=4000; fi;
  echo "Type the port number to expose (ENTER to repeat exposed port):"
  read listen
  if [ -z $listen ]; then listen=$expose; fi;
  ports+=" -p $expose:$listen"
  echo $ports
  env_vars=''
  echo "Type space delimted env variables [ex. NODE_ENV=development S3_PATH=http://path/to/thing]:"
  read envs
  # if [ -z $envs ]; then env_vars='-e NODE_ENV=production'; fi;
  for env_var in $envs; do env_vars+=" -e $env_var"; done
  # if [ -z $env_vars ]; then env_vars=-e NODE_ENV=development; fi;
  echo docker build -t $image ./
  echo docker run -d $env_vars -i $ports --name $image $image
  docker build -t $image ./
  docker run -d $env_vars -i $ports --name $image $image
}

dkill(){
  if [ -x $1 ]; then  
    docker ps -a
    echo "Type the name of the Docker Container you want to destroy [default:git-branch-name]:"
    read process_to_kill
    if [ -z $process_to_kill ]; then process_to_kill=$(git branch | grep \* | cut -d ' ' -f2); fi;
  else 
    process_to_kill=$1
  fi;
  docker stop $process_to_kill
  docker rm $process_to_kill
  docker image rm $process_to_kill
}

ebdeploy(){
  echo "Type the name of the Application"
  read app
  echo "Type the name of the env to deploy:"
  read env
  echo "Type the name of the bucket [s3://[name-of-bucket]:"
  read bucket
  echo "Type the name of the region to deploy [default: us-east-1]"
  read region
  if [ -z $region ]; then region=us-east-1; fi;
  deployment=$(date | sed 's/ //g' | md5)
  echo "Deploying version $deployment to $app:$env"
  zip -rq $deployment.zip .
  aws s3 cp $deployment.zip s3://$bucket --region $region
  aws elasticbeanstalk create-application-version --application-name $app --version-label $deployment --source-bundle S3Bucket=$bucket,S3Key=$deployment.zip --auto-create-application --region $region
  aws elasticbeanstalk update-environment --application-name $app --environment-name $env --version-label $deployment --region $region
  rm -rf *.zip
}

squash(){
  echo "How many commits would you like to squash"
  read num
  git reset --soft HEAD~$num && 
  git commit --edit -m $(git log --format=%B --reverse HEAD..HEAD@{1})
}

drm(){
  docker rm -f $1
  docker image rm -f $2
}

uncommit(){
  git reset --soft HEAD~1
  git reset HEAD
}

dbe(){
  git checkout dev
  gpoc
  git checkout test-dev
  gmd
  gpc
  git checkout test-staging
  gmd
  gpc
  git checkout test-master
  gmd
  gpc
}

iosstart(){
  cd ios
  pod repo update
  pod install
  cd ..
  open ios/Fanguru.xcworkspace
}

mkfile() { 
  mkdir -p "$(dirname "$1")";
  touch "$1" ;  
}


dexec(){
  d exec -it $(d ps -q) /bin/bash
}

cherryPick() {
  echo "Enter the commit SHA";
  read sha;
  git cherry-pick $sha;
}

killprocess () {
  if [ -z $1 ]; then 
    echo "Type the port of the Application";
    read port;
  else
    port=$1;
  fi;
  lsof -ti :$port | xargs kill;
}

gchb () {
  node /usr/local/bin/test.js "$*"
}

services() {
  for x in $(seq 4000 4010)
  do
    API_OR_WORKER=worker ENV_BRANCH=dev NODE_ENV=development S3_CONFIG_PATH=s3://cm-services/api/dev SERVICES=MediaQueue WORKER=true PORT=$x nodemon &
    # lsof -i :$x
  done
}

env() {
  if [[ $1 = "prod" ]]; then
    echo "Downloading prod env file";
    aws s3 cp s3://cm-services/api/live ./ --recursive
  else 
    echo "Downloading dev env file";
    aws s3 cp s3://cm-services/api/dev ./ --recursive
  fi;
}
