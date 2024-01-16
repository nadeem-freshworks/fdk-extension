$curDir = Get-Location


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

$relativePath = "src\configs.json"

$jsonPath = Join-Path -Path $curDir -ChildPath $relativePath


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

$nodePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node-v18.12.1-win-x64;"
$nodeGlobalPath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_global;"
$nodeCachePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_cache"


# Download Node.js
Invoke-WebRequest -Uri 'https://nodejs.org/dist/v18.12.1/node-v18.12.1-win-x64.zip' -OutFile 'node-v18.12.1-win-x64.zip'

# # Unzip the downloaded Node.js archive
Expand-Archive -Path 'node-v18.12.1-win-x64.zip' -DestinationPath 'node18'

# # Update the PATH environment variable
# # Update the PATH environment variable
$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH

$nodeGlobalPath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_global"
$nodeCachePath = Join-Path -Path $selectedDirectory.FullName -ChildPath "\node18\node_cache"

npm config set prefix $nodeGlobalPath
npm config set cache $nodeCachePath

Set-Location $curDir

# node -v
# npm -v