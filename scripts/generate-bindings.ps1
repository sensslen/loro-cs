<#
.SYNOPSIS
Generates the C# bindings into LoroCs/LoroCs/Generated from a built loro native library.

.PARAMETER Library
Path to a built loro native library. When omitted, the script builds the library for the
host with Cargo and uses that. The bindings do not depend on the platform the library was
built for.
#>
param(
    [string] $Library
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

# Renovate updates this pin. The part after '+' must match the uniffi version loro-ffi uses.
$BindgenTag = 'v0.11.1+v0.31.0'
$BindgenRepository = 'https://github.com/NordSecurity/uniffi-bindgen-cs'

$root = Split-Path -Parent $PSScriptRoot
$crateDir = Join-Path $root 'loro-cs'
$outDir = Join-Path $root 'LoroCs/LoroCs/Generated'

$installed = $null
if (Get-Command uniffi-bindgen-cs -ErrorAction SilentlyContinue) {
    $installed = (uniffi-bindgen-cs --version) -replace '^uniffi-bindgen ', 'v'
}
if ($installed -ne $BindgenTag) {
    Write-Host "Installing uniffi-bindgen-cs $BindgenTag (found: $installed)"
    # --locked builds the tag's own dependency set, so unrelated crate releases cannot break it.
    cargo +stable install --locked --git $BindgenRepository --tag $BindgenTag
}

if (-not $Library) {
    cargo build --release --locked --manifest-path (Join-Path $crateDir 'Cargo.toml')
    $Library = Get-ChildItem (Join-Path $crateDir 'target/release') -File |
        Where-Object Name -In 'loro.dll', 'libloro.so', 'libloro.dylib' |
        Select-Object -First 1 -ExpandProperty FullName
    if (-not $Library) { throw 'Cargo did not produce a loro native library.' }
}
$Library = (Resolve-Path $Library).Path

# The generator reads crate configuration through cargo metadata, so it runs from the crate.
Push-Location $crateDir
try {
    uniffi-bindgen-cs --library $Library -c uniffi.toml --no-format -o $outDir
}
finally {
    Pop-Location
}
