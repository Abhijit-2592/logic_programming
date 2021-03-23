notEq(X,Y) :- 
    neg(X==Y).

neg(P) :- P, !, fail.
neg(_).

nonVar(Term):- var(Term), !, fail.
nonVar(Term):-
    neg(var(Term)).