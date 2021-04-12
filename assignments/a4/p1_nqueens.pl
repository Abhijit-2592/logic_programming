% Usage: nQueens(4,Q), label(Q).

:- use_module(library(clpfd)).

nQueens(N, Qs) :-
    length(Qs, N),
    Qs ins 1..N,
    safeQueens(Qs).

safeQueens([]).
safeQueens([Q|Qs]) :- 
    safeQueens(Qs, Q, 1),
    safeQueens(Qs).

safeQueens([], _, _).
safeQueens([Q|Qs], Q1, D1) :-
    % make sure it is diagonally safe
    abs(Q1 - Q) #\= D1, 
    % make sure it is not in same row.
    Q1 #\= Q,
    D2 #= D1 + 1,
    %recurse
    safeQueens(Qs, Q1, D2).