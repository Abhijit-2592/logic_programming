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


even_permutation(Xs, Ys):-
    permute(Xs, Ys),
    sopod(Xs, 1, D),
    sopod(Ys, 1, E),
    D = E.
  
% odd_permutation(Xs, Ys) is true if Ys is an odd permutation of Xs.
odd_permutation(Xs, Ys):- 
    permute(Xs, Ys), 
    sopod(Xs, 1, D), 
    sopod(Ys, 1, E), 
    D =\= E.

% permute
permute([], []).
permute([X|Xs], Ys1):- permute(Xs, Ys), pick(X, Ys1, Ys).

pick(X, [X|Xs], Xs).
pick(X, [Y|Ys], [Y|Zs]):- pick(X, Ys, Zs).

% sign of product of differences
sopod([], D, D).
sopod([Y|Xs], D0, D):- 
    sopod_new(Xs, Y, D0, D1), 
    sopod(Xs, D1, D).

sopod_new([], _, D, D).
sopod_new([X|Xs], Y, D0, D):-  
    Y =\= X, 
    D1 is D0 * (Y - X) // abs(Y - X), 
    sopod_new(Xs, Y, D1, D).


% merge sort
merge_sort([], []).
merge_sort([X], [X]).
merge_sort([Odd,Even|Xs], Ys):-
  split([Odd,Even|Xs], Odds, Evens),
  merge_sort(Odds, Os),
  merge_sort(Evens, Es),
  ordered_merge(Os, Es, Ys).

% split(Xs, Os, Es) is true if Os is a list containing the odd positioned
split([], [], []).
split([X|Xs], [X|Os], Es):-split(Xs, Es, Os).

% ordered_merge(Xs, Ys, Zs) is true if Zs is an ordered list obtained
ordered_merge([], Ys, Ys).
ordered_merge([X|Xs], [], [X|Xs]).
ordered_merge([X|Xs], [Y|Ys], [X|Zs]):-X < Y, ordered_merge(Xs, [Y|Ys], Zs).
ordered_merge([X|Xs], [Y|Ys], [Y|Zs]):-X >= Y, ordered_merge([X|Xs], Ys, Zs).