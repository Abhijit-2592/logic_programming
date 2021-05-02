% Answer set programming. Run in SCASP
flies(X) :- bird(X), not abnormal(X).

abnormal(X) :- penguin(X).
bird(X) :- penguin(X).

bird(tweety).
bird(sam).

% penguin(tweety).?
bird(tweety).
bird(sam).