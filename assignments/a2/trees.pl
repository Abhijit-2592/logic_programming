% tree member in BST
tree_member(X, node(X, _, _)).
tree_member(X, node(Y, L, R)):- X =<Y, tree_member(X,L).
tree_member(X, node(Y, L, R)):- X>Y, tree_member(X,R).

% Tree insert
% Tr is obtained by inserting X in T observing the sorted binary tree property
tree_insert(X, nil, node(X,nil,nil)). % base case
tree_insert(X, node(Y, L, R), node(Y, Lt1, R)) :- X<Y, tree_insert(X, L, Lt1).
tree_insert(X, node(Y, L, R), node(Y, L, Rt1)):- X>Y, tree_insert(X,R, Rt1).

% add
plus(0,X,X). % 0+X = X, base case
% we can compute X+1 + Y = Z+1 if I can  recursively compute X + Y =Z
plus(s(X), Y, s(Z)) :- plus(X,Y,Z).

% sumtree
sumtree(node(X, nil, nil), X).
% when the  node has both children
sumtree(node(X, L, R), N):- sumtree(L, Nl), sumtree(R, Nr), plus(Nr, Nl, M), plus(M, X, N).
% when node has left child only
sumtree(node(X, L, nil), N):- sumtree(L, Nl), plus(Nl, X, N).
% when node has right child only
sumtree(node(X, nil, R), N):- sumtree(R, Nr), plus(Nr, X, N).
