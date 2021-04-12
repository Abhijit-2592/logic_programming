% usage cryptArithmetic([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]).
:- use_module(library(clpfd)).

cryptArithmetic([H1|T1] + [H2|T2] = [H3|T3]):- 
    append([H1|T1],[H2|T2],Temp), 
    append(Temp,[H3|T3],FullList),

    % we remove all duplicates in the list by casting it to set
    list_to_set(FullList, CurrSet),
    % constrain the  domains
    CurrSet ins 0..9,
    % make sure to given unique number to rach letter
    all_distinct(CurrSet), 

    % make sure the heads are not zeros
    H1 #> 0, H2 #> 0, H3 #> 0,
    
    %Check if they sum to the result
    combineListAsNum([H1|T1],N1),
    combineListAsNum([H2|T2],N2),
    combineListAsNum([H3|T3],N3),
    N3 #= N1 + N2,

    labeling([], CurrSet).

combineListAsNum([],0).
combineListAsNum([H|T],V) :- 
    length(T,L), Base #= 10^L, 
    BaseValue #= Base * H,
    
    V #= V1 + BaseValue,
    combineListAsNum(T,V1).
