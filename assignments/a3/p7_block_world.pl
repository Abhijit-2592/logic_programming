block(a). 
block(b). 
block(c). 
block(d). 
block(e).
place(p). 
place(q). 
place(r). 

transform(State1,State2,Plan) :- 
    transform(State1,State2,[State1],Plan).

transform(State1,State2,Visited,[]) :- 
    permute(State1,State2).

transform(State1,State2,Visited,[Action|Actions]) :- 
    chooseAction(Action,State1,State2),
    update(Action,State1,State),
    \+ member(State,Visited),
    transform(State,State2,[State|Visited],Actions).

chooseAction(Action,State1,State2) :- 
    suggest(Action,State2), legalAction(Action,State1).

chooseAction(Action,State1,State2) :- 
    legalAction(Action,State1).

suggest(toPlace(X,Y,Z), State) :-
    member(on(X,Z),State), place(Z).

suggest(toBlock(X,Y,Z), State) :- 
    member(on(X,Z),State), block(Z).

legalAction(toPlace(Block,Y,Place),State) :- 
    member(on(Block,Y),State),
    clear(Block,State),
    place(Place), clear(Place,State).

legalAction(toBlock(Block1,Y,Block2),State) :- 
    member(on(Block1,Y), State), 
    clear(Block1,State),
    block(Block2), Block1 \= Block2,
    clear(Block2,State).

clear(X,State) :- \+ member(on(A,X),State).

on(X,Y,State) :- member(on(X,Y), State).

update(toBlock(X,Y,Z), State, State1) :- 
    substitute(on(X,Y),on(X,Z),State,State1).

update(toPlace(X,Y,Z), State, State1) :- 
    substitute(on(X,Y),on(X,Z),State,State1).


substitute(Old,New,Old,New).

substitute(Old,_,Term,Term) :- 
    constant(Term), Term \== Old.

substitute(Old,New,Term,Term1) :- 
    compound(Term), functor(Term,F,N), 
    functor(Term1,F,N), substitute(N,Old,New,Term,Term1).

substitute(N,Old,New,Term,Term1) :-
    N > 0, arg(N,Term,Arg), 
    substitute(Old,New,Arg,Arg1),
    arg(N,Term1,Arg1), N1 is N-1, 
    substitute(N1,Old,New,Term,Term1).

substitute(0,_,_,_,_).

constant(X) :- atomic(X).

% permute(P,R): R is a permutation of list P.
permute([],[]).
permute(P,[R|Rs]) :-
    select(R,P,T), permute(T,Rs).

% writes the List [H|T].
writeList([]) :- nl.
writeList([H|T]) :- write(H), write(' '), writeList(T).