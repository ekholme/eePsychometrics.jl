using eePsychometrics
using Test
using Random

include("helpers.jl")

@testset "eePsychometrics.jl" begin
    include("test_ctt.jl")
    include("test_irt_core.jl")
end
