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
    m = size(X, 2)
    s = total_scores(X)
    return s ./ m
end