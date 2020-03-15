using Documenter
using NKFtool

makedocs(
    sitename = "NKFtool.jl",
    author = "Hiroharu Sugawara",
    format = Documenter.HTML(lang="ja"),
    modules = [NKFtool],
    pages = [
        "Home" => "index.md",
        "Manual" => Any[
            "Guide"=>"man/guide.md",
            "手引き"=>"man/guideja.md",],
        "Library" => Any["Public"=>"lib/public.md",],
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
