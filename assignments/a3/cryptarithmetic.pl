%% select
select(X, [X|T], T).
select(X, [Y|T], [Y|R]):- select(X,T,R).

headNonZero([H|T]) :-
    (H\=0 -> true;false).

% tail recursive rev
rev(L1, L2) :- rev(L1, [], L2).
rev([], P, P).
rev([H|T], P, R) :- rev(T, [H|P], R).

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





