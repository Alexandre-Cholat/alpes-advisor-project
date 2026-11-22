% Default rule: a resort is snowy if a known altitude reaches the threshold,
% unless there is a known exception (exception/1). Unknown altitude: snow is possible, never certain.
#defined exception/1. % avoids a warning if no exception is given

#defined exception/1.

known_altitude(R) :- resort(R), altitude(R, _).

snowy(R) :-
    resort(R), altitude(R, A), threshold(T), A >= T,
    not exception(R).

{ snowy(R) } :-
    resort(R), not known_altitude(R),
    not exception(R).

#show snowy/1.