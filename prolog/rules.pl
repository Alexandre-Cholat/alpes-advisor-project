:- encoding(utf8).
:- use_module(library(aggregate)).
% Alpes Advisor, Part 3. Predicate names and arities are REQUIRED (see the statement).
% Loading:  swipl data/small/facts.pl prolog/rules.pl

threshold(1500).

% inside/2, adjacent/2, resort_massif/2
inside(X,Y) :- located_in(X,Y).
inside(X,Y) :- located_in(X, Z), inside(Z, Y).

adjacent(X, Y) :- neighbour(Y, X).
adjacent(X, Y) :- neighbour(X, Y).

% TODO: ask if each resort should have one massif? currently we use distinct(M, resort_massif(flaine, M)). to get distinct answers.
% Massif of a resort, derived from the summits of its commune
resort_massif(R, M) :- commune(C), resort(R), located_in(R, C), summit(S), located_in(S, C), in_massif(S, M), massif(M).


% summits_in_department/2: Sorted list, without duplicates, of the summits lying (via inside) in department D. Use built-in predicate setof/3
summits_in_department(D, L) :- department(D), setof(S, (summit(S), inside(S, D)), L).

% high_resorts/2 : Resorts having a known altitude greater than or equal to Threshold
% wrong: .high_resorts(Threshold, L) :- setof(resort(R), A^(altitude(R, A), A >= Threshold) , L).
high_resorts(Threshold, L) :- setof(R, A^(resort(R), altitude(R, A), A >= Threshold), L).


% commune_with_resort/1, commune_without_resort_near_resort/1
commune_with_resort(C) :- commune(C), located_in(R, C), resort(R).
commune_without_resort_near_resort(C) :- commune(C),commune(B), adjacent(C, B), not(commune_with_resort(C)), commune_with_resort(B).

% highest_summit/3 : Highest summit S (altitude A) of commune C
highest_summit(C, S, A):- summit(S), altitude(S, A), located_in(S, C), not((summit(S3), located_in(S3, C), altitude(S3, A3), A3 > A)).

% reaches/3, communes_within/3: Set of communes at most N steps away from A (bounded recursion). reaches(A, B, N): B is at most N steps away from A.
% initalize with empty list
reaches(A, B, N):- reaches(A, B, N, []).
% base case
reaches(A, B, N, _):- adjacent(A, B), N > 0.
% list L of prev visited communes. check against L before testing adjacency
% add A to start of L when trying C instead.
reaches(A, B, N, L):- N > 1, commune(C), not(member(C, L)), adjacent(A, C), N1 is N - 1, reaches(C, B, N1, [A|L]).

communes_within(A, N, L):- setof(C, reaches(A, C, N), L).

% reachable_naive/2 : will loop infinately ...
reachable_naive(X, Y) :- adjacent(X, Y).
reachable_naive(X, Y) :- adjacent(X, Z), reachable_naive(Z, Y).

% reachable/2
reachable(X, Y):- reachable(X, Y, []).
reachable(X, Y, _):- adjacent(X, Y).
reachable(X, Y, L):- adjacent(X, Z), not(member(Z, L)), reachable(Z, Y, [X|L]).

% snowy/1, not_snowy/1
snowy(R):- resort(R), altitude(R, A), threshold(X), A >= X.
not_snowy(R):- resort(R), not(snowy(R)).

% resort_without_altitude/1, summit_without_massif/1
resort_without_altitude(R):- resort(R), not(altitude(R, _)).
summit_without_massif(S):- summit(S), not(in_massif(S, _)).

% two_altitudes/1, asymmetric_neighbour/2, commune_without_department/1
two_altitudes(R):- resort(R), altitude(R, A1), altitude(R, A2), A1 \= A2.
asymmetric_neighbour(X, Y):- neighbour(X, Y), not(neighbour(Y, X)).
commune_without_department(C):- commune(C), not(inside(C, _)).
