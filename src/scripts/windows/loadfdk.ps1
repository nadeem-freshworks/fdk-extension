
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

$nodePath = Join-Path -Path $nodeDir -ChildPath "\node18\node-v18.12.1-win-x64;"
$nodeGlobalPath = Join-Path -Path $nodeDir -ChildPath "\node18\node_global;"


$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH

fdk -v