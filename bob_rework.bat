call build.bat bob_rework
for /f "tokens=* delims=" %%# in ('jq -r ".version" apm_bob_rework/info.json') do @(set version=%%#)
call move.bat bob_rework %version%
