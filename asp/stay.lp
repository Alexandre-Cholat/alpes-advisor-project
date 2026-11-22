% Stay: k steps (resorts), distinct massifs, distinct communes, #maximize.
% Atoms: step(S,M); only stay(S) is displayed (#project, #show).

resort_massif(R, M) :-
    resort(R), commune(C), located_in(R, C),
    summit(Sum), located_in(Sum, C), in_massif(Sum, M), massif(M).

has_summit_altitude(C) :-
    commune(C), summit(Sum), located_in(Sum, C), altitude(Sum, _).

highest_summit(C, A) :-
    has_summit_altitude(C),
    A = #max { V : summit(Sum), located_in(Sum, C), altitude(Sum, V) }.

k { stay(S) : resort(S) } k.

1 { step(S, M) : resort_massif(S, M) } 1 :- stay(S).

:- step(S1, M), step(S2, M), S1 != S2.

:- stay(S1), stay(S2), located_in(S1, C), located_in(S2, C), commune(C), S1 != S2.

step_altitude(S, A) :-
    stay(S),
    A = #max { V : located_in(S, C), highest_summit(C, V) }.

:- stay(S), not step_altitude(S, _).
:- stay(S), step_altitude(S, #inf).

#maximize { A, S : step_altitude(S, A) }.

#project stay/1.
#show stay/1.