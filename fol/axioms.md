# Part 1: first-order logic

## 1. Axioms
- (a) Transitivity of LocatedIn:
    for all a, b, c: (LocatedIn(A,B) and LocatedIn(B,C) := LocatedIn(A,C))
- (b) Symmetry of Neighbour:
    for all a, b: (Neighbour(A,B) := Neighbour(B,A))
- (c) A commune lies in at most one department:
for all d, c1, c2 : (LocatedIn(c1, d) and LocatedIn(c2, d) ⟹ (c1 = c2))
- (d) Every summit lies in at least one commune:
for all s summit(s) ⟹ exists c (commune(c) and LocatedIn(s, c))


## 2. Formalisations
- (E1) Every commune lies in a department:
for all c commune(c) : = exists d( department(d) and LocatedIn(c, d))
- (E2) Every massif contains at least one summit higher than 2 400 m.:
- (E3) There is a commune without a resort that is a neighbour of a commune with a resort:
- (E4) No resort lies in a commune without a department.:


// do this at the end, optional?
## 3. Models of {transitivity, I, S}
(Show that every model is infinite; give an infinite model; does the instance satisfy S?)
