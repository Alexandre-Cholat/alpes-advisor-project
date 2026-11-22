:- encoding(utf8).
:- use_module(library(aggregate)).
% Alpes Advisor, Part 3. Predicate names and arities are REQUIRED (see the statement).
% Loading:  swipl data/small/facts.pl prolog/rules.pl

% threshold(1500).

% inside/2, adjacent/2, resort_massif/2
inside(X,Y) :- located_in(Y,X).
inside(X,Y) :- located_in(X, Z), inside(Z, Y).

adjacent(X, Y) :- neighbour(Y, X).
adjacent(X, Y) :- neighbour(X, Y).

% TODO: ask if each resort should have one massif? currently we use distinct(M, resort_massif(flaine, M)). to get distinct answers.
% Massif of a resort, derived from the summits of its commune
resort_massif(R, M) :- commune(C), resort(R), located_in(R, C), summit(S), located_in(S, C), in_massif(S, M), massif(M).


% summits_in_department/2: Sorted list, without duplicates, of the summits lying (via inside) in department D. Use built-in predicate setof/3
summits_in_department(D, L) :- department(D), setof(S, (summit(S), inside(S, D)), L).

% high_resorts/2 : Resorts having a known altitude greater than or equal to Threshold
high_resorts(Threshold, L) :- setof(resort(R), (altitude(R, A), A > Threshold) , L).


% commune_with_resort/1, commune_without_resort_near_resort/1
% highest_summit/3
% reaches/3, communes_within/3
% reachable_naive/2, reachable/2   (hint: :- table reachable/2.)
% snowy/1, not_snowy/1
% resort_without_altitude/1, summit_without_massif/1
% two_altitudes/1, asymmetric_neighbour/2, commune_without_department/1
