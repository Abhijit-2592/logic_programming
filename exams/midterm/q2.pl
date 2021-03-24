% block's world with weights
/*
    transform(State1,State2,Plan) :-
	Plan is a plan of actions to transform State1 into State2.
*/
block(a).
block(b).
block(c).
place(p).
place(q).
place(r).

weight(a, 2.2, green).
weight(b, 6.1, red).
weight(c, 8.2, blue).

% on(X,Y) -> where X is block and Y is block/place, means X is on Y
% intial states are: [on(a,b) ,on(b,p) ,on(c,r)]
% final states are: [on(a,b) ,on(b,c) ,on(c,r)]
% Actions is a list of [to_place(block,Y,Place)|to_block(block,Y,block)]
transform(State1,State2,Plan) :- 
    transform(State1,State2,[State1],Plan).
 
transform(State,State,Visited,[]).
transform(State1,State2,Visited,[Action|Actions]) :-
    choose_action(Action,State1, State2),
    update(Action,State1,State), 
    \+ member(State,Visited),
    transform(State,State2,[State|Visited],Actions).

% two possible actions: moving to a place and moving to a block
% move block from Y(either a block or place) to place
legal_action(to_place(Block,Y,Place),State) :- 
    on(Block,Y,State), % block must be on Y
    clear(Block,State), % block must be clear to move
    place(Place), % Place must be a place
    clear(Place,State). % 

% check if moving Block1 to Block2 from Y is a legal action
legal_action(to_block(Block1,Y,Block2),State) :- 
    on(Block1,Y,State), % Block 1 is on Y
    clear(Block1,State), % Block 1 is clear to move
    block(Block2), % Block2 is a block
    Block1 \== Block2, % block1 and block2 are not same
    % incorporating the weight and color constraints
    weight(Block1, Weight1, Color1),
    weight(Block2, Weight2, Color2),
    % block 1 is going  on  top of block2
    % Thus  weight of block1 must not exceed the weight of  block1 by 3
    (Weight1>Weight2 -> WeightDiff is Weight1 - Weight2, WeightDiff < 3; true),
    Color1 \= Color2,
    clear(Block2,State). % Block2 is clear

% True if nothing is on top of A 
clear(X,State) :- \+ member(on(A,X),State).
% True if X is on Y
on(X,Y,State) :- member(on(X,Y),State).
 
update(to_block(X,Y,Z),State,State1) :-
    substitute(on(X,Y),on(X,Z),State,State1).
update(to_place(X,Y,Z),State,State1) :-
    substitute(on(X,Y),on(X,Z),State,State1).


% substitute(X,Y,L1,L2), where L2 is the result of substituting Y for all occurrences of X in L1, e.g., substitute(a,x,[a,b,a,c],[x,b,x,c])
% is true, whereas substitute (a, x, [a,b, a, cl , [a,b ,x, c] ) is false
substitute(X,Y,[X|Xs],[Y|Xs]).
substitute(X,Y,[X1|Xs],[X1|Ys]) :- X \== X1, substitute(X,Y,Xs,Ys).

choose_action(Action,State1,State2) :- 
    suggest(Action,State2), legal_action(Action,State1).

choose_action(Action,State1,State2) :- 
    legal_action(Action,State1).

suggest(to_place(X,Y,Z), State) :-
    member(on(X,Z),State), place(Z).

suggest(to_block(X,Y,Z), State) :- 
    member(on(X,Z),State), block(Z).
 