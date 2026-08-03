"""
    cronbach_alpha(X::Matrix{Int})

Calculates Cronbach's alpha, a measure of internal consistency reliability.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items.

# Returns
- A `Float64` representing Cronbach's alpha for the test.

# Examples
```jldoctest
julia> X = [1 1 1 1; 1 1 0 1; 1 0 0 0; 0 0 0 0];

julia> cronbach_alpha(X)
0.86666666

```
"""
function cronbach_alpha(X::Matrix{Int})
    k = size(X, 2)
    v = Vector{Float64}(undef, k)

    for i ∈ 1:k
        v[i] = var(X[:, i])
    end

    Vᵢ = sum(v)
    Vₜ = var(total_scores(X))

    α = (k / (k-1)) * (1 - (Vᵢ / Vₜ))
    return α
end