no_edge_in(Nodes,Edges,N):-
    select(N,Nodes,_),
    \+ member((_,N),Edges).