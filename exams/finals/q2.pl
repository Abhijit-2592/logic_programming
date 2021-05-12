sub([],X).
sub([X|L], L1) :- sff([X|L2], L1), sub(L, L2).

sff(L, L).
sff(L1, [X|L]) :- sff(L1, L).

comm(X,Y) :- sub([X,Y] ,[a,t,s]), sub([X,Y] ,[a,s,t]).