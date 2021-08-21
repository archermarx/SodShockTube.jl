using SodShockTube
using Documenter

DocMeta.setdocmeta!(SodShockTube, :DocTestSetup, :(using SodShockTube); recursive=true)

makedocs(;
    modules=[SodShockTube],
    authors="Thomas Marks <marksta@umich.edu> and contributors",
    repo="https://github.com/archermarx/SodShockTube.jl/blob/{commit}{path}#{line}",
    sitename="SodShockTube.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://archermarx.github.io/SodShockTube.jl",
        assets=String[],
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/archermarx/SodShockTube.jl")
