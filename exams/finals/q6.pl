% algorithm reference: https://gaming.stackexchange.com/questions/11123/strategy-for-solving-lights-out-puzzle
% % the algorithm is called following the light
% |--------------------+-----------------|
% | Left on bottom row | Push on top row |
% |--------------------+-----------------|
% | 1, 2, 3            |               2 |
% | 1, 2, 4, 5         |               3 |
% | 1, 3, 4            |               5 |
% | 1, 5               |            1, 2 |
% | 2, 3, 5            |               1 |
% | 2, 4               |            1, 4 |
% | 3, 4, 5            |               4 |
% |--------------------+-----------------|

% modified append to return a list when empty list is given
append([],L,[L]).
append([X|T], Y, [X|Z]) :- append(T,Y,Z).
% This solves only the 5X5 puzzle
% everything using 1 indexing
% removes the element 
remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, 
   K1 is K - 1, remove_at(X,Xs,K1,Ys).
% insert an element X at position K in the list L and the result is R
insert_at(X,L,K,R) :- remove_at(X,R,K,L).
% Modify the element at position K with X in the list  L and the result is R
modify_at(X,L,K,R) :- remove_at(_, L, K, R1), insert_at(X, R1, K, R).

% index into 2D list
% Uses 1 indexing.
get_index2D(Grid, (RowIndex, ColIndex), Element):-
    nth1(RowIndex, Grid, Row),
    nth1(ColIndex, Row, Element).

% modifies element in given 2D index.
% This Modifies the element at position (R,C) with X in the 2D Grid and the result is OutGrid
modify_index2D(X, Grid, (RowIndex, ColIndex), OutGrid):-
    remove_at(Row, Grid, RowIndex, RemovedGrid), % get the row
    modify_at(X, Row, ColIndex, ModifiedRow), % modify the row
    insert_at(ModifiedRow, RemovedGrid, RowIndex, OutGrid).

flip_element(Grid, (R,C), FlippedGrid):-
    % does not do any check for index. So check if the index is valid before calling this function
    get_index2D(Grid, (R,C), Element),
    (Element == 0 -> modify_index2D(1, Grid, (R,C), FlippedGrid); modify_index2D(0, Grid, (R,C), FlippedGrid)).

check_index(Grid, (R, C)) :-
    length(Grid, MyLen),
    R >= 1, R =< MyLen,
    C >= 1, C =< MyLen.

flip_one_switch(Grid, (R,C), FlippedGrid):-
    check_index(Grid, (R,C)) -> flip_element(Grid, (R,C), FlippedGrid); FlippedGrid = Grid.

% This flips the Grid as given in problem definition
% The given R,C and all the 4 adjacent cells are flipped
flip_switch(Grid, (R,C), FlippedGrid) :-
    % writeGrid(Grid),
    % flip that position
    flip_one_switch(Grid, (R,C), FG1),
    R1 is R - 1, R2 is R + 1,
    C1 is C - 1, C2 is C + 1,
    % left flip
    flip_one_switch(FG1, (R,C1), FG2),
    % right flip
    flip_one_switch(FG2, (R,C2), FG3),
    % top flip
    flip_one_switch(FG3, (R1,C), FG4),
    % bottom flip
    flip_one_switch(FG4, (R2,C), FlippedGrid).
    % nl,
    % writeGrid(FlippedGrid).

% driver predicate
get_on_switch_in_row(RowList, OutList):- get_on_switch_in_row(RowList, 1, [], OutList).
get_on_switch_in_row(RowList, C, Acc, OutList):-
    length(RowList, MyLen),
    C =< MyLen,
    nth1(C, RowList, Element),
    (Element == 1 -> append(Acc, C, Acc1); Acc1 = Acc),
    C1 is C+1,
    get_on_switch_in_row(RowList, C1, Acc1, OutList).
% base case
get_on_switch_in_row(RowList, C, Acc, OutList):- 
    length(RowList, MyLen),
    C > MyLen,
    OutList = Acc.

% base case
% flips the  switches in the given row of the grid using a list of columns
flip_row(Grid, _, [], FlippedGrid) :- FlippedGrid = Grid.
flip_row(Grid, R, [C|ColList], FlippedGrid):-
    writeMove((R,C)),
    flip_switch(Grid, (R,C), FlippedGrid1),
    flip_row(FlippedGrid1, R, ColList, FlippedGrid).

% driver code
solve_until_last_row(Grid, FlippedGrid):- 
    solve_until_last_row(Grid, 1, FlippedGrid).
solve_until_last_row(Grid, 5, FlippedGrid) :- FlippedGrid = Grid. % stop when you reach the last row
solve_until_last_row(Grid, RowIndex, FlippedGrid):-
    RowIndex<5,
    % get all columns with switch on in that row
    nth1(RowIndex, Grid, Row),
    get_on_switch_in_row(Row, ColList),
    RowIndex1 is RowIndex + 1,
    flip_row(Grid, RowIndex1, ColList, FG),
    solve_until_last_row(FG, RowIndex1, FlippedGrid).


solve_last_row(Grid, FinalAns) :- 
    % The seven cases are listed above putting an if else for the cases
    nth1(5, Grid, LastRow),
    get_on_switch_in_row(LastRow, ColList),
    % Flip the corresponding first  row
    (
        ColList == [1,2,3] -> flip_switch(Grid, (1,2), FlippedGrid), writeMove((1,2));
        ColList == [1,2,4,5] -> flip_switch(Grid, (1,3), FlippedGrid), writeMove((1,3));
        ColList == [1,3,4] -> flip_switch(Grid, (1,5), FlippedGrid), writeMove((1,5));
        ColList == [1,5] -> flip_switch(Grid, (1,1), FlippedGrid1), writeMove((1,1)), flip_switch(FlippedGrid1, (1,2), FlippedGrid), writeMove((1,2)); 
        ColList == [2,3,5] -> flip_switch(Grid, (1,1), FlippedGrid), writeMove((1,1));
        ColList == [2,4] -> flip_switch(Grid, (1,1), FlippedGrid1), writeMove((1,1)), flip_switch(FlippedGrid1, (1,4), FlippedGrid), writeMove((1,4)); 
        ColList == [3,4,5] -> flip_switch(Grid, (1,4), FlippedGrid), writeMove((1,4));
        FlippedGrid = Grid
    ),
    % repeat solve until last Row
    solve_until_last_row(FlippedGrid, FinalAns).

solve5X5(Grid, FinalAns):-
    solve_until_last_row(Grid, FlippedGrid),
    solve_last_row(FlippedGrid, FinalAns).





writeMove((R,C)):- write(R), write(", "), write(C), nl.
% writes a given 2D grid to console
writeGrid([R1, R2, R3, R4, R5|_]):-
    writeRow(R1),
    writeRow(R2),
    writeRow(R3),
    writeRow(R4),
    writeRow(R5).

% writes a given row to the console. This is used by write grid
writeRow([A,B,C,D,E|_]):-
    write(A), write(" "), write(B), write(" "), write(C), write(" "), write(D), write(" "), write(E),nl.


    
