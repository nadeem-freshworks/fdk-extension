param (
    [string]$configPath
)

$curDir = Get-Location

# Specify desired versions
$nodeVersion = "v18.12.1"
$npmVersion = "8.19.2"

Write-Host  $curDir
Write-Host "Please select folder for installation:"

# Get a list of directories in the user's home folder
$directories = Get-ChildItem -Directory ~/*

# Display the list of directories and prompt the user to select one
$i = 1
foreach ($directory in $directories) {
    Write-Host "$i. $($directory.Name)"
    $i++
}

# Prompt for user selection
do {
    $selection = Read-Host "Enter the number for the desired folder"
    $selectedDirectory = $directories[$selection - 1]
    if (-not $selectedDirectory) {
        Write-Host ">>> Invalid Selection"
    }
} while (-not $selectedDirectory)


$jsonPath = $configPath


# Make necessary modifications to the JSON object
# For example, let's update a property called 'exampleProperty'
$jsonData = @{
    path = $selectedDirectory.FullName
}

# Convert the modified object back to JSON format
$jsonString = $jsonData | ConvertTo-Json -Depth 10

# Save the updated JSON content back to the file
$jsonString | Set-Content -Path $jsonPath -Force


# Change the current directory to the selected folder
Set-Location $selectedDirectory.FullName

Clear-Host
Write-Host "Installing the FDK"

$nodeVersion = "v18.12.1"

$nodePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node-$nodeVersion-win-x64;"
$nodeGlobalPath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_global;"
$nodeCachePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_cache"


# Download Node.js
Invoke-WebRequest -Uri "https://nodejs.org/dist/v18.12.1/node-$nodeVersion-win-x64.zip" -OutFile "node-$nodeVersion-win-x64.zip"

# # Unzip the downloaded Node.js archive
Expand-Archive -Path "node-$nodeVersion-win-x64.zip" -DestinationPath 'node18'

# # Update the PATH environment variable
# # Update the PATH environment variable
$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH

$nodeGlobalPath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_global"
$nodeCachePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_cache"

npm config set prefix $nodeGlobalPath
npm config set cache $nodeCachePath

Set-Location $curDir

# Get node version
$nodeVer = node -v


# Check node installation
if ($nodeVersion -eq $nodeVer) {
    Write-Host "Installation of node successful!"
} else {
    Write-Host "Installation of node failed! Please try again."
    exit
}

# Get npm version
$npmVer = npm -v

# Check npm installation
if ($npmVersion -eq $npmVer) {
    Write-Host "Installation of npm successful!"
} else {
    Write-Host "Installation of npm failed! Please try again."
    exit
}

npm install 'https://cdn.freshdev.io/fdk/latest.tgz' --global

$fdkVersion = fdk -v
Write-Host "Successfully installed fdk $fdkVersion."