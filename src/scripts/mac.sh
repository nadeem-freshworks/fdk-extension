

# this script works for mac only
# try a seective folder instead of temp folder
#  node running check 
cd  '/Users/nbhati/codebase/freshdesk/fdk-extension/mynode/'

curl -o node-v18.12.1-darwin-x64.tar.gz https://nodejs.org/dist/v18.12.1/node-v18.12.1-darwin-x64.tar.gz
tar -xzf node-v18.12.1-darwin-x64.tar.gz --strip-components=1
source /Users/nbhati/codebase/freshdesk/fdk-extension/src/scripts/local.zshrc
node -v

npm install https://cdn.freshdev.io/fdk/latest.tgz --global


