# Public Documentation

```@docs
NKFtool.NKFtool
```

[Julia](https://julialang.org) package to guess and convert
encodings of Japanese characters.
This is a wrapper
to Network kanji filter, aka [nkf](https://osdn.net/projects/nkf/),
and provides the interface to use nkf command installed in your system from Julia.

NKFtool requires nkf to be installed in your system.
Major Unix-like operating systems offer its precompiled version
in their package management systems.

## NKF information

```@docs
NKFtool.nkf_version()
NKFtool.nkf_help()
```

## Guess an encoding

```@docs
NKFtool.nkf_guess(from::String)
NKFtool.nkf_guess(from::IO)
```
## Convert an encoding

```@docs
nkf_convert(from::String, options="-w m0")
nkf_convert(from::IO, options="-w -m0")
```
