%REFERENCE: http://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku
% usage: problem(1,Rows), sudoku(Rows), maplist(writeln, Rows).

:- use_module(library(clpfd)). 

% Define the problem from SWI prolog docs to test the program
problem(1, [[_,_,_,_,_,_,_,_,_], 
            [_,_,_,_,_,3,_,8,5], 
            [_,_,1,_,2,_,_,_,_], 
            [_,_,_,5,_,7,_,_,_], 
            [_,_,4,_,_,_,1,_,_], 
            [_,9,_,_,_,_,_,_,_], 
            [5,_,_,_,_,_,_,7,3], 
            [_,_,2,_,1,_,_,_,_], 
            [_,_,_,_,4,_,_,_,9]]
        ).

sudoku(Rows) :-
    length(Rows, 9), maplist(same_length(Rows), Rows),
    append(Rows, CurrGuess), CurrGuess ins 1..9, 
    maplist(all_distinct, Rows),
    % transpose the row matrix into column matrix
    transpose(Rows, Columns), 
    maplist(all_distinct, Columns), 
    Rows = [A,B,C,D,E,F,G,H,I],

    check3x3box(A, B, C), 
    check3x3box(D, E, F), 
    check3x3box(G, H, I).

check3x3box([], [], []). 
check3x3box([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :- 
    all_distinct([A,B,C,D,E,F,G,H,I]), 
    check3x3box(Bs1, Bs2, Bs3). 