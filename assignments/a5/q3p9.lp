saxophone(sm6). 
part(spring). part(high_D_key).

has(jake,sm6). has(mo,sm6).
broken(mo,spring).

is_part(high_D_key,sm6).
is_part(spring,high_D_key).

-is_part(Sub,Super) :- part(Sub),
    part(Super); saxophone(Super),
    not is_part(Sub,Super).

is_part(Sub,Super) :- Sub != Super, 
    is_part(Sub2,Super),
    is_part(Sub,Sub2).

-works(Person,Sxp) :-
    saxophone(Sxp), has(Person,Sxp),
    not works(Person,Sxp).

works(Person,Sxp) :-
    saxophone(Sxp), has(Person,Sxp),
    is_part(spring,Sxp),
    -broken(Person,spring).

-broken(Person,spring) :- 
    has(Person,Sxp), saxophone(Sxp),
    owns(Person,spring),
    not broken(Person,spring).

owns(Person,Part) :- has(Person,Sxp), 
    saxophone(Sxp),is_part(Part,Sxp),
    not -is_part(Part,Sxp).