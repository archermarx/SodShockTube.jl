using EulerShockTube
using Documenter

DocMeta.setdocmeta!(EulerShockTube, :DocTestSetup, :(using EulerShockTube); recursive=true)

makedocs(;
    modules=[EulerShockTube],
    authors="Thomas Marks <marksta@umich.edu> and contributors",
    repo="https://github.com/archermarx/EulerShockTube.jl/blob/{commit}{path}#{line}",
    sitename="EulerShockTube.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://archermarx.github.io/EulerShockTube.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/archermarx/EulerShockTube.jl",
)
