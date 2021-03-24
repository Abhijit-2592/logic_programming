% Farm yard. Chicken and rabbits
countRabbits(Heads, Legs, C) :-
    H is 2*Heads,
    C1 is Legs - H,
    C is C1 / 2.

% solution A
find_rabbits_and_chickens(Heads, Legs, RabbitCount, ChickenCount):-
    % First find the number of rabbits
    countRabbits(Heads, Legs, RabbitCount),
    RabbitCount>=0, integer(RabbitCount),
    ChickenCount is Heads - RabbitCount,
    ChickenCount>=0, integer(ChickenCount).

% generate a list of numbers between M and N
range(M,N,[M|Ns]):- M<N, M1 is M+1, range(M1, N, Ns).
range(N,N,[N]). 

% select
select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]):- select(X,Ys,Zs).

% solution B
find_total_number_of_animals(Legs, TotalCount):-
    % generate a list of heads from 1 to 40
    range(1, 40, HeadList),
    % select each head: This is the generation part
    select(Heads, HeadList, _),
    % below is the test part
    find_rabbits_and_chickens(Heads, Legs, RabbitCount, ChickenCount),
    % make sure the Rabbit and chicken counts make sense
    integer(RabbitCount), integer(ChickenCount), RabbitCount>=0, ChickenCount>=0,
    TotalCount is RabbitCount + ChickenCount.
    





