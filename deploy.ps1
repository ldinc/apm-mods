# Builds mod(s) with goft.exe into the selected Factorio environment and
# optionally launches the game (the PowerShell equivalent of copy.bat /
# reload.bat, plus a git "changed mods" mode).
#
# Usage:
#   ./deploy.ps1 -All                              # build the full mod set
#   ./deploy.ps1 -Changed                          # build only mods with uncommitted changes
#   ./deploy.ps1 apm_lib apm_power                 # build specific mod folders
#   ./deploy.ps1 -Changed -Launch                  # build changed mods, then run the game
#   ./deploy.ps1 -All -Environment unstable -Launch
#
# The install paths come from build.config.json keys .factorio.stable /
# .factorio.unstable (same as copy.bat / reload.bat).

param(
	[ValidateSet("stable", "unstable")]
	[string]$Environment = "stable",

	[switch]$All,
	[switch]$Changed,
	[switch]$Launch,

	[Parameter(ValueFromRemainingArguments = $true)]
	[string[]]$Mods
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

$buildAllMods = @("apm_lib", "apm_nuclear", "apm_power", "apm_resource_pack", "apm_energy_addon")

$cfg = Get-Content "build.config.json" -Raw | ConvertFrom-Json
$target = $cfg.factorio.$Environment
if (-not $target) {
	Write-Error "build.config.json has no .factorio.$Environment path"
	exit 1
}

if ($All) {
	$Mods = $buildAllMods
} elseif ($Changed) {
	$Mods = @(
		git -c core.quotepath=false status --porcelain |
		ForEach-Object { $_.Substring(3).Trim('"').Split('/')[0] } |
		Sort-Object -Unique |
		Where-Object { Test-Path (Join-Path $_ "info.json") }
	)

	if ($Mods.Count -eq 0) {
		Write-Host "No changed mod folders (with info.json) detected; nothing to deploy."
		exit 0
	}
}

if (-not $Mods -or $Mods.Count -eq 0) {
	Write-Error "No mods specified. Use -All, -Changed, or pass mod folder names."
	exit 1
}

$out = Join-Path $target "mods"
Write-Host "Deploying [$Environment] -> $out"
Write-Host "  mods: $($Mods -join ', ')"
& goft.exe -b -o $out @Mods
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

if ($Launch) {
	$exe = Join-Path $target "bin\x64\factorio.exe"
	Write-Host "Starting $exe"
	& $exe
}
