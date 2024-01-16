
export ZSH="$HOME/.oh-my-zsh"

INFILE=config.json
while read -r LINE
do
    filecontent+="$LINE"
done < "$INFILE"

dir=`echo $filecontent | grep -o '"path":"[^"]*' | cut -d'"' -f4`

echo $dir

ZSH_THEME="robbyrussell"


export PATH=$dir"/mynode/bin:$PATH"