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
    not member(State,Visited),
    transform(State,State2,[State|Visited],Actions).

chooseAction(Action,State1,State2) :- 
    suggest(Action,State2), legalAction(Action,State1).

chooseAction(Action,State1,State2) :- 
    legalAction(Action,State1).

suggest(toPlace(X,Y,Z), State) :-
    member(on(X,Z),State), place(Z).

suggest(toBlock(X,Y,Z), State) :- 
    member(on(X,Z),State), block(Z).


member(X, [X| _]).
member(X, [Y| T]) :- X \= Y, member(X, T).

legalAction(toPlace(Block,Y,Place),State) :- 
    member(on(Block,Y),State),
    clear(Block,State),
    place(Place), clear(Place,State).

legalAction(toBlock(Block1,Y,Block2),State) :- 
    member(on(Block1,Y), State), 
    clear(Block1,State),
    block(Block2), Block1 \= Block2,
    clear(Block2,State).

clear(X,State) :- not member(on(A,X),State).

on(X,Y,State) :- member(on(X,Y), State).

update(toBlock(X,Y,Z), State, State1) :- 
    substitute(on(X,Y),on(X,Z),State,State1).

update(toPlace(X,Y,Z), State, State1) :- 
    substitute(on(X,Y),on(X,Z),State,State1).


substitute(_,_,[],[]). 

substitute(X,Y,[X|T1],[Y|T2]) :-
    substitute(X,Y,T1,T2).

substitute(X,Y,[Z|T1],[Z|T2]) :-
    Z \= X,
    substitute(X,Y,T1,T2).

permute([],[]).
permute(P,[R|Rs]) :-
    select(R,P,T), permute(T,Rs).

select(X,[X|T],T).
select(X,[H|T],[H|R]) :- %X \= H, 
    select(X,T,R).

writeList([]) :- nl.
writeList([H|T]) :- write(H), write(' '), writeList(T).

?- transform([on(b,a),on(a,p),on(c,q),on(e,d),on(d,r)],[on(e,d),on(d,p),on(b,q),on(a,c),on(c,r)],Plan).