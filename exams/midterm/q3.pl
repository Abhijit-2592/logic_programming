/*
Change Maker

Penny = 1
Nickel = 5
Dime = 10
Quarter = 25
*/

% generate a list of numbers between M and N
range(M,N,[M|Ns]):- M<N, M1 is M+1, range(M1, N, Ns).
range(N,N,[N]). 

% select
select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]):- select(X,Ys,Zs).

% create a list
generateChangesList(MaxCoins, ChangesList):-
    range(0, MaxCoins, PennyList), select(P, PennyList, _),
    range(0, MaxCoins, NickelList), select(N, NickelList, _),
    range(0, MaxCoins, DimeList), select(D, DimeList, _),
    range(0, MaxCoins, QuarterList), select(Q, QuarterList, _),
    P+N+D+Q=<MaxCoins,
    ChangesList = [P, N, D, Q].

validateChange([P,N,D,Q|_], Amount):-
    CurrAmount is P + 5*N + 10*D + 25*Q,
    CurrAmount == Amount.

% Generate Test Paradigm for finding the changes
calculate(Amount, MaxCoins, CoinList):-
    generateChangesList(MaxCoins, CoinList),
    validateChange(CoinList, Amount).
    




