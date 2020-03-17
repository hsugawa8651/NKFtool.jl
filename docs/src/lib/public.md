# Public Documentation

```@docs
NKFtool.NKFtool
```

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
