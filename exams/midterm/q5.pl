% Decimal base conversion

% modified append to return a list when empty list is given
append([],L,[L]).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).


% tail recursive rev
rev(L1, L2) :- rev(L1, [], L2).
rev([], P, P).
rev([H|T], P, R) :- rev(T, [H|P], R).


% handle base 1 separately and all other bases separately
convert(N, Base, FinalAns):- Base > 1, convertToBaseN(N, Base, [], FinalAns).
convert(N, 1, FinalAns):- convertToBase1(N, [], FinalAns).


% handle base 1 separately
% recursive case
convertToBase1(N, CurrList, FinalAns):- 
    length(CurrList, N1), 
    N1<N, 
    append(CurrList, 1, CurrList2),
    convertToBase1(N, CurrList2, FinalAns).
% base case
convertToBase1(N, FinalAns, FinalAns):- length(FinalAns, N1), N1 is N.


% handle all other bases here
% recursive case
convertToBaseN(N, Base, CurrList, FinalAns):-
    N >= Base,
    N1 is N // Base,
    Value is N mod Base,
    (
    Value is 10 -> append(CurrList, 'a', CurrList2);
    Value is 11 -> append(CurrList, 'b', CurrList2);
    Value is 12 -> append(CurrList, 'c', CurrList2);
    Value is 13 -> append(CurrList, 'd', CurrList2);
    Value is 14 -> append(CurrList, 'e', CurrList2);
    Value is 16 -> append(CurrList, 'f', CurrList2);
    append(CurrList, Value, CurrList2)
    ),

    convertToBaseN(N1, Base, CurrList2, FinalAns).
% base case
convertToBaseN(N, Base, CurrList, FinalAns):- N<Base, append(CurrList, N, Ans), rev(Ans, FinalAns).