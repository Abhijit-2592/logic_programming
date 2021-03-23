% usage:
% missionaryCannibalSolve(StartingState, EndingState, ExploredStates, MovesList)
% Represent state as `state(CL,ML,B,CR,MR)`
% cannibals in the left, missionaries in the left, Boat position, cannibals in the right, missionaries in the right
% for starting in left: missionaryCannibalSolve( state(3,3,left,0,0),state(0,0,right,3,3),[state(3,3,left,0,0)],_).
% for starting in right: missionaryCannibalSolve(state(0,0,right,3,3),  state(3,3,left,0,0),[state(0,0,right,3,3)],_)


member(X, [X|T]). % base case where I find the element in the head.
member(X, [Y|T]) :- 
    member(X, T).  % recursively look in the tail.

% tail recursive rev
rev(L1, L2) :- 
    rev(L1, [], L2).
    rev([], P, P).
    rev([H|T], P, R) :- rev(T, [H|P], R).

stateAllowed(CL,ML,CR,MR) :-
	% Check if this  state is allowed
	ML>=0, CL>=0, MR>=0, CR>=0,
	(ML>=CL ; ML=0),
	(MR>=CR ; MR=0).

% Represent state as `state(CL,ML,B,CR,MR)`
% cannibals in the  left, missionaries in the  left, Boat position, cannibals in the right, missionaries in the right
% All possible  moves:
move(state(CL,ML,left,CR,MR),state(CL,ML2,right,CR,MR2)):-
	% Two missionaries cross left to right.
	MR2 is MR+2,
	ML2 is ML-2,
	stateAllowed(CL,ML2,CR,MR2).

move(state(CL,ML,left,CR,MR),state(CL2,ML,right,CR2,MR)):-
	% Two cannibals cross left to right.
	CR2 is CR+2,
	CL2 is CL-2,
	stateAllowed(CL2,ML,CR2,MR).

move(state(CL,ML,left,CR,MR),state(CL2,ML2,right,CR2,MR2)):-
	%  One missionary and one cannibal cross left to right.
	CR2 is CR+1,
	CL2 is CL-1,
	MR2 is MR+1,
	ML2 is ML-1,
	stateAllowed(CL2,ML2,CR2,MR2).

move(state(CL,ML,left,CR,MR),state(CL,ML2,right,CR,MR2)):-
	% One missionary crosses left to right.
	MR2 is MR+1,
	ML2 is ML-1,
	stateAllowed(CL,ML2,CR,MR2).

move(state(CL,ML,left,CR,MR),state(CL2,ML,right,CR2,MR)):-
	% One cannibal crosses left to right.
	CR2 is CR+1,
	CL2 is CL-1,
	stateAllowed(CL2,ML,CR2,MR).

move(state(CL,ML,right,CR,MR),state(CL,ML2,left,CR,MR2)):-
	% Two missionaries cross right to left.
	MR2 is MR-2,
	ML2 is ML+2,
	stateAllowed(CL,ML2,CR,MR2).

move(state(CL,ML,right,CR,MR),state(CL2,ML,left,CR2,MR)):-
	% Two cannibals cross right to left.
	CR2 is CR-2,
	CL2 is CL+2,
	stateAllowed(CL2,ML,CR2,MR).

move(state(CL,ML,right,CR,MR),state(CL2,ML2,left,CR2,MR2)):-
	%  One missionary and one cannibal cross right to left.
	CR2 is CR-1,
	CL2 is CL+1,
	MR2 is MR-1,
	ML2 is ML+1,
	stateAllowed(CL2,ML2,CR2,MR2).

move(state(CL,ML,right,CR,MR),state(CL,ML2,left,CR,MR2)):-
	% One missionary crosses right to left.
	MR2 is MR-1,
	ML2 is ML+1,
	stateAllowed(CL,ML2,CR,MR2).

move(state(CL,ML,right,CR,MR),state(CL2,ML,left,CR2,MR)):-
	% One cannibal crosses right to left.
	CR2 is CR-1,
	CL2 is CL+1,
	stateAllowed(CL2,ML,CR2,MR).


% Solution to the problem
missionaryCannibalSolve(state(CL1,ML1,B1,CR1,MR1),state(CL_final,ML_final,B_final,CR_final,MR_final),ExploredStates,MovesList) :- 
   state(CL1,ML1,B1,CR1,MR1) \= state(CL_final,ML_final,B_final,CR_final,MR_final), % make sure the starting and ending states are not same
   move(state(CL1,ML1,B1,CR1,MR1),state(CL2,ML2,B2,CR2,MR2)), % make an allowed move
   \+member(state(CL2,ML2,B2,CR2,MR2),ExploredStates), % make sure the current allowed state is not already in the explored state
   % recurse for the next move with the current move as the starting state
   missionaryCannibalSolve(state(CL2,ML2,B2,CR2,MR2),state(CL_final,ML_final,B_final,CR_final,MR_final),
   [state(CL2,ML2,B2,CR2,MR2)|ExploredStates], % stick the current allowed state to the head of the explored state list
   [[state(CL2,ML2,B2,CR2,MR2), state(CL1,ML1,B1,CR1,MR1)] | MovesList ]). % add the starting state and the next state to the moveslist

%Solution found
missionaryCannibalSolve(state(CL_final,ML_final,B_final,CR_final,MR_final),state(CL_final,ML_final,B_final,CR_final,MR_final),_,MovesList):- rev(MovesList,MovesListr),
writeList(MovesListr).

% % Printing
writeList([]) :- nl. 
writeList([[A,B]|T]) :- 
   	write(B), write(' -> '), write(A), nl,
    writeList(T).