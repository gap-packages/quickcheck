# RandomDigraph cannot take a random source, so we build the edges from rg
QC_RegisterFilterGen(IsDigraph, function(rg, limit)
    local n, p;
    n := Random(rg, [1..limit]);
    p := Random(rg, [0..100]);
    return Digraph(List([1..n], i -> Filtered([1..n], j -> Random(rg, [1..100]) <= p)));
end);
