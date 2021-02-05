% Family datalog
% Mother and Father relation.
% Lisa is the mother of Sarah. You can also change the order. If you change, then you must query accordingly.
mother(lisa, sarah).
mother(lisa, abe).
mother(nancy, john).
mother(mary, jill).
mother(sarah,susan).
mother(susan, jack).
mother(susan, phil).

father(tony, sarah).
father(tony, abe).
father(abe, john).
father(john, jill).
father(bill, susan).
father(rob, jack).
father(rob, phil).
father(jack, jim).

% gender facts
male(tony).
male(abe).
male(john).
male(bill).
male(rob).
male(jack).
male(phil).
male(jim).

female(lisa).
female(sarah).
female(nancy).
female(mary).
female(jill).
female(sarah).
female(susan).

% parent relation
% parent if mother/ father
parent(X,Y) :- mother(X,Y) ; father(X,Y).

% child
child(X,Y) :- parent(Y,X).

% grandparent relation
% X is the grandparent of Y if X is the parent of Z and (, means and in prolog) Z is the parent of Y
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).
great_grandparent(X, Y) :- parent(X, Z), grandparent(Z, Y).

% sibling  relation, X\=Y basically means X!=Y
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X\=Y.

% first cousin relation
% both share the same grandparent and they aren't siblings. \+ is negation in prolog
fcousin(X, Y) :- grandparent(Z, X), grandparent(Z, Y), \+ sibling(X,Y), X\=Y.

% second cousin relation
% both share the same great_grandparent and they aren't siblings. \+ is negation in prolog
scousin(X, Y) :- great_grandparent(Z, X), great_grandparent(Z, Y), \+ sibling(X,Y), X\=Y.

% niece
% girl child  of your brother or sister
% X is the niece of Y
niece(X, Y) :- sibling(Z, Y), parent(Z, X), female(X).

% nephew
% male child of  your brother or sister
% X is the nephew of Y
nephew(X,Y) :- sibling(Z,Y), parent(Z, X), male(X).

% great nephew
% son of one's nephew or (; is or) niece
% X is the great nephew of Y
great_nephew(X, Y) :- nephew(Z, Y); niece(Z, Y),  parent(Z, X), male(X).

% ancestor relation as a recursion
anc(X,Y) :- parent(X,Y). % base case
anc(X,Y):- parent(X,Z), anc(Z,Y). % recursive case

% male ancestor
manc(X,Y) :- anc(X,Y), male(X).

% same_generation_cousins
% correct this
same_generation_cousins(X,Y):- fcousin(X,Y).
same_generation_cousins(X,Y):- parent(U,X), parent(V,Y), same_generation_cousins(U,V), \+ sibling(X,Y), X\=Y, U\=V.

% married
married(X,Y) :- child(Z,X), child(Z,Y), X\=Y.