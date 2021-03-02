% N queens problem. It is NP complete
% solution 1: Brute force: For every possible position, see if there is a clash with the other already  placed queens.
/* Representation of the ans is using a list
solution: [1,3,5,2,4,6,8,7](this is a randomly generated list and does not mean a ans. Present here just for illustration purposes)
col = index, row = value
Here we just need to check  if the queens hit  in the diagonals, As by the vitue of construction of this list, we make sure that no two queens are in the same row/column!
*/

% code for checking if a given board (a list of given configuration) is safe. i.e no two queens kill each other.

safe([]).
safe([Q|Qs]) :- safe(Qs), \+ attack(Q, Qs)  %  Q does not attack any of the queens in Qs

% attack
attack(X, Xs) :- attack=(X, 1, Xs).  % mid  value/accumulator  is the  column number, for the starting case, X is in the 0th column. and 1 is the next column
attack(X, N, [Y|Ys]) :- X is Y+N; X is Y-N. % checks if in diagonal. Same as seeing  slope is 1
attack(X, N, [Y|Ys]) :- N1 is N+1, attack(X, N1, Ys)

% brute force search.
% genereate all permutations and see if any of the permutation is safe
queens(N, Qs) :- range(1, N, L), % generate a list between 1 and N inclusive.
                 permute(L, Qs), % generate the permutation.
                 safe(Qs). % test.
                 
                 
% better solution
% back tracking search
% Note: In the worst case, it will check the same number of  configurations in the brute force case!
queens(N,Qs) :-range(1,N,Ns), queens(Ns, [], Qs). % accumulate the safe queens in the middle, Qs is the final answer
queens(UnplacedQs, SafeQs, Qs) :- select(Q, UnplacedQs, UnplacedQs1), 
                                  \+ attack(Q, SafeQs),
                                  queens(UnplacedQs1, [Q|SafeQs], Qs). % recurse.

% another solution called as forward checking which  we will look at it later!
