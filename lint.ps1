# Lints the mods in a Docker container: Factorio headless, lua-language-server and
# the Factorio types are inside the image, the repo is mounted read-only, findings
# are printed to the console and a detailed Markdown report is written to
# lint-report\lint-report.md. Only apm_energy_addon, apm_lib, apm_nuclear,
# apm_power and apm_resource_pack are linted (see tools/lint/README.md).
#
# Usage:
#   ./lint.ps1                            # LuaLS + Factorio data check, all linted mods
#   ./lint.ps1 luals                      # only LuaLS (no game run)
#   ./lint.ps1 luals apm_nuclear          # one mod
#   ./lint.ps1 data --profile base        # only the Factorio check, without Space Age
#   ./lint.ps1 -h                         # all lint options
#   ./lint.ps1 --rebuild                  # rebuild the image (e.g. new Factorio version)
#   ./lint.ps1 --factorio-version 2.1.21
#   ./lint.ps1 --out C:\temp\lint          # other report folder
#   ./lint.ps1 --mods-dir D:\Games\Factorio\mods
#
# Needs Docker Desktop (Linux containers). The first run builds the image (downloads
# Factorio headless, lua-language-server and Node.js packages, a few minutes).
# The Factorio version defaults to the one of the install in build.config.json
# (factorio.stable), so the container checks against the same version you play.
# Non-repo dependencies (freeplay_starting_equipment) are taken from your Factorio
# mods folder, mounted read-only. Cached vanilla dumps live in the Docker volume
# "apm-lint-cache" (remove it with: docker volume rm apm-lint-cache).
#
# If script execution is blocked, run with:
#   powershell -NoProfile -ExecutionPolicy Bypass -File lint.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"  # docker writes progress to stderr

$repo = $PSScriptRoot
$rebuild = $false
$factorioVersion = $null
$outDir = Join-Path $repo "lint-report"
$modsDir = $null
$lintArgs = @()

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "--rebuild"          { $rebuild = $true }
        "--factorio-version" { $i++; $factorioVersion = $args[$i] }
        "--out"              { $i++; $outDir = $args[$i] }
        "--mods-dir"         { $i++; $modsDir = $args[$i] }
        default              { $lintArgs += $args[$i] }
    }
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "docker not found: install Docker Desktop and make sure it is running."
    exit 2
}

# Factorio install from build.config.json: version and mods folder
$factorioRoot = $null
$configPath = Join-Path $repo "build.config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath -Raw | ConvertFrom-Json
    if ($config.PSObject.Properties["factorio"] -and $config.factorio.PSObject.Properties["stable"]) {
        $candidate = $config.factorio.stable
        if ($candidate -and (Test-Path (Join-Path $candidate "data\base\info.json"))) {
            $factorioRoot = $candidate
        }
    }
}
if (-not $factorioVersion) {
    if ($factorioRoot) {
        $factorioVersion = (Get-Content (Join-Path $factorioRoot "data\base\info.json") -Raw | ConvertFrom-Json).version
    } else {
        $factorioVersion = "2.1.20"
    }
}
if (-not $modsDir) {
    foreach ($candidate in @(
            $(if ($factorioRoot) { Join-Path $factorioRoot "mods" }),
            $(if ($env:APPDATA) { Join-Path $env:APPDATA "Factorio\mods" }))) {
        if ($candidate -and (Test-Path $candidate)) { $modsDir = $candidate; break }
    }
}

# image
$image = "apm-lint:$factorioVersion"
docker image inspect $image *> $null
if ($rebuild -or $LASTEXITCODE -ne 0) {
    Write-Host "Building $image ..."
    docker build -t $image --build-arg "FACTORIO_VERSION=$factorioVersion" (Join-Path $repo "tools\lint")
    if ($LASTEXITCODE -ne 0) { Write-Host "docker build failed"; exit 2 }
}

# report folder and links from the report back to the sources
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$outFull = (Resolve-Path $outDir).Path
$repoFull = (Resolve-Path $repo).Path
if ($outFull.StartsWith($repoFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    $depth = @($outFull.Substring($repoFull.Length).Trim("\", "/") -split "[\\/]" | Where-Object { $_ }).Count
    $linkPrefix = ("../" * $depth)
} else {
    $linkPrefix = "file:///" + ($repoFull -replace "\\", "/").TrimEnd("/") + "/"
}

$dockerArgs = @(
    "run", "--rm",
    "-v", "${repoFull}:/repo:ro",
    "-v", "${outFull}:/out",
    "-v", "apm-lint-cache:/cache",
    "-e", "APM_LINT_REPORT_LINK_PREFIX=$linkPrefix",
    "-e", "APM_LINT_UTC_OFFSET_MINUTES=$([System.TimeZoneInfo]::Local.GetUtcOffset([DateTime]::Now).TotalMinutes)"
)
if ($modsDir) {
    $dockerArgs += @("-v", "$((Resolve-Path $modsDir).Path):/mods:ro")
} else {
    Write-Host "No Factorio mods folder found: non-repo dependencies (freeplay_starting_equipment) will be missing. Use --mods-dir."
}
$dockerArgs += $image
$dockerArgs += $lintArgs

Write-Host "Linting with $image (repo read-only, report in $outFull) ..."
& docker @dockerArgs
$code = $LASTEXITCODE
if (Test-Path (Join-Path $outFull "lint-report.md")) {
    Write-Host "Report: $(Join-Path $outFull 'lint-report.md')"
}
exit $code
