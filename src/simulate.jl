"""
    simulate_1pl(N::Int, M::Int; seed::Union{Nothing, Int}=nothing)

Generates a binary matrix of N respondents by M items based on a 1PL IRT model.
Returns an N x M matrix of 1s and 0s
"""
function simulate_1pl(N::Int, M::Int; seed::Union{Nothing,Int}=nothing)
    if !isnothing(seed)
        Random.seed!(seed)
    end

    θ = rand(Normal(0, 1), N)
    b = rand(Normal(0, 1), M)

    resp = Matrix{Int}(undef, N, M)

    for i ∈ 1:N
        for j ∈ 1:M
            # probability of a correct answer
            p = 1 / (1 + exp(-(θ[i] - b[j])))
            resp[i, j] = rand() < p ? 1 : 0
        end
    end

    return resp
end