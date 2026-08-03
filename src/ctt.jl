"""
    total_scores(X::Matrix{Int})

Calculates the total score for each respondent from a matrix of item responses.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items. Responses are typically 0 for incorrect and 1 for correct.

# Returns
- A `N x 1` matrix containing the total score for each respondent.

# Examples
```jldoctest
julia> X = [1 0 1; 0 1 1; 1 1 1];

julia> total_scores(X)
3×1 Matrix{Int64}:
 2
 2
 3
```
"""
function total_scores(X::Matrix{Int})
    return sum(X, dims=2)
end

"""
    mean_scores(X::Matrix{Int})

Calculates the mean score for each respondent from a matrix of item responses.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items.

# Returns
- A `N x 1` matrix containing the mean score for each respondent.
"""
function mean_scores(X::Matrix{Int})
    return mean(X, dims=2)
end

"""
    item_difficulty_ctt(X::Matrix{Int})

Calculates the CTT item difficulty (p-value) for each item from a matrix of item responses.
Item difficulty is defined as the proportion of respondents who answered the item correctly.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items.

# Returns
- A `1 x M` matrix containing the difficulty for each item.

# Examples
```jldoctest
julia> X = [1 0 1; 0 1 1; 1 1 0];

julia> item_difficulty_ctt(X)
1×3 Matrix{Float64}:
 0.666667  0.666667  0.333333
```
"""
function item_difficulty_ctt(X::Matrix{Int})
    return mean(X, dims=1)
end

"""
    item_difficulty_ctt(x::Vector{Int})

Calculates the CTT item difficulty (p-value) for a single item's response vector.

# Arguments
- `x::Vector{Int}`: A vector of item responses for a single item.

# Returns
- A `Float64` representing the item difficulty.
"""
function item_difficulty_ctt(x::Vector{Int})
    return mean(x)
end

"""
    item_discrimination_ctt(X::Matrix{Int})

Calculates the CTT item discrimination (point-biserial correlation) for each item.

This is the correlation between the score on a given item and the total score on the rest of the items.

# Arguments
- `X::Matrix{Int}`: An `N x M` matrix of item responses, where `N` is the number of respondents and `M` is the number of items.

# Returns
- A `Vector{Float64}` of length `M` containing the discrimination index for each item.
"""
function item_discrimination_ctt(X::Matrix{Int})
    M = size(X, 2)

    v = Vector{Float64}(undef, M)

    for j ∈ 1:M
        notj = setdiff(1:M, j)

        x = X[:, j]
        xind = findall(x .== 1)
        notx = findall(x .== 0)

        (isempty(xind) || isempty(notx)) && (v[j]=NaN; continue)

        total_scores_rest = total_scores(X[:, notj])
        X̄_1 = mean(total_scores_rest[xind])
        X̄_0 = mean(total_scores_rest[notx])

        p = mean(x)
        S = std(total_scores_rest)

        r = ((X̄_1 - X̄_0) / S) * √(p * (1 - p))

        v[j] = r
    end
    return v
end
