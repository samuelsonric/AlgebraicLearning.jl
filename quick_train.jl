using AlgebraicLearning
using Flux
using MLDatasets: MNIST


chain = Chain(
    Dense(28*28, 128, relu),
    Dense(128, 64, relu),
    Dense(64, 10),
    softmax)

model = Model(chain, Adam(0.01))

Xtrain, ytrain = MNIST(split=:train)[:]
Xtest, ytest = MNIST(split=:test)[:]

X = Sample(lp{2}(), Flux.flatten(Xtrain), Flux.flatten(Xtest))
Y = Sample(lp{2}(), Flux.onehotbatch(ytrain, 0:9), Flux.onehotbatch(ytest, 0:9))

train!(model, X, Y, 1)
test(model, X, Y)
