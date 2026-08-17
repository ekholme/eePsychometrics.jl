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

"""
    kr20(X::Matrix{Int})

Calculates the Kuder-Richardson Formula 20 (KR-20), a measure of internal consistency
reliability for dichotomously scored items.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items. Responses must be binary (0 or 1).

# Returns
- A `Float64` representing the KR-20 reliability coefficient for the test.

# Examples
```jldoctest
julia> X = [1 1 0; 1 0 0; 0 1 1; 1 1 1];

julia> kr20(X)
0.21052631578947385
```
"""
function kr20(X::Matrix{Int})
    if !all(x -> x in (0, 1), X)
        throw(ArgumentError("Input matrix X for kr20 must contain only binary values (0 or 1)."))
    end

    k = size(X, 2)
    p = item_difficulty_ctt(X)
    q = 1 .- p
    V = var(total_scores(X))

    r = (k / (k - 1)) * (1 - (sum(p .* q) / V))

    return r
end