# loro-cs [![NuGet](https://img.shields.io/nuget/v/loro-cs.svg)](https://www.nuget.org/packages/loro-cs)

C# bindings for the [loro](https://github.com/loro-dev/loro) CRDT library.

> **Note:** The current bindings are very bare bones. We are happy to accept pull requests that help make the loro API more accessible and idiomatic for C# developers!

## Overview
This project provides .NET (C#) bindings for the loro CRDT library, enabling cross-platform, high-performance collaborative data structures in .NET applications. It uses Rust for the core implementation and exposes a C#-friendly API via native interop.

## Features
- Cross-platform: Supports Windows, Linux, and macOS (x64, x86, arm64)
- Modern .NET API for collaborative data structures
- Native performance via Rust FFI
- Distributed, real-time collaboration support

## Getting Started

### Prerequisites
- Platform support: Windows, Linux, or macOS (x64, x86, arm64)

### Installation
The NuGet package includes the managed C# library and native binaries for all major platforms/architectures. Install via NuGet:

```
dotnet add package LoroCs
```

### Usage Example
```csharp
using LoroCs;
using LoroCs.Extensions;

// Example usage (API subject to change)
var doc = new LoroDoc();
doc.GetMap("root".ToLoroContainerIdLike());
```

## Building from Source

### Rust Native Library
The native library is built using Rust and UniFFI. To build native artifacts and copy them for the C# project:

#### Windows (PowerShell/x64)
```powershell
pushd .\loro-cs
cargo build --release
Copy-Item .\target\release\loro_cs.dll ..\LoroCs\LoroCs\..\..\artifacts\loro_cs-win-x64\loro_cs.dll -Force
```

#### Linux (bash/x64)
```bash
pushd ./loro-cs
cargo build --release
mkdir -p ../../artifacts/loro_cs-linux-x64-ubuntu-latest
cp ./target/release/loro_cs.so ../../artifacts/loro_cs-linux-x64/loro_cs.so
```

#### macOS (bash/arm64)
```bash
pushd ./loro-cs
cargo build --release
mkdir -p ../../artifacts/loro_cs-osx-arm64-macos-latest
cp ./target/release/loro_cs.dylib ../../artifacts/loro_cs-osx-arm64/loro_cs.dylib
```

### C# Project
Build the C# project and pack the NuGet package:

```
dotnet build
# or to create a NuGet package:
dotnet pack
```

### Cross-Platform Builds
Cross-platform native builds and NuGet packaging are automated via GitHub Actions. See `.github/workflows/release.yml` for details.

## Contributing
Contributions are welcome! Please open issues or pull requests.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
