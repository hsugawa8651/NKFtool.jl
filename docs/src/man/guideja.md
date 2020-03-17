
# 利用ガイド


## 概観

![NKF-outline](../NKFtool-outline.jpeg)


## インストール

### nkf

NKFtool を使うシステムには、nkf コマンドがインストール済でなければなりません。
Unix 類似のオペレーティングシステム（OS）の多くでは、
OS付属のパッケージマネージメントシステムからインストールできます。

MacOSX では、Homebrew を用いてインストールできます。

```
brew install nkf
```

### NKFtool

NKFtoolは、Julia 1.0 以上が必要です。

Julia のパッケージ・マネージメントシステムを用いて nkf をインストールするには、
`]` を打鍵しパッケージマネージメントを起動してから、以下を実行します。

```
    (v1.1) pkg> add NKFtool
```



## 文字列のエンコードを変換する

`nkf` コマンドは、日本語テキストのエンコードを推定できます。

文字列 `from` のエンコードを推定するには [`nkf_guess(from::String)`](@ref) を使います。

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

文字列 `from` のエンコードを変換するには [`nkf_convert(from::String, options="-w -m0")`](@ref) を使います。

２つ目の引数 `options` は `nkf` コマンドに渡され、変換方法を指定します。

引数 `options` の既定値は `-w -m0` (出力エンコード UTF-8, no MIME デコードなし) です。
これは、Julia の標準文字列のエンコード（UTF-8）を維持することを意味します。

```julia-repl
julia> nkf_convert(raw"こんにちわ")
"こんにちわ"

julia> nkf_convert(raw"こんにちわ", "-w -m0")
"こんにちわ"
```

エンコードを変換するには、出力エンコーディングのオプションを一つだけ指定します。
すなわち、`-j` (ISO-2022-JP), `-s` (Shift\_JIS),
`-e` (EUC-JP), または `-w` (UTF-8) のどれかです。

入力文字列のエンコードが分かっている場合には、
入力エンコーディングのオプションを一つだけ指定してもよいです。
すなわち、 `-J`, `-S`, `-E`, または `-W` のどれかです。

Julia では、UTF-8 以外でエンコードされた文字列は印字可能ではありません。
これらを印字可能な文字列に変換するのが便利でしょう。
例えば、以下のように `Base64.base64encode()` を使います。

```julia-repl
julia> using Base64

julia> nkf_convert( raw"こんにちわ", "-j") |> base64encode
"GyRCJDMkcyRLJEEkbxsoQg=="

julia> String(base64decode(ans)) |> nkf_convert
"こんにちわ"
```

## テキストストリームを変換する

`nkf_guess` は、第１引数としてテキストの入力ストリームも受け取ります。

`nkf_convert` も、第１引数としてテキストの入力ストリームを受け取ります。
この場合の返り値は、テキストの出力ストリームです。

例えば、テキストファイルのエンコードを推定するには、
以下のように、
[`nkf_guess(from::IO)`](@ref)
を使います。


```julia-repl
julia> open("hello_sjis.txt","w") do f
           print(f, nkf_convert(raw"こんにちわ", "-s"))
       end
       #
       encoding=open("hello_sjis.txt") do f
           nkf_guess(f)
       end
"Shift_JIS"
```




Shift\_JIS エンコーディングされたテキストファイルを UTF-8 に変換して、Julia の文字列として読み込むには、
以下のように、 [`nkf_convert(from::IO, options="-w -m0")`](@ref)
 を使います。


```julia-repl
julia> hello_utf=open("hello_sjis.txt") do f
           nkf_convert(f, "-w -m0")
       end
"こんにちわ"
```
