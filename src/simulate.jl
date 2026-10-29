using Distributions
using Random

"""
    simulate_1pl(n::Int, m::Int) -> BitMatrix

Generate an `n` x `m` matrix of binary responses from a 1PL (Rasch) model.

Samples θ from a Normal(0, 1) distribution and b from a Uniform(-2.5, 2.5) distribution.

# Arguments
- `n::Int`: Number of rows in the response matrix
- `m::Int`: Number of columns in the response matrix

# Returns
- `BitMatrix`: An `n` x `m` matrix where `1` indicates a correct response and `0` indicates an incorrect response.
"""
function simulate_1pl(n::Int, m::Int)
    θ = rand(Normal(0, 1), n)
    b = rand(Uniform(-2.5, 2.5), m)

    logits = θ .- b'
    p = 1.0 ./ (1.0 .+ exp.(-logits))

    M = p .>= rand(n, m)

    return M

end