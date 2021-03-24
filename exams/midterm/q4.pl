% Sudoku
% generate a list of numbers between M and N
range(M,N,[M|Ns]):- M<N, M1 is M+1, range(M1, N, Ns).
range(N,N,[N]). 

% select
select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]):- select(X,Ys,Zs).

% checks if a list is unique
allDiff(L) :- \+ (select(X,L,R), member(X,R)).

index2D(Grid, RowIndex, ColIndex, Element):-
    nth0(RowIndex, Grid, Row),
    nth0(ColIndex, Row, Element).

getColVector(Grid, ColIndex, ColVector):-
    index2D(Grid, 0, ColIndex, A),
    index2D(Grid, 1, ColIndex, B),
    index2D(Grid, 2, ColIndex, C),
    index2D(Grid, 3, ColIndex, D),
    ColVector = [A, B, C, D].

generateRow(Row):-
    permutation([0,1,2,3], Row).

generateGrid4X4(Grid):-
    generateRow(R1),
    generateRow(R2),
    generateRow(R3),
    generateRow(R4),
    Grid = [R1, R2, R3, R4].

testGrid(Grid):-
    getColVector(Grid, 0, A), allDiff(A),
    getColVector(Grid, 1, B), allDiff(B),
    getColVector(Grid, 2, C), allDiff(C),
    getColVector(Grid, 3, D), allDiff(D),
    writeGrid(Grid).

minisudoku:-
    generateGrid4X4(Grid), testGrid(Grid).

writeGrid([R1, R2, R3, R4|_]):-
    writeRow(R1),
    writeRow(R2),
    writeRow(R3),
    writeRow(R4).

writeRow([A,B,C,D|_]):-
    write(A), write(" "), write(B), write(" "), write(C), write(" "), write(D), nl.
    

    









