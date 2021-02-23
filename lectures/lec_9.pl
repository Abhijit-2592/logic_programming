% Solving a few problems using Prolog: Useful for  HW3

/* Generalizing SEND + MORE = MONEY
*/
% crypt(L1, L2, L3) : L1 + L2 = L3
% crypt([S,E,N,D], [M,O,R,E], [M,O,N,E,Y]). We need to process the columns recursively.

% we need to reverse first
crypt(L1, L2, L3) :- rev(L1, L1r),
                     rev(L2, L2r),
                     rev(L3, L3r),
                     crypt2(L1r, L2r, L3r, null, [0,1,2,3,4,5,6,7,8,9]).
crypt2([H1|T1], [H2|T2], [H3|T3], C, N):- select(H1, N, N1),  
                                          select(H2, N1, N2), 
                                          H3 is (H2+H2+C)//10, 
                                          C1 is (H1+H2+C) div 10, 
                                          select(H3, N2, N3), 
                                          crypt2(T1,T2,T3,C1,N3).

% a few more base cases. This  is just a hint to the problem in HW3
% -----------------------------------------------------------------------------------------------------------------------%

/* CUTS: !
Pruning operators: A cut allows us to prune the search tree
Example in the quick sort partition
*/
partition(P, [], [], []).
partition(P, [H|T], [H|L], B) :- P=<H, !, partition(P,T,L,B). % when P <= H we are  certain the we never need to check the next rule so we can cut there.
partition(P, [H|T], L, [H|B]) :- P>H, partition(P,T,L,B).

/* Cuts: 1. Makes execution efficient,  
         2. Make the executionmore dependent on the order of goals anrd rules. Assuming the ordering is from  left to  right

Cuts generalized
A1 :- ...
A2 :- B1, B2, ..., Bk, !, Bk+1, Bk+2, Bn.
A3 :- ...

?- C :- A. % call
Execution of the cut:
1. Determine which call matched the clause/rule  containing the  cut. (Here A2)
2. Area from ! upto  the matching call is the "scope"  of the !. Basically it removes all the untried branches Any untried alternatives before ! is removed.
3. Think cut (!) as a commit, meaning once you reach that path so remember that and  remove any other alternate paths.

Note: Place a cut in  a rule at a point where Prolog does not  know  that  it should commit to that path, but  you  do.


Green cuts and Red cuts:

Green cuts: cuts that when removed, will not change the meaning of the program. For example  in the partition program if we remove the cut, the meaning of the program does not change.
Red cuts: cuts when  removed will change the meaning of the program
*/
min(X,Y,Z) :- X=<Y, !, Z=X. % assigns X to Z
min(X,Y,Z) :- Z=Y.

% ------------------------------------------------------------------------------------------------------------------------%

/* Negation in prolog

Rules  in prolog are  Horn  clauses. Horn clause is arule  with one positive literal. 
*/