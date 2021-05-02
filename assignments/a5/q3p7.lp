course(math).
course(graphs).

student(john). 
student(mary).

took(john,graphs).
took(john,math).
took(mary,graphs).

-took(S,C) :-
    student(S), 
    course(C),
    not took(S,C).

can_graduate(S) :-
    student(S),
    not -can_graduate(S).

-can_graduate(S) :- 
    student(S),
    course(C),
    -took(S,C).
