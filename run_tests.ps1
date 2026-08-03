# Runs the standalone Lua unit tests (*.test.lua) with a plain Lua interpreter.
# The tests stub the Factorio environment themselves and are run with their
# own directory as the working directory.
#
# Usage:
#   ./run_tests.ps1                                  # all tests in the repo
#   ./run_tests.ps1 apm_lib                          # all tests of one mod (folder)
#   ./run_tests.ps1 apm_lib/lib/utils                # tests in one folder
#   ./run_tests.ps1 apm_lib/lib/script/radiation.test.lua   # a single test file
#
# The Lua interpreter is taken from PATH; override it with -LuaBin:
#   ./run_tests.ps1 -LuaBin "C:\Users\drogu\AppData\Local\Programs\Lua\bin\lua.exe"
#
# If script execution is blocked, run with:
#   powershell -NoProfile -ExecutionPolicy Bypass -File run_tests.ps1
#
# Note: apm_lib/lib/containers/dllist.test.lua is known to fail
# (unreliable, see AGENTS.md).

param(
    [string]$Target = ".",
    [string]$LuaBin = "lua"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

Set-Location $PSScriptRoot

if (Test-Path $Target -PathType Leaf) {
    $files = @(Get-Item $Target)
} else {
    $files = @(Get-ChildItem -Path $Target -Recurse -Filter *.test.lua -File | Sort-Object FullName)
}

if ($files.Count -eq 0) {
    Write-Host "No test files found for: $Target"
    exit 1
}

$pass = 0
$fail = 0

foreach ($f in $files) {
    Push-Location $f.DirectoryName
    try {
        $output = & $LuaBin $f.Name 2>&1
        $ok = $LASTEXITCODE -eq 0
    } finally {
        Pop-Location
    }

    $rel = $f.FullName.Replace("$PSScriptRoot\", "")

    if ($ok) {
        Write-Host "PASS  $rel"
        $pass++
    } else {
        Write-Host "FAIL  $rel"
        $output | ForEach-Object { Write-Host "      | $_" }
        $fail++
    }
}

Write-Host "----------------------------------------"
Write-Host "passed: $pass, failed: $fail"

if ($fail -eq 0) { exit 0 } else { exit 1 }
