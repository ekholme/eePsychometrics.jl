module eePsychometrics

# dependencies
using Statistics
using Distributions
using Random

# include component files
include("simulate.jl")
include("ctt.jl")
include("types.jl")

# export funcs
export
    simulate_1pl,
    mean_scores,
    total_scores,
    item_difficulty_ctt,
    item_discrimination_ctt,
    AbstractPsychometricModel,
    AbstractIRTModel,
    AbstractItem,
    OnePLItem,
    TwoPLItem,
    ThreePLItem,
    ItemBank


end
