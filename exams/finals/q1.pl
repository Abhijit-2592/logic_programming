:- use_module(library(clpfd)).

graphcolor(Nodes, Edges, NodeColors) :- 
    generate_node_colors(Nodes, Colors, NodeColors), 
    Colors ins 10..13, % create all domains
    color_different(Edges, NodeColors),
    labeling([ff], Colors).

generate_node_colors([],[],[]).
generate_node_colors([N|Nodes], [C|Colors], [(N, C)|NodeColors]) :-
    generate_node_colors(Nodes, Colors, NodeColors).

color_different([], _).
color_different([(N1, N2)|Edges], Colors) :-
    member((N1, C1), Colors),
    member((N2, C2), Colors),
    C1 #\= C2,
    color_different(Edges, Colors).


