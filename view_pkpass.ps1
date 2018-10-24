#Powershell script to view .pkpass files

param (
	[string]$file = ""
)

Add-Type -AssemblyName System.IO.Compression.FileSystem
$path = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType directory -Path $path
[System.IO.Compression.ZipFile]::ExtractToDirectory( $file,$path)

$json_file=Join-Path ($path) ("pass.json")

$json=(get-content $json_file) | convertfrom-json

$prim=$json.boardingPass|select -expand primaryfields|select key,value
$secon=$json.boardingPass|select -expand secondaryfields|select key,value
$aux=$json.boardingPass|select -expand auxiliaryfields|select key,value

$prim 
$secon 
$aux 

Remove-Item -path $path -force -recurse

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

