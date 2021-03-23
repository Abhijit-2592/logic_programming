% Usage: stableMarriageProblem([avraham, binyamin, chaim, david, elazar], [zvia, chana, ruth, sarah, tamar], M).

preferences(avraham, [chana,tamar,zvia,ruth,sarah]).
preferences(binyamin, [zvia,chana,ruth,sarah,tamar]).
preferences(chaim,  [chana,ruth,tamar,sarah,zvia]).
preferences(david, [zvia,ruth,chana,sarah,tamar]).
preferences(elazar, [tamar,ruth,chana,zvia,sarah]).
preferences(zvia, [elazar,avraham,david,binyamin,chaim]).
preferences(chana, [david,elazar,binyamin,avraham,chaim]).
preferences(ruth, [avraham,david,binyamin,chaim,elazar]).
preferences(sarah, [chaim,binyamin,david,avraham,elazar]).
preferences(tamar, [david,binyamin,chaim,elazar,avraham]).


% rest(X, Ys, Zs) is true if X is a member of the list Ys, and the list Zs is the rest of the list following X
rest(X, [X|T], T).
rest(X, [_|T], Zs):-rest(X, T, Zs).

%% select
select(X, [X|T], T).
select(X, [Y|T], [Y|R]):- select(X,T,R).

% given a list of ManList and WomanList check if the marriages are stable
stable([], _, _).
stable([Man|ManList], WomanList, MarriageList):-
  stable_women(WomanList, Man, MarriageList),
  stable(ManList, WomanList, MarriageList).

% given a list of WomanList and a single man check if the marriages are stable
stable_women([], _, _).
stable_women([Woman|WomanList], Man, MarriageList):-
  \+unstable(Man, Woman, MarriageList),
  stable_women(WomanList, Man, MarriageList).

% Given a Man and Woman and a list of marriages see  if it is unstable
unstable(Man, Woman, MarriageList):-
  married(Man, Wife, MarriageList),
  married(Husband, Woman, MarriageList),
  preferOther(Man, Woman, Wife),
  preferOther(Woman, Man, Husband).
  
married(Man, Woman, MarriageList):-
  rest(marriage(Man, Woman), MarriageList, _).  

% preferOther(P, Other, Q) is true if the P preferOther the other instead of Q
preferOther(P, Other, Q):-
  preferences(P, Preferences),
  rest(Other, Preferences, Remaining),
  rest(Q, Remaining, _).

% Generate all possible cases and test the marriage stability
stableMarriageProblem(ManList, WomanList, MarriageList):-
  generateMarriages(ManList, WomanList, MarriageList),
  stable(ManList, WomanList, MarriageList).

% generate all possible marriages from the given list
generateMarriages([], [], []).
generateMarriages([Man|ManList], WomanList, [marriage(Man,Woman)|MarriageList]):-
  select(Woman, WomanList, WomanList2),
  generateMarriages(ManList, WomanList2, MarriageList).