"""
    NKFtool

[Julia](https://julialang.org) package to guess and convert
encodings of Japanese characters.
This is a wrapper
to Network kanji filter, aka [nkf](https://osdn.net/projects/nkf/),
and provides the interface to use nkf command installed in your system from Julia.

NKFtool requires nkf to be installed in your system.
Major Unix-like operating systems offer its precompiled version
in their package management systems.
"""
module NKFtool

export nkf_version, nkf_help, nkf_guess, nkf_convert

function __init__()

    try
        success(`nkf -v`)
    catch
        error("NKFtool cannot be loaded: nkf is not available on this system.")
    end

    global NKF_VERSION = begin
        output = IOBuffer()
        run(pipeline(`nkf --version`, stdout = output))
        String(take!(output))
        # close(output)
    end

    global NKF_HELP = begin
        output = IOBuffer()
        run(pipeline(`nkf --help`, stdout = output))
        String(take!(output))
        # close(output)
    end
end

"""
    nkf_version()

Print the version message of nkf command.
The same as the output of `nkf --version` command.

# Examples
```julia-repl
julia> nkf_version() |> print
Network Kanji Filter Version 2.1.5 (2018-12-15)
Copyright (C) 1987, FUJITSU LTD. (I.Ichikawa).
Copyright (C) 1996-2018, The nkf Project.
```
"""
function nkf_version()
    NKF_VERSION
end

"""
    nkf_help()

Print the help message of nkf command.
The same as the output of `nkf --help` command.

# Examples
```julia-repl
julia> nkf_help() |> print
```
"""
function nkf_help()
    NKF_HELP
end


"""
    nkf_guess(from::String)

Try to guess the encoding of the input text `from`, and
return a string representing its encoding,
which is just the result of the command line `echo <from> | nkf -g`.

# Examples
```julia-repl
julia> nkf_guess(raw"こんにちわ")
"UTF-8"

julia> nkf_convert( raw"こんにちわ", "-j") |> nkf_guess
"ISO-2022-JP"

julia> nkf_convert( raw"こんにちわ", "-e") |> nkf_guess
"EUC-JP"

julia> nkf_convert( raw"こんにちわ", "-s") |> nkf_guess
"Shift_JIS"
```
"""
function nkf_guess(from::String)
    nkf_guess(IOBuffer(from))
end


"""
    nkf_guess(from::IO)

Try to guess the encoding of the input stream `from`, and
return a string representing its encoding.

# Examples
```julia-repl
julia> nkf_guess(IOBuffer(raw"こんにちわ"))
"UTF-8"

julia> open("hello_sjis.txt","w") do f
           print(f, nkf_convert(raw"こんにちわ", "-s"))
       end
       #
       encoding=open("hello_sjis.txt") do f
           nkf_guess(f)
       end
"Shift_JIS"
```
"""
function nkf_guess(from::IO)
    output = Pipe()
    p=Base.open(pipeline(ignorestatus(`nkf -g`), stdin = from, stdout = output))
    close(output.in)
    chomp(readlines(output))
end


"""
    nkf_convert(from::String, options="-w -m0")

Convert the input string `from` to the encoding
specified by the option directive `options`,
and return the output text stream,
which is just the result of the command line `echo <from> | nkf <options>`.


# Arguments
- `from::String`: the input string
- `options::String`: the option directive to be passed to nkf command.

    * Output encoding
        * `-j` : ISO-2022-JP
        * `-s` : Shift_JIS
        * `-e` : EUC-JP
        * `-w[8[0],{16,32}[{B,L}[0]]]` : UTF with options
    * Input encoding
        * `-J` : ISO-2022-JP
        * `-S` : Shift_JIS
        * `-E` : EUC-JP
        * `-W[8,[16,32][B,L]]` : UTF with option
    * MIME decode : `-m[BQSN0]`
        * B:base64
        * Q:quoted
        * S:strict
        * N:nonstrict
        * 0:no decode
    * MIME encode : `-M[BQ]`
        * B:base64
        * Q:quoted


# Examples
```julia-repl
julia> nkf_convert(raw"こんにちわ", "-w -m0")
"こんにちわ"

julia> using Base64

julia> nkf_convert( raw"こんにちわ", "-j") |> base64encode
"GyRCJDMkcyRLJEEkbxsoQg=="

julia> String(base64decode(ans)) |> nkf_convert
"こんにちわ"
```
"""
function nkf_convert(from::String, options="-w m0")
    nkf_convert(IOBuffer(from), options)
end


"""
    nkf_convert(from::IO, options="-w -m0")

Convert the input stream `from` to the encoding
specified by the option directive `options`,
and return the output text stream,
which is just the result of the command line `cat <from> | nkf <options>`

# Arguments
- `text::String`: the input string
- `options::String`: the directibr to be passed to nkf command. See [`nkf_convert(from::String, options="-w -m0")`](@ref)

# Examples
```julia-repl
julia> open("hello_sjis.txt","w") do f
           print(f, nkf_convert(raw"こんにちわ", "-s"))
       end
       #
       hello_utf=open("hello_sjis.txt") do f
           nkf_convert(f, "-w -m0")
       end
"こんにちわ"
```
"""
function nkf_convert(from::IO, options="-w -m0")
    output = Pipe()
    p=Base.open(pipeline(ignorestatus(`nkf $options`), stdin = from, stdout = output))
    close(output.in)
    readlines(output)
end


end # module
