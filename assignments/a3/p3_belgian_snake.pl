% usage: 
snake(_,_,[]).

snake(P,R,[C]) :- 
    create_pattern(P,R,C,_), writeList(C).

snake(P,R,[C1,C2|Cs]) :- 
    create_pattern(P,R,C1,P1),
    create_pattern(P1,R,T,P2),
    reverse(T,C2),
    writeList(C1), writeList(C2),
    snake(P2,R,Cs).

% check_rotate([a,b,c],[b,c,a]) is true.
check_rotate([],[]).
check_rotate([X|T],R) :-
    append(T,[X],R).

% make(Pattern,Row,R,Pn): Fills Row with cyclic 
% patterns to give R, with Pn as the last rotation. 
create_pattern(Plast,[],[],Plast).
create_pattern([P|Ps],[_|Rs],[P|Ls],Plast) :- 
    check_rotate([P|Ps],Pnext),
    create_pattern(Pnext,Rs,Ls,Plast).

% writes the List on a new-line
writeList([]) :- nl.
writeList([H|T]) :- write(H), write(' '), writeList(T).

% append L3 is obtained after appending L2 to L1
append([],L,L).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).

% tail recursive reverse
rev(L1, L2) :- rev(L1, [], L2).
rev([], P, P).
rev([H|T], P, R) :- rev(T, [H|P], R).
