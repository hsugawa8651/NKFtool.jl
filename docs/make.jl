using Documenter
using NKFtool

makedocs(
    sitename = "NKFtool.jl",
    authors = "Hiroharu Sugawara <hsugawa@gmail.com>",
    format = Documenter.HTML(lang="ja"),
    modules = [NKFtool],
    pages = [
        "Home" => "index.md",
        "Manual" => Any[
            "Guide"=>"man/guide.md",
            "手引き"=>"man/guideja.md",],
        "Library" => Any["Public"=>"lib/public.md",],
    ],
    repo="https://github.com/hsugawa8651/NKFtool.jl/blob/{commit}{path}#L{line}",
    #assets=String[],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(;
    repo="github.com/hsugawa8651/NKFtool.jl",
)
