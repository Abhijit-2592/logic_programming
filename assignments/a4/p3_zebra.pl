% usage zebraPuzzle([Englishman, Spaniard, Japanese, Italian, Norwegian], 
% [Green, Red, Yellow, Blue, White], 
% [Kools, Chesterfield, OldGold, LuckyStrike, Parliament], 
% [Dog, Zebra, Fox, Snail, Horse], 
% [Juice, Water, Tea, Coffee, Milk])

/*
% reference: http://bennycheung.github.io/solving-puzzles-using-clp
The list of facts (or constraints):

There are 5 colored houses in a row, each having an owner, which has an animal, a favorite cigarette, a favorite drink.
1. The English lives in the red house.
2. The Spanish has a dog.
3. They drink coffee in the green house.
4. The Ukrainian drinks tea.
5. The green house is next to the white house.
6. The Winston smoker has a serpent.
7. In the yellow house they smoke Kool.
8. In the middle house they drink milk.
9. The Norwegian lives in the first house from the left.
10. The Chesterfield smoker lives near the man with the fox.
11. In the house near the house with the horse they smoke Kool.
12. The Lucky Strike smoker drinks juice.
13. The Japanese smokes Kent.
14. The Norwegian lives near the blue house.


Answer from wikipedia: 
Norwegian Drinks water and the Japanese owns the zebra
*/
:- use_module(library(clpfd)).

zebraPuzzle(Men,Color,Cigarette,Animal,Drink) :-
    
    % create the Domain
    Men ins 1..5, 
    Color ins 1..5, 
    Cigarette ins 1..5, 
    Animal ins 1..5, 
    Drink ins 1..5,

    % make sure everything is different
    all_different(Men), 
    all_different(Color), 
    all_different(Cigarette), 
    all_different(Animal), 
    all_different(Drink),

    % create list
    Men = [Men1,Men2,Men3,Men4,Men5], 
    Color = [Color1,Color2,Color3,Color4,Color5], 
    Cigarette = [Cigarette1,Cigarette2,Cigarette3,Cigarette4,Cigarette5], 
    Animal = [Animal1,Animal2,Animal3,Animal4,Animal5], 
    Drink = [Drink1,Drink2,Drink3,Drink4,Drink5],

    % now just hard code the rules
    % rules 1 - 5
    Men1 #= Color2, 
    Men2 #= Animal1, 
    Men3 #= Cigarette1, 
    Men4 #= Drink3, 
    Men5 #= 1,

    % rules 6 - 10
    Color1 #= Drink4, 
    Color1 #= Color5 + 1, 
    Cigarette5 #= Animal4, 
    Cigarette2 #= Color3, 
    Drink5 #= 3,

    % rules 11 - 14
    Men5 #= Color4 + 1 #\/ Men5 #= Color4 - 1, 
    Cigarette3 #= Drink1,
    Animal3 #= Cigarette4 + 1 #\/ Animal3 #= Cigarette4 - 1,
    Animal5 #= Cigarette2 + 1 #\/ Animal5 #= Cigarette2 - 1,

    % First fail (ff). Label the leftmost variable with smallest domain next, in order to detect infeasibility early. This is often a good strategy.
    % from swipl docs
    labeling([ff],Men), 
    labeling([ff],Color), 
    labeling([ff],Cigarette), 
    labeling([ff],Animal), 
    labeling([ff],Drink),

    % define structure lives
    H = [
        lives(englishman,Men1), 
        lives(spaniard,Men2), 
        lives(japanese,Men3), 
        lives(italian,Men4), 
        lives(norwegian,Men5)
        ],
    
    member(lives(Owner1,Animal2), H), write('Who owns the Zebra: '), write(Owner1), nl,
    member(lives(Owner2,Drink2), H), write('Who Drinks water: '), write(Owner2), nl.