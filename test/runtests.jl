using NKFtool
using Test

@testset "NKFtool.jl" begin

    @testset "Installation" begin
        @test !isempty(nkf_version())
        @test !isempty(nkf_help())
    end

    text_iso2022jp=raw"ＩＳＯー２０２２ーJ Ｐコード"
    code_iso2022jp=raw"GyRCI0kjUyNPITwjMiMwIzIjMiE8GyhCSiAbJEIjUCUzITwlSRsoQg=="
    #
    text_sjis=raw"シフトJ I S コード"
    code_sjis=raw"g1aDdINnSiBJIFMgg1KBW4No"
    #
    text_eucjp=raw"ＥＵＣーＪＰコード"
    code_eucjp=raw"o8Wj1aPDobyjyqPQpbOhvKXJ"
    #
    text_utf8=raw"ＵＴＦー８コード"
    code_utf8=raw"77y177y077ym44O877yY44Kz44O844OJ"

    using Base64
    @testset "Guess" begin
        @test nkf_guess(String(base64decode(code_iso2022jp))) == "ISO-2022-JP"
        @test nkf_guess(String(base64decode(code_sjis))) == "Shift_JIS"
        @test nkf_guess(String(base64decode(code_eucjp))) == "EUC-JP"
        @test nkf_guess(String(base64decode(code_utf8))) == "UTF-8"
    end

    @testset "Convert to UTF-8" begin
        @test nkf_convert(String(base64decode(code_iso2022jp)),"-w -m0") == text_iso2022jp
        @test nkf_convert(String(base64decode(code_sjis)),"-w -m0") == text_sjis
        @test nkf_convert(String(base64decode(code_eucjp)),"-w -m0") == text_eucjp
        @test nkf_convert(String(base64decode(code_utf8)),"-w -m0") == text_utf8
    end

    @testset "Convert from UTF-8" begin
        @test base64encode(nkf_convert(text_iso2022jp,"-j m0")) == code_iso2022jp
        @test base64encode(nkf_convert(text_sjis,"-s -m0")) == code_sjis
        @test base64encode(nkf_convert(text_eucjp,"-e -m0")) == code_eucjp
        @test base64encode(nkf_convert(text_utf8,"-w -m0")) == code_utf8
    end

end
