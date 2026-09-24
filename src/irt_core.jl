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

"""
    item_information(item, theta)

Compute the item information for a given item and ability level (`theta`).

The item information function (IIF) describes the precision with which an item
measures an individual's ability level. It is the reciprocal of the standard
error of measurement for that item at a given theta.

# Arguments
- `item`: An `AbstractItem` object (e.g., `OnePLItem`, `TwoPLItem`, `ThreePLItem`).
- `theta`: A `Real` number representing the ability level.

# Returns
A `Float64` representing the information provided by the item at the given `theta`.
"""
function item_information(item::OnePLItem, theta::Real)
    p = prob(item, theta)
    q = 1 - p
    return p * q
end

function item_information(item::TwoPLItem, theta::Real)
    p = prob(item, theta)
    q = 1 - p

    return item.a^2 * p * q
end

function item_information(item::ThreePLItem, theta::Real)
    p = prob(item, theta)
    q = 1 - p

    ret = (item.a^2 * (q / p)) * ((p - item.c) / (1 - item.c))^2
    return ret
end

# fallback for an AbstractItem that doesn't have an `item_information` method
function item_information(item::AbstractItem, theta::Real)
    error("item_information() is not implemented for item type $(typeof(item)).")
end


"""
    test_information(items, theta)

Compute the test information for a collection of items (a test) at a given ability level (`theta`).
"""
function test_information(items::Vector{<:AbstractItem}, theta::Real)
    return sum(item_information(item, theta) for item in items)
end

# Dispatch for ItemBank by forwarding its items vector
test_information(item_bank::ItemBank, theta::Real) = test_information(item_bank.items, theta)

"""
    expected_score(items, theta)

Compute the expected score for a collection of items (a test) at a given ability level (`theta`).
This is also known as the Test Characteristic Curve (TCC).
"""
function expected_score(items::Vector{<:AbstractItem}, theta::Real)
    return sum(prob(item, theta) for item in items)
end

# Dispatch for ItemBank by forwarding its items vector
expected_score(item_bank::ItemBank, theta::Real) = expected_score(item_bank.items, theta)