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


function touwd(graph::AbstractFreeDiagram{<:Any, Tuple{Ob, Hom}}, n::Integer) where {Ob, Hom}
    wd = UntypedRelationDiagram{Tuple{Ob, Ob, Vector{Hom}}, Hom}(ne(graph))

    for e in edges(graph)
        add_junction!(wd; variable=hom(graph, e))
        set_junction!(wd, (0, e), e)
    end

    for walk in findwalks(graph, n)
        name = (
            ob(graph, src(graph, first(walk))),
            ob(graph, tgt(graph, last(walk))),
            map(f -> hom(graph, f), walk))

        b = add_box!(wd, length(walk); name)

        for (p, e) in enumerate(walk)
            set_junction!(wd, (b, p), e)
        end
    end

    wd
end
