# Change directory to your project folder
Set-Location 'C:\Users\nbhati\codebase\freshdesk\fdk-extension\mynode\'

# Download Node.js 18 for Windows
Invoke-WebRequest -Uri 'https://nodejs.org/dist/v18.12.1/node-v18.12.1-win-x64.zip' -OutFile 'node-v18.12.1-win-x64.zip'

# Unzip the downloaded Node.js archive
Expand-Archive -Path '.\node-v18.12.1-win-x64.zip' -DestinationPath '.\' -Force

# Set Node.js environment variables (assuming PowerShell)
$env:Path += ";C:\Users\nbhati\codebase\freshdesk\fdk-extension\mynode\node-v18.12.1-win-x64"

# Check Node.js version
node -v

# Install your custom project using npm
npm install https://cdn.freshdev.io/fdk/latest.tgz --global
