"""
    Distance

A measure of distance between two vectors.
"""
abstract type Distance end


"""
    Norm <: Distance

A norm on a vector space.
"""
abstract type Norm <: Distance end


"""
    lp{T} <: Norm

An ``\\ell^p`` norm.
"""
struct lp{T} <: Norm end


"""
    LinearAlgebra.norm(d::Norm, x::AbstractVector)

Compute the norm of a vector.
"""
LinearAlgebra.norm(d::Norm, x::AbstractVector)


function LinearAlgebra.norm(d::lp{T}, x::AbstractVector) where T
    norm(x, T)
end


"""
    distance(d:::Distance, x₁::AbstractVector, x₂::AbstractVector)

Compute the distance between two vectors.
"""
distance(d::Distance, x₁::AbstractVector, x₂::AbstractVector)


function distance(d::Norm, x₁::AbstractVector, x₂::AbstractVector)
    norm(d, x₁ - x₂)
end
