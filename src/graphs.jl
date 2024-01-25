function findwalks(graph::AbstractGraph, n::Integer, v::Integer)
    walks = Vector{Int}[]

    if n > 0
        for e in outedges(graph, v)
            push!(walks, [e])
    
            for walk in findwalks(graph, n - 1, tgt(graph, e))
                push!(walks, [e; walk])
            end
        end
    end

    walks
end


function findwalks(graph::AbstractGraph, n::Integer)
    walks = Vector{Int}[]

    for v in vertices(graph)
        append!(walks, findwalks(graph, n, v))
    end

    walks
end


function getcombinations(set::AbstractVector{T}) where T
    n = length(set)
    combinations = Vector{Tuple{T, T}}(undef, n * (n - 1) ÷ 2)

    for i₁ in 2:n
        x₁ = set[i₁]

        for i₂ in 1:i₁ - 1
            x₂ = set[i₂]
            combinations[(i₁ - 1) * (i₁ - 2) ÷ 2 + i₂] = (x₁, x₂)
        end
    end

    combinations
end


function touwd(graph::AbstractFreeDiagram{<:Any, Tuple{Ob, Hom}}, n::Integer) where {Ob, Hom}
    diagram = UntypedRelationDiagram{Tuple{Ob, Ob, Vector{Hom}, Vector{Hom}}, Hom}(ne(graph))

    for e in edges(graph)
        add_junction!(diagram; variable=hom(graph, e))
        set_junction!(diagram, (0, e), e)
    end

    walks = Dict{Tuple{Int, Int}, Vector{Vector{Int}}}()

    for w in findwalks(graph, n)
        v₁ = src(graph, first(w))
        v₂ = tgt(graph, last(w))

        push!(get!(walks, (v₁, v₂), []), w)
    end

    for ((v₁, v₂), w) in walks
        for (w₁, w₂) in getcombinations(w)
            m₁ = length(w₁)
            m₂ = length(w₂)

            name = (
                ob(graph, v₁),
                ob(graph, v₂),
                map(e -> hom(graph, e), w₁),
                map(e -> hom(graph, e), w₂))
            
            box = add_box!(diagram, m₁ + m₂; name)

            for i₁ in 1:m₁
                port = i₁
                set_junction!(diagram, (box, port), w₁[i₁])
            end

            for i₂ in 1:m₂
                port = m₁ + i₂
                set_junction!(diagram, (box, port), w₂[i₂])
            end
        end
    end

    diagram
end
