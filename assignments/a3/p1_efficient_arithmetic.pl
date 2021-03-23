% 8.3.1 i
triangle(N, T) :- triangle(N,0,T).
triangle(N,Acc,T) :-  N > 0, N1 is N-1, Acc1 is N+Acc, triangle(N1, Acc1, T).
% terminal case where N = 0, then accumulator value is the result
triangle(0, Acc, Acc).

% 8.3.1 iii
% generating a range of integers in descending order
% between(I,J,K) K is the  integer between I and J: I<=K<=J
between(I,J,J) :- J >= I.
between(I,J,K) :- J > I, J1 is J-1, between(I, J1, K).


% 8.3.1 Vi
% program to find the minimum of a list of integers
% given a list L, Min is the minimum value  of that list
my_minimum([H|T], Min) :- my_minimum(T, H, Min).
% we need to  write two cases here
% case 1: when the head is lower= than currmin
my_minimum([H|T], CurrMin, Min) :- H=<CurrMin, my_minimum(T, H, Min).
% case 2:  when the  head is bigger  than the currmin
my_minimum([H|T], CurrMin, Min) :- H>CurrMin, my_minimum(T, CurrMin, Min).
% base case
my_minimum([], CurrMin, CurrMin).


% 8.3.1 Vii
list_length(Xs, N):- list_length(Xs, 0, N).
% base case where we have an empty list.
list_length([], C, C).
list_length([_|T], C, N) :- C1 is C+1, list_length(T, C1, N).
