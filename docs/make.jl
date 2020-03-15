using Documenter, NKFtool

makedocs(
    modules=[NKFtool],
    sitename = "NKFtool.jl",
    authors = "Jutho Haegeman",
    pages = [
        "Home" => "index.md",
    ],
)

# deploydocs()
