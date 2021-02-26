/* Horn clause : Rule with atmost one positive literal.
p :- q,s,not r - This is a H.C
*/
% -------------------------------------------------------------
/*
Negation is really negation as failure (NAF). In prolog False is equivalent to failure.
To prove something to be false, it is same as proving not p is True.  
*/
% code for negation as a failure, Most prolog has it built in.
\+ G :- call(G), !, fail. % if G succeeds \+ G should fail, else \+ G should succeed
\+ G.  % if call(G) fails then it is a fact and reaches here.
% Use NAF carefully, \+ G (NAF) is  sound  only if G does not have  variables. This means, G is ground (means, all the arguments are constants)

/* Note:
== is comparison and =  is the unification operator.
X\==Y :- \+(X == Y)
X\=Y :- \+(X=Y)
*/

/* built in  var(X): succeeds if X is an unbound  variable.  nonvar(X) is  the opposite of it */
/* assert and  retract are alo built ins*/