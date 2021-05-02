country(united_states).
country(italy).

american_citizen(john).
american_citizen(miriam).
american_citizen(caleb).

american_diplomat(miriam).


live_in(john,italy).

% CWA: american_diplomats: UNCOMMENT for part b
% -american_diplomat(X) :- 
%   american_citizen(X),
%   not american_diplomat(X).

% Representing exceptions to default
ab_citizen(X):-
    american_citizen(X), % make it safe
    not american_diplomat(X).


% normally american citizens live in USA
live_in(X, united_states) :- 
    american_citizen(X),
    % -american_diplomat(X), % uncomment for part B
    not ab_citizen(X), % Default is not applicable here, comment for part b
    not -live_in(X, united_states). % default maybe true

% Diplomat may or may not live in united_states
% Diplomat living in united_states
live_in(X,united_states) :- 
    not -live_in(X,united_states), 
    american_diplomat(X).

% Diplomat not living in united_states
-live_in(X,united_states) :- 
    not live_in(X,united_states), 
    american_diplomat(X).

% Person can live only in one country
-live_in(X,Z) :-
    american_citizen(X), % make it safe
    country(Z), % make it safe
    live_in(X,Y), country(Y), Y != Z.


#show -live_in/2.
#show live_in/2.