
param (
    [string]$configPath
)

Clear-Host
Write-Host "Loading the FDK"
# get the path configs
$curDir = Get-Location
$relativePath = $configPath

$jsonFilePath =  $configPath #Join-Path -Path $curDir -ChildPath $relativePath

$jsonContent = Get-Content -Path $jsonFilePath -Raw

# Convert the JSON string to a PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json

$nodeDir = $jsonObject.path


$nodeVersion = "v18.12.1"

$nodePath = Join-Path -Path $nodeDir -ChildPath "\node18\node-$nodeVersion-win-x64;"
$nodeGlobalPath = Join-Path -Path $nodeDir -ChildPath "\node18\node_global;"


$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH


# Specify desired versions
$nodeVersion = "v18.12.1"
$npmVersion = "8.19.2"

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

$fdkVersion = fdk -v
Write-Host "Successfully loaded fdk $fdkVersion ."