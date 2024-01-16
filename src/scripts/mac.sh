echo " ____  ___       "
echo "|     |   \  |   / "
echo "|___  |    | |__/ "
echo "|     |    | |  \ "
echo "|     |__ /  |   \ "
               

curDir=`pwd` 
printf "Please select folder for installation:\n"
select d in ~/*; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d"

nodeVersion="v18.18.2"
npmVersion="9.8.1"

dir=$(dirname "$(dirname $curDir)")


curl -o node-$nodeVersion-darwin-x64.tar.gz https://nodejs.org/dist/$nodeVersion/node-$nodeVersion-darwin-x64.tar.gz
tar -xzf node-$nodeVersion-darwin-x64.tar.gz --strip-components=1
source $curDir/local.zshrc $dir

nodeVer=`node -v`

if [ "$nodeVersion" = "$nodeVer" ] 
then
    echo "Installation of node successfull!"
else
    echo "Installation of node failed! Please try again."
fi

npmVer=`npm -v`

if [ "$npmVersion" = "$npmVer" ] 
then
    echo "Installation of npm successfull!"
else
    echo "Installation of npm failed! Please try again."
fi

npm install https://cdn.freshdev.io/fdk/latest.tgz --global