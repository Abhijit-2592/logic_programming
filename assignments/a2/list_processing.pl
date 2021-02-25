% type check list
list([]).
list([H|T]) :- list(T).


% length of list
len([], 0).
len([H|T], s(N)) :- len(T,N).


% is an element present in list.
% E is present in L
% no need for empty base case
member(X, [X|T]). % base case where I find the element in the head.
member(X, [Y|T]) :- member(X, T).  % recursively look in the tail.


% append L3 is obtained after appending L2 to L1
append([],L,L).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).


% prefix (L1 is prefix of L2)
prefix(L1, L2) :- append(L1, _, L2).
suffix(L1, L2) :- append(_, L1, L2).

% sublist
sublist(L1, L2) :- prefix(P, L2), suffix(L1, P).

% rev(L1, L2): L2 is the reverse of L1
rev([], []).
rev([H|T], R) :- rev(T, Tr), append(Tr, [H], R).

% tail recursive rev
trev(L1, L2) :- trev(L1, [], L2).
trev([], P, P).
trev([H|T], P, R) :- trev(T, [H|P], R).


% adjacent
adjacent(X,Y,[X,Y|Zlist]).
adjacent(X,Y,[H|T]) :- adjacent(X,Y,T).

% last
last(T,[T]).
last(X,[H|T]) :- last(X,T).

% delete all occurances
delete([X|Xs],X,Ys) :- delete(Xs,X,Ys).
delete([X|Xs], Z, [X|Ys]) :- X\=Z, delete(Xs, Z, Ys).
delete([],X,[]).

% double
double([],[]).
double([H|T1], [H,H|T2]) :- double(T1,T2).

% 3.3.1 (i)
% substitute
substitute(X,Y,[],[]).
substitute(X,Y,[X|Tx],[Y|Ty]) :- substitute(X,Y,Tx,Ty).
substitute(X,Y,[Z|Tz1],[Z|Tz2]) :- X\=Z, substitute(X,Y,Tz1,Tz2).

% no_doubles
no_doubles([], []).
no_doubles([X], [X]).
% when the head is present as duplicate in the tail
no_doubles([X|Xs], [X|Ys]) :- member(X, Xs), delete(Xs, X, Zs), no_doubles(Zs, Ys).
% when the  head is not present as duplicate in the tail
no_doubles([X|Xs], [X|Ys]) :- \+member(X, Xs), no_doubles(Xs, Ys).
