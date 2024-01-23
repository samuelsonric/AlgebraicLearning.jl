module AlgebraicLearning


# Distances
export Distance, Norm, lp

# Samples
export Sample

# Models
export Model, train!, test 

# Graphs
export touwd


using Catlab.CategoricalAlgebra.FreeDiagrams
using Catlab.Graphs.BasicGraphs
using Catlab.Programs.RelationalPrograms
using Catlab.WiringDiagrams.UndirectedWiringDiagrams
using Flux
using LinearAlgebra


using Catlab.CategoricalAlgebra.FreeDiagrams: AbstractFreeDiagram
using Flux: setup, train!
using Flux.Optimise: AbstractOptimiser


include("./distances.jl")
include("./samples.jl")
include("./models.jl")
include("./graphs.jl")


end
