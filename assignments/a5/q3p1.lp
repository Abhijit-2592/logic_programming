% facts
lion(apollo). 
lion(helios).
lion(dangerous_lion).

% zoo has complete list of baby lions.
baby_lion(helios).
baby_lion(new_baby_lion).

-dangerous(apollo).

% Thus we can use CWC
-dangerous(X) :- 
    lion(X), % make it safe
    not dangerous(X). 

% if it is a baby lion, it is also a lion
lion(X) :- baby_lion(X).

% All lions are dangerous but with assumption
dangerous(X):-
    lion(X),
    not baby_lion(X),
    not -dangerous(X).

% baby lions are not dangerous
-dangerous(X) :-
    baby_lion(X).


#show dangerous/1.
#show -dangerous/1.