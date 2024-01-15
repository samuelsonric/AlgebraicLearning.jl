struct Sample{T <: Distance}
    distance::T
    train::Matrix{Float32}
    test::Matrix{Float32}

    function Sample(d::T, train::AbstractMatrix, test::AbstractMatrix) where T <: Distance
        train = convert(Matrix{Float32}, train)
        test  = convert(Matrix{Float32}, test)

        new{T}(d, train, test)
    end
end
