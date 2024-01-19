
export ZSH="$HOME/.oh-my-zsh"

# Get the presnt working directory
curDir=`pwd`

# Get the configs.json path dynamically 

script_path="$0"
script_directory="$(dirname "$script_path")"
cd $script_directory
cd ../..
INFILE="configs.json"

while read -r LINE
do
    filecontent+="$LINE"
done < "$INFILE"

# get the path where node is copied
dir=`echo $filecontent | grep -o '"path":"[^"]*' | cut -d'"' -f4`

ZSH_THEME="robbyrussell"

export PATH="$dir/bin:$PATH"

cd $curDir

