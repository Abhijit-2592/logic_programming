:- use_module(library(clpfd)).

% modified append to return a list when empty list is given
append([],L,[L]).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).

select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]):- select(X,Ys,Zs).

find_adj_given_node_edges(Edges,Node,AdjList):-
    find_adj_given_node_edges(Node, Edges, 0, [], AdjList).

find_adj_given_node_edges(Node, Edges, CurrIndex, CurrList,AdjList)  :- 
    length(Edges, MyLength),
    MyLength \= CurrIndex, % terminal condition
    nth0(CurrIndex, Edges, (N1, N2)),
    (N1 == Node -> append(CurrList,  N2, CurrList2); CurrList2=CurrList),
    CurrIndex2 is CurrIndex + 1,
    find_adj_given_node_edges(Node, Edges, CurrIndex2, CurrList2, AdjList).
%terminal case
find_adj_given_node_edges(Node, Edges, CurrIndex, CurrList, CurrList).

find_adj(Nodes, Edges, NodeEdgeList):-
    maplist(find_adj_given_node_edges(Edges), Nodes, NodeEdgeList).
    