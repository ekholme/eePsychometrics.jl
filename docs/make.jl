using eePsychometrics
using Documenter

DocMeta.setdocmeta!(eePsychometrics, :DocTestSetup, :(using eePsychometrics); recursive=true)

makedocs(;
    modules=[eePsychometrics],
    authors="Eric Ekholm <eric.ekholm@gmail.com> and contributors",
    sitename="eePsychometrics.jl",
    format=Documenter.HTML(;
        canonical="https://ekholme.github.io/eePsychometrics.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ekholme/eePsychometrics.jl",
    devbranch="master",
)
