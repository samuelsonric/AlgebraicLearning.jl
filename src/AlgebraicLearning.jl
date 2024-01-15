module AlgebraicLearning


# Distances
export Distance, Norm, lp

# Samples
export Sample

# Models
export Model, train!, test 


using Flux
using LinearAlgebra


using Flux: setup, train!
using Flux.Optimise: AbstractOptimiser


include("./distances.jl")
include("./samples.jl")
include("./models.jl")


end
