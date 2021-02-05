% natural numbers.
num(0). % 0 is a number
num(s(X)) :- num(X). % s(X) is a number if X is a number, s(X) is the successor of X and s() is a structure

% add
add(0,X,X). % 0+X = X, base case
% we can compute X+1 + Y = Z+1 if I can  recursively compute X + Y =Z
add(s(X), Y, s(Z)) :- add(X,Y,Z).


% multiply
multiply(0,X,0). % 0*X= 0, base case
% (X+1)*Y = W 
% if X*Y= Z and Y+Z = W. Expand (X+1)*Y to get this result
multiply(s(X), Y, W) :- multiply(X,Y,Z), add(Z,Y,W).

% greater than
gt(s(X), 0). % x+1 > 0
gt(s(X),s(Y)) :- gt(X,Y). % x+1 > y+1 if x>y


% factorial
factorial(0, s(0)).
factorial(s(0), s(0)).
factorial(s(X), Y):- multiply(s(X), X, Y), add(W, s(0), X), factorial(W, Z).


% reminder
% base case Y>X means ans is X
rem(X, Y, X) :- gt(Y,X).
rem(X, Y, Z) :- add(U, Y, X), rem(U, Y, Z).

% quotient
% 0 if Y > X
quotient(X, Y, 0) :- gt(Y, X).
% q = 1 + q(x-y, y)
quotient(X, Y, Z) :- add(s(0), W, Z), add(V, Y, X),quotient(V, Y, W).

% division
div(X,Y,Q,R) :- rem(X,Y,R), quotient(X,Y,Q).

% fibonacci
fib(s(0), s(0)). % [1] = 1
fib(s(s(0)), s(0)). % [2] = 1
% fib(n-2) + fib(n-1)
% n-2 is X-1, n-1 = X
fib(s(X), Z) :- add(Y, s(0), X), fib(Y, U), fib(X, V), add(U, V, Z).