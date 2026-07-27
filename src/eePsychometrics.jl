module eePsychometrics

# dependencies
using Statistics
using Distributions
using Random

# include component files
include("reliability.jl")
include("simulate.jl")
include("ctt.jl")
include("types.jl")

# export funcs
export simulate_1pl,
    mean_scores,
    total_scores,
    AbstractPsychometricModel,
    AbstractIRTModel,
    AbstractItem,
    OnePLItem,
    TwoPLItem,
    ThreePLItem,
    ItemBank


end
