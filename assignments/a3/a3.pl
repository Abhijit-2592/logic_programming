%% select
select(X, [X|T], T).
select(X, [Y|T], [Y|R]):- select(X,T,R).

headNonZero([H|T]) :-
    (H\=0 -> true;false).

% tail recursive rev
rev(L1, L2) :- rev(L1, [], L2).
rev([], P, P).
rev([H|T], P, R) :- rev(T, [H|P], R).

% member(X, [X|T]). % base case where I find the element in the head.
% member(X, [Y|T]) :- member(X, T).  % recursively look in the tail.

% % append L3 is obtained after appending L2 to L1
% append([],L,L).
% append([X|T], Y, [X|Z]) :- append(T,Y,Z).

% % no_doubles
% no_doubles([], []).
% no_doubles([X], [X]).
% % when the head is present as duplicate in the tail
% no_doubles([X|Xs], [X|Ys]) :- member(X, Xs), delete(Xs, X, Zs), no_doubles(Zs, Ys).
% % when the  head is not present as duplicate in the tail
% no_doubles([X|Xs], [X|Ys]) :- \+member(X, Xs), no_doubles(Xs, Ys).

% alldif([]).
% alldif([E|Es]) :-
%    maplist(dif(E), Es),
%    alldif(Es).

%% Send + More = Money
/*

    S   E   N   D
  + M   O   R   E
-------------------
  M O   N   E   Y

*/
sendMoreSolve([S,E,N,D,M,O,R,Y]):- 
    M=1,
    % column 1, D + E = Y
    select(D, [0,2,3,4,5,6,7,8,9],R1),
    select(E, R1, R2),
    Y is (D+E) mod 10,
    C1 is (D+E) // 10, % carry
    select(Y, R2,  R3), % we need to make sure Y is Different from D and E
    % column 2, N + R = E
    select(N, R3, R4),
    select(R, R4, R5),
    E  is (C1+N+R) mod 10,
    C2 is (C1+N+R) // 10, % R
    % no  need to  select E since  we already have E
    % column 3, E + O = N
    % no need to  select E since we already  have E
    select(O, R5, R6),
    N is (C2+E+O) mod 10,
    C3 is (C2+E+O) // 10,
    % no need to select N
    % column 4: S + M = O
    select(S, R6, R7),
    % M is already set to 1
    O is (C3+S+M) mod 10,
    M is (C3+S+M) //  10.
  

% generic version of Crypt-arithmetic puzzles
% crypt(L1, L2, L3): L1+L2=L3
% example crypt([S,E,N,D], [M,O,R,E], [M,O,N,E,Y])
% rules are same as Send + More  = Money
% first reverse the list
crypt(L1, L2, L3):-
    % first reverse the list
    % append(L1, L2, A), append(A, L3, B), no_doubles(B, D),
    rev(L1, L1r), rev(L2, L2r), rev(L3,L3r),
    crypt2(L1r, L2r, L3r, 0, [0,1,2,3,4,5,6,7,8,9]), % 0 is for carry
    headNonZero(L1), headNonZero(L2), headNonZero(L3).

crypt2([H1|T1], [H2|T2],  [H3|T3], C, N):-
    % The only remaining logic is we have to make sure that we need to do select only  when the H1,H3,H3 is unbound
    (var(H1) -> select(H1, N, N1); N1=N), % (P->Q;R) if P do Q else R
    (var(H2) -> select(H2, N1, N2); N2=N1),
    (var(H3) -> H3 is (H1+H2+C) mod 10, select(H3, N2, N3); H3 is (H1+H2+C) mod 10, N3=N2),
    % H3 is (H1+H2+C) mod 10,
    C1 is (H1+H2+C) // 10,
    % (nonvar(H3) -> select(H3, N2, N3); N3=N1),
    % H1\=H2, H2\=H3, H3\=H1,
    crypt2(T1, T2, T3, C1, N3).

% base case
crypt2([],[],[],0,_).
crypt2([],[], [C], C, _).





