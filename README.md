# loro-cs [![NuGet](https://img.shields.io/nuget/v/LoroCs.svg)](https://www.nuget.org/packages/LoroCs)

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

### Prerequisites
- Rust (stable) and the .NET SDK
- PowerShell 7 (`pwsh`), which also runs on Linux and macOS

### Bindings
Generate the C# bindings once, and again whenever `loro-ffi` changes:

```
pwsh scripts/generate-bindings.ps1
```

The script installs the pinned `uniffi-bindgen-cs`, builds the native library for your machine and writes `LoroCs/LoroCs/Generated/loro.cs`. The generated file is not committed.

### C# Project
`dotnet build LoroCs/LoroCs.slnx` compiles the library and also writes the NuGet package. The package contains every native library found under `artifacts/runtimes/<rid>/native/`. CI fills that folder for all platforms. To include your local build, copy it there, for example:

```powershell
New-Item -ItemType Directory -Force artifacts/runtimes/win-x64/native
Copy-Item loro-cs/target/release/loro.dll artifacts/runtimes/win-x64/native/
```

On Linux and macOS Cargo names the file `libloro.so` or `libloro.dylib`. Copy it without the `lib` prefix.

### Cross-Platform Builds
Cross-platform native builds and NuGet packaging are automated via GitHub Actions. See `.github/workflows/build_and_publish.yml` for details.

## Contributing
Contributions are welcome! Please open issues or pull requests.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
