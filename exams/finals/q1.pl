:- use_module(library(clpfd)).

% modified append to return a list when empty list is given
append([],L,[L]).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).

graphcolor(Nodes, Edges, NodeColorsOutput) :- 
    generate_node_colors(Nodes, Colors, NodeColors), 
    Colors ins 10..13, % create all domains
    color_different(Edges, NodeColors),
    labeling([ff], Colors),
    map_index2color(NodeColors, [], NodeColorsOutput).

    
% Generate all possible node colorings
generate_node_colors([],[],[]).
generate_node_colors([N|Nodes], [C|Colors], [(N, C)|NodeColors]) :-
    generate_node_colors(Nodes, Colors, NodeColors).

% Test if adjacent colors are different
color_different([], _).
color_different([(N1, N2)|Edges], Colors) :-
    member((N1, C1), Colors),
    member((N2, C2), Colors),
    C1 #\= C2,
    color_different(Edges, Colors).

map_index2color([], Acc, Output) :- Output = Acc.
map_index2color([(N, C)|NodeColors], Acc, Output):-
    (
        C == 10 -> append(Acc, (N, 'r'), Output1);
        C == 11 -> append(Acc, (N, 'g'), Output1);
        C == 12 -> append(Acc, (N, 'b'), Output1);
        append(Acc, (N, 'y'), Output1)
    ),
    map_index2color(NodeColors, Output1, Output).

    


