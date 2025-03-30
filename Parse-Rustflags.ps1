$rustflags = $args

if ($rustflags.Length -eq 0) {
	Write-Host "No rustflags provided"
	exit 0
}

$config_path = ".cargo/config.toml"
$config = Get-Content $config_path | ConvertFrom-Toml
if (-not $config.target) {
    $config.target = @{}
}
if (-not $config.target.Item("cfg(all())")) {
    $config.target.Item("cfg(all())") = @{}
}
$config.target.Item("cfg(all())").rustflags = $rustflags
$config | ConvertTo-Toml -Depth 5 | Out-File $config_path