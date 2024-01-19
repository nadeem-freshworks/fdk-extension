echo " ____  ___       "
echo "|     |   \  |   / "
echo "|___  |    | |__/ "
echo "|     |    | |  \ "
echo "|     |__ /  |   \ "
               

curDir=`pwd`
printf "Please select folder for installation:\n"
select d in ~/*; do test -n "$d" && break; echo ">>> Invalid Selection"; done

nodeVersion="v18.18.2"
npmVersion="9.8.1"

# Get the configs.json path dynamically 

script_path="$0"
script_directory="$(dirname "$script_path")"
cd $script_directory
cd ../..

JSON_RAW='{\n\t"path":"%s"\n}\n'

printf $JSON_RAW $d > "configs.json"


# Go to user selcted path to download and strip the node
cd $d
curl -o node-$nodeVersion-darwin-x64.tar.gz https://nodejs.org/dist/$nodeVersion/node-$nodeVersion-darwin-x64.tar.gz
tar -xzf node-$nodeVersion-darwin-x64.tar.gz --strip-components=1


localZshrc="$script_directory/local.zshrc"

source $localZshrc

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

cd $curDir
source $localZshrc

fdk -v