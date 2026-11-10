# Windows equivalent of tool/gen_api.sh.
# Regenerates the Dart API client (packages/hrms_api) from ..\api\openapi\openapi.yaml.
# Requires Node (npx) and Java 11+. If the java on PATH is older, set JAVA_HOME first, e.g.
#   $env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
# Native tools (dart.bat) write warnings to stderr, so rely on $LASTEXITCODE rather than ErrorActionPreference=Stop.
$ErrorActionPreference = 'Continue'
Set-Location (Join-Path $PSScriptRoot '..')

if ($env:JAVA_HOME) { $env:PATH = "$env:JAVA_HOME\bin;$env:PATH" }

$spec = '../api/openapi/openapi.yaml'
$out = 'packages/hrms_api'

foreach ($dir in "$out/lib", "$out/doc") { if (Test-Path $dir) { Remove-Item -Recurse -Force $dir } }

npx --yes @openapitools/openapi-generator-cli@2.42.0 generate `
  -i $spec `
  -g dart-dio `
  -o $out `
  -c tool/openapi-generator-config.yaml
if ($LASTEXITCODE -ne 0) { throw 'openapi-generator failed' }

# Post-process the generated pubspec: current json_serializable emits Dart >= 3.8 syntax
# (null-aware elements) and the generator writes a placeholder homepage.
$pubspec = Join-Path $out 'pubspec.yaml'
$content = (Get-Content $pubspec -Raw) -replace "sdk: '>=[0-9.]+ <4.0.0'", "sdk: '>=3.8.0 <4.0.0'" -replace "(?m)^homepage: homepage\r?\n", ''
[System.IO.File]::WriteAllText((Resolve-Path $pubspec), $content, (New-Object System.Text.UTF8Encoding $false))

# Use the Dart SDK bundled with Flutter directly (flutter's dart.bat wrapper needs git on PATH).
$dart = Join-Path (Split-Path (Get-Command flutter).Source) 'cache\dart-sdk\bin\dart.exe'
if (-not (Test-Path $dart)) { $dart = 'dart' }

Push-Location $out
try {
  & $dart pub get; if ($LASTEXITCODE -ne 0) { throw 'dart pub get failed' }
  & $dart run build_runner build; if ($LASTEXITCODE -ne 0) { throw 'build_runner failed' }
  & $dart format lib | Out-Null
} finally { Pop-Location }

flutter pub get
Write-Host "API client regenerated in $out"
