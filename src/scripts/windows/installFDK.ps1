
$curDir = Get-Location
$relativePath = "src\configs.json"

$jsonFilePath = Join-Path -Path $curDir -ChildPath $relativePath

$jsonContent = Get-Content -Path $jsonFilePath -Raw

# Convert the JSON string to a PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json

$nodeDir = $jsonObject.path

$nodePath = Join-Path -Path $nodeDir -ChildPath "\node18\node-v18.12.1-win-x64;"
$nodeGlobalPath = Join-Path -Path $nodeDir -ChildPath "\node18\node_global;"

$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH

$nodeGlobalPath = Join-Path -Path $nodeDir -ChildPath "\node18\node_global"
$nodeCachePath = Join-Path -Path $nodeDir -ChildPath "\node18\node_cache"

npm config set prefix $nodeGlobalPath
npm config set cache $nodeCachePath

# Install FDK globally using npm
npm install 'https://cdn.freshdev.io/fdk/latest.tgz' --global

fdk -v