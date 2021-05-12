no_edge_in(Nodes,Edges,N):-
    select(N,Nodes,_),
    -member([_,N],Edges).

member(X,[X|_]).
member(X,[_|Tail]):- member(X,Tail).
% CWA
-member(X,L) :- not member(X,L).

select(X,[X|Xs],Xs).
select(X,[Y|Ys],[Y|Zs]):- select(X,Ys,Zs).

?- no_edge_in([1,2,3,4,5,6],[[1,2],[1,3],[2,4],[2,5],[3,4],[3,5]], N).
?- no_edge_in([1, 2, 3], [[1,2],[1,3]], N).