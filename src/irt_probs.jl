"""
    logistic(x)

Computes the standard logistic function.
"""
logistic(x) = 1 / (1 + exp(-x))

"""
    prob(item, theta)

Compute the probability of a correct response for a given item and ability level (`theta`).
"""
prob(item::OnePLItem, theta::Real) = logistic(theta - item.b)

prob(item::TwoPLItem, theta::Real) = logistic(item.a * (theta - item.b))

prob(item::ThreePLItem, theta::Real) = item.c + (1 - item.c) * prob(TwoPLItem(item.a, item.b), theta)

# A fallback for any AbstractItem that doesn't have a specific `prob` method.
function prob(item::AbstractItem, theta::Real)
    error("prob() is not implemented for item type $(typeof(item)).")
end

