"""
    AbstractPsychometricModel

An abstract type for all psychometric models.
"""
abstract type AbstractPsychometricModel end

"""
    AbstractIRTModel

An abstract type for Item Response Theory (IRT) models.
"""
abstract type AbstractIRTModel <: AbstractPsychometricModel end

"""
    AbstractItem

An abstract type for an item in an IRT model.
"""
abstract type AbstractItem <: AbstractIRTModel end

"""
    OnePLItem(b)

A 1-parameter logistic (1PL) IRT model, also known as a Rasch model.

# Fields
- `b::Real`: The item difficulty (or location) parameter.
"""
struct OnePLItem{T<:Real} <: AbstractItem
    b::T
end

OnePLItem(b::Real) = OnePLItem(Float64(b))

"""
    TwoPLItem(a, b)

A 2-parameter logistic (2PL) IRT model.

# Fields
- `a::Real`: The item discrimination (or slope) parameter.
- `b::Real`: The item difficulty (or location) parameter.
"""
struct TwoPLItem{T<:Real} <: AbstractItem
    a::T
    b::T
end

TwoPLItem(a::Real, b::Real) = TwoPLItem(Float64(a), Float64(b))

"""
    ThreePLItem(a, b, c)

A 3-parameter logistic (3PL) IRT model.

# Fields
- `a::Real`: The item discrimination (or slope) parameter.
- `b::Real`: The item difficulty (or location) parameter.
- `c::Real`: The guessing (or pseudo-chance) parameter.
"""
struct ThreePLItem{T<:Real} <: AbstractItem
    a::T
    b::T
    c::T
end

ThreePLItem(a::Real, b::Real, c::Real) = ThreePLItem(Float64(a), Float64(b), Float64(c))

"""
    ItemBank(items)

A collection of IRT items.

# Fields
- `items::Vector{<:AbstractItem}`: A vector containing items of different types (e.g., `OnePLItem`, `TwoPLItem`).
"""
struct ItemBank
    items::Vector{<:AbstractItem}
end