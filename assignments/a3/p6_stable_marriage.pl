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

% given a list of men and women check if the marriages are stable
stable([], _, _).
stable([Man|Men], Women, Marriages):-
  stable_women(Women, Man, Marriages),
  stable(Men, Women, Marriages).

% given a list of women and a single man check if the marriages are stable
stable_women([], _, _).
stable_women([Woman|Women], Man, Marriages):-
  \+unstable(Man, Woman, Marriages),
  stable_women(Women, Man, Marriages).

% Given a Man and Woman and a list of marriages see  if it is unstable
unstable(Man, Woman, Marriages):-
  married(Man, Wife, Marriages),
  married(Husband, Woman, Marriages),
  prefers(Man, Woman, Wife),
  prefers(Woman, Man, Husband).
  
married(Man, Woman, Marriages):-
  rest(marriage(Man, Woman), Marriages, _).  

% prefers(Person, OtherPerson, Spouse) is true if the Person prefers the
prefers(Person, OtherPerson, Spouse):-
  preferences(Person, Preferences),
  rest(OtherPerson, Preferences, Rest),
  rest(Spouse, Rest, _).
  
% rest(X, Ys, Zs) is true if X is a member of the list Ys, and the list   */
rest(X, [X|Ys], Ys):-!.
rest(X, [_|Ys], Zs):-rest(X, Ys, Zs).

% select(X, Ys, Zs) is true if Zs is the result of removing one           */
select(X, [X|Ys], Ys).
select(X, [Y|Ys], [Y|Zs]):-select(X, Ys, Zs).


% Generate all possible cases and test the marriage stability
stableMarriageProblem(Men, Women, Marriages):-
  generateMarriages(Men, Women, Marriages),
  stable(Men, Women, Marriages).

% generate all possible marriages from the given list
generateMarriages([], [], []).
generateMarriages([Man|Men], Women, [marriage(Man,Woman)|Marriages]):-
  select(Woman, Women, Women1),
  generateMarriages(Men, Women1, Marriages).