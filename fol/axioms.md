# Part 1: first-order logic

## 1. Axioms
- (a) Transitivity of LocatedIn:
  ∀x ∀y ∀z ((LocatedIn(x,y) ∧ LocatedIn(y,z)) -> LocatedIn(x,z))
- (b) Symmetry of Neighbour:
  ∀x ∀y (Neighbour(x,y) -> Neighbour(y,x))
- (c) A commune lies in at most one department:
  ∀c ∀d1 ∀d2 ((Commune(c) ∧ Department(d1) ∧ Department(d2) ∧ LocatedIn(c,d1) ∧ LocatedIn(c,d2)) -> d1=d2)
- (d) Every summit lies in at least one commune:
  ∀s (Summit(s) -> ∃c (Commune(c) ∧ LocatedIn(s,c)))

## 2. Formalisations
- (E1) Every commune lies in a department: 
  - ∀c (Commune(c) -> ∃d (Department(d) ∧ LocatedIn(c,d)))
- (E2) Every massif contains at least one summit higher than 2 400 m:
  - ∀m (Massif(m) -> ∃s (Summit(s) ∧ InMassif(s,m) ∧ High(s)))
- (E3) There is a commune without a resort that is a neighbour of a commune with a resort:
  - ∃c1 ∃c2 (Commune(c1) ∧ Commune(c2) ∧ ¬∃r1 (Resort(r1) ∧ LocatedIn(r1,c1)) ∧ ∃r2 (Resort(r2) ∧ LocatedIn(r2,c2)) ∧ Neighbour(c1,c2))
- (E4) No resort lies in a commune without a department: 
  - ¬∃r ∃c (Resort(r) ∧ Commune(c) ∧ LocatedIn(r,c) ∧ ¬∃d (Department(d) ∧ LocatedIn(c,d)))

// do this at the end, optional?
## 3. Models of {transitivity, I, S}
(Show that every model is infinite; give an infinite model; does the instance satisfy S?)

We have three axioms:
- (T) Transitivity: `∀x ∀y ∀z ((LocatedIn(x,y) ∧ LocatedIn(y,z)) -> LocatedIn(x,z))`
- (I): `∀x ¬LocatedIn(x,x)`
- (S): `∀x ∃y LocatedIn(x,y)`

Let M be an arbitrary model of {T, I, S}.
1. By definition of first-order semantics, the domain D is non-empty, so we can pick an element x_0 ∈ D. By (S), there exists x_1 ∈ D such that (x_0, x_1) ∈ LocatedIn. Applying (S) results in an infinite sequence x_0, x_1, x_2, ... ∈ D with (x_k, x_{k+1}) ∈ LocatedIn for every k ≥ 0.
2. All elements in the chain are distinct. For contradiction assume that x_i = x_j for some indices i < j. Repeatedly applying Transitivity (T) along the chain (x_i, x_{i+1}), ..., (x_{j-1}, x_j) implies (x_i, x_j) ∈ LocatedIn. Since x_i = x_j, we get (x_i, x_i) ∈ LocatedIn, which contradicts (I).

Therefore, x_i ≠ x_j for all i ≠ j, so D contains infinitely many distinct elements and must be infinite.

**Example of an infinite model**
Define the model M as follows:
- **Domain:** D = N = {0, 1, 2, ...}
- **Predicate LocatedIn:** LocatedIn = {(m, n) ∈ N² | m < n}
- **Constants & other predicates:** Map every constant symbol to 0 ∈ N and assign ∅ to all other predicates.

This structure satisfies all three axioms:
- **(T):** Strict order < on N is transitive (m < n ∧ n < k => m < k).
- **(I):** No natural number is strictly less than itself (n ≮ n).
- **(S):** Every n ∈ N has a successor y = n + 1 ∈ N with n < n + 1.

**Does the instance data satisfy (S)?**
**No.** When the small instance is read as an interpretation I, (S) is falsified for two reasons:
- **Concrete counterexample:** `region(auvergne_rhone_alpes)` is in the domain (for instance, `located_in(haute_savoie, auvergne_rhone_alpes)`), but there is no entity y such that `located_in(auvergne_rhone_alpes, y)` holds in the data, because regions sit at the top of the `located_in` hierarchy (likewise, massifs and communes missing a department have no outgoing `located_in` fact).
- **General reason:** The dataset has a **finite** number of entities and its `LocatedIn` relation has no cycles (nothing is located inside itself, directly or indirectly). By the theorem proven above, any finite acyclic relation must stop at one or more top-level elements that have no outgoing `LocatedIn` link, so `(S)` cannot hold.