
field(mathematics).
field(science).
person(daniela).

studies_natural_world(X) :- 
    field(X),
    not studies_pure_ideas(X).

studies_pure_ideas(X) :- 
    field(X),
    not studies_natural_world(X).

studies_pure_ideas(X) :- 
    field(X), 
    X == mathematics,
    not ab_pure_ideas(X).   % maybe pure ideas

studies_natural_world(X) :-
    field(X),
    X == science,
    not ab_natural_world(X).    % maybe natural world

ab_pure_ideas(X) :- 
    X == science.

ab_natural_world(X) :- 
    X == mathematics.

studies(X,Y) :- 
    person(X), field(Y).

studies_our_place_in_the_world(P) :- 
    studies(P,mathematics),
    studies(P,science),
    person(P).