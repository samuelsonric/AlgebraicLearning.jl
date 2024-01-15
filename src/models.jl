struct Model{T₁ <: Chain, T₂ <: AbstractOptimiser}
    chain::T₁
    optimiser::T₂
end


function Flux.train!(model::Model, X::Sample, Y::Sample, n::Integer)
    m = size(X.train, 2)
    data = Vector{Tuple{Vector{Float32}, Vector{Float32}}}(undef, m)

    for i in 1:m
        data[i] = (X.train[:, i], Y.train[:, i])
    end

    state = setup(model.optimiser, model.chain)
    
    for _ in 1:n
        train!(model.chain, data, state) do chain, x, y
            distance(Y.distance, chain(x), y)
        end
    end
end


function test(model::Model, X::Sample, Y::Sample)
    n = size(X.test, 2)
    init = 0.0

    foldl(1:n; init) do α, i
        x = X.test[:, i]
        y = Y.test[:, i]
        
        (α * (i - 1) + distance(Y.distance, model.chain(x), y)) / i
    end
end
