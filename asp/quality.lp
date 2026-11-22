% Detection of inconsistencies: inconsistency(two_altitudes,S), inconsistency(commune_without_department,C),
% inconsistency(asymmetric_neighbour,A,B), inconsistency(summit_without_massif,S).

% WARNING: there are two inconsistency predicates, use the two "show" directives
% #show inconsistency\2
% #show inconsistency\3

entity_with_alt(S) :- summit(S).
entity_with_alt(S) :- resort(S).

inconsistency(two_altitudes, S) :-
    entity_with_alt(S), altitude(S, A1), altitude(S, A2), A1 < A2.

commune_has_department(C) :-
    commune(C), department(D), located_in(C, D).

inconsistency(commune_without_department, C) :-
    commune(C), not commune_has_department(C).

inconsistency(asymmetric_neighbour, A, B) :-
    commune(A), commune(B), neighbour(A, B), not neighbour(B, A).

summit_has_massif(S) :-
    summit(S), in_massif(S, M), massif(M).

inconsistency(summit_without_massif, S) :-
    summit(S), not summit_has_massif(S).

#show inconsistency/2.
#show inconsistency/3.