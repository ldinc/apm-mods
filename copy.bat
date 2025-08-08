@echo off

set branch=stable

set target=%1


if %target%==unstable (
  set target=%2
  set branch=unstable
)

set mod=%target%

set mp=.factorio.%branch%

for /f "tokens=* delims=" %%# in ('jq -r %mp% build.config.json') do @(set target=%%#)

goft.exe -b -o %target%mods %mod%
