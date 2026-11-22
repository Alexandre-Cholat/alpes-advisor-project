# Notebook (one page)

Pair: …   Instance: small

## Numerical answers
| Question | Answer |
|---|---|
| Q1.1 / Q1.2 | |
| Q2.1 – Q2.2 | **Q2.1:** **(E2)** (3 clauses, Skolem $f(m)$): $\{\neg\text{Massif}(m), \text{Summit}(f(m))\}$, $\{\neg\text{Massif}(m), \text{InMassif}(f(m),m)\}$, $\{\neg\text{Massif}(m), \text{High}(f(m))\}$. **Axiom (c)** (1 clause, no $\exists$): $\{\neg\text{Commune}(c), \neg\text{Department}(d_1), \neg\text{Department}(d_2), \neg\text{LocatedIn}(c,d_1), \neg\text{LocatedIn}(c,d_2), d_1=d_2\}$.<br>**Q2.2:** **(1)** Unifiable, $\text{MGU } \sigma = \{x \mapsto h(a), z \mapsto a\}$, unified: $\text{Neighbour}(h(a), g(a))$. **(2)** Not unifiable (occurs check fails on $y = g(y)$). |
| Q2.3 (resolvent measurements) | **Provable** `LocatedIn(aiguille_croche, auvergne_rhone_alpes)`: $n=10$ (736 cl.): naive `462`, sos `273`, unit `73` ($\square$); $n=12$ (1,338 cl.): naive `534`, sos `379`, unit `81` ($\square$); $n=14$ (2,204 cl.): naive `606`, sos `501`, unit `89` ($\square$).<br>**False (`refute`)** `LocatedIn(hauteluce, haute_savoie)`: $n=10$: `3 / 18 / 3` ($\square$); $n=12$: `3 / 22 / 3` ($\square$); $n=14$: `3 / 26 / 3` ($\square$).<br>**Not provable** `LocatedIn(les_houches, savoie)`: $n=10$: naive/sos `100,000` (cap), unit `806` (sat.); $n=12$: `100,000 / 100,000 / 1,284`; $n=14$: `100,000 / 100,000 / 1,802`. |
| Q2.4 – Q2.5 | **Q2.4:** **Unit** is most efficient (Horn KB $\implies$ refutation-complete; avoids non-unit blow-up; SOS beats Naive on multi-step proofs). On unprovable goals, Naive/SOS generate non-unit clauses until the `100,000` cap, whereas Unit saturates cleanly.<br>**Q2.5:** $C(n) = f + n(n-1)(n-2) + n_c\binom{n_d}{2} = \Theta(n^3)$. **Small** ($n=28$): **`19,696`** clauses ($29,800$ incl. massifs); **Medium** ($n=501$): **`125,000,112`** clauses ($140,608,092$ incl. massifs). Eager grounding does not scale $\implies$ first-order unification is needed. |
| Q3.1 | `summits_in_department(D, L)`: `haute_savoie` = `[aiguille_croche, arete_de_tricot, montagne_d_anterne, tete_de_la_cicle]` (4), `savoie` = `[chard_du_beurre, montagne_d_outray]` (2). `high_resorts(1500, L)` = `[flaine, les_saisies]` (2). `high_resorts(2000, L)` = `false` (0). |
| Q3.2 (findall / setof / count) | `commune_without_resort_near_resort(C)`: `findall` = **32**, `aggregate_all(count, ...)` = **32**, `setof` = **8** (`[combloux, demi_quartier, domancy, la_giettaz, les_contamines_montjoie, les_houches, megeve, sallanches]`). **Why:** `findall` and `aggregate_all(count, ...)` count duplicate derivation paths (once per adjacent resort commune), while `setof` sorts and deduplicates. When there is no solution, `setof` fails (`false`), whereas `findall` returns `[]`. **`highest_summit`:** `highest_summit(megeve, aiguille_croche, 2487)` using `aggregate_all(max(Alt, Sum), ..., max(A, S))`; fails (`false`) if the commune has no summit with a known altitude (e.g., `combloux`). |
| Q3.3 | `communes_within(sallanches, N, L)`: **1 step = 5**, **2 steps = 11**, **3 steps = 12**. **`reachable_naive/2`** does **not** terminate (stack overflow) because `adjacent/2` is symmetric, creating infinite 2-cycles (`A -> B -> A`). **`reachable/2` (tabled)** memoizes subgoals and detects loops to compute the full closure (12 communes), while **`reaches/3` (bounded)** terminates via depth bound `N` and visited list `L`. |
| Q3.4 (not snowy resorts, resorts without altitude) | `not_snowy/1`: **3** (`[domaine_de_praz_sur_arly, plaine_joux, saint_nicolas_de_veroce]`). `resort_without_altitude/1`: **2** (`[domaine_de_praz_sur_arly, saint_nicolas_de_veroce]`). Adding an altitude $\ge 1500$ for an unknown-altitude resort flips `not_snowy(R)` from `true` to `false`, illustrating **non-monotonic reasoning** under Negation as Failure (NAF) and the Closed-World Assumption (CWA). |
| Q3.5 | `two_altitudes/1` = `[]`; `asymmetric_neighbour/2` = `[combloux-sallanches]`; `commune_without_department/1` = `[les_houches]`; `summit_without_massif/1` = `[]`. **Why “belongs to no massif” is debatable:** Prolog uses the **Closed-World Assumption (CWA)** (unprovable `in_massif(S, _)` is treated as false), whereas in reality (**Open-World**) every summit belongs to a massif and the link is simply missing from the KB. |
| Q4.1 (k = 2 and 3: value, number of stays) | |
| Q4.2 | |
| Q4.3 – Q4.4 (medium: without "distinct communes"; k = 3, time, stays) | |
| Q4.5 (brave / cautious, with an exception) | |
| Q4.6 | |

## Comparison
| | Propositional resolution | Prolog | ASP |
|---|---|---|---|
| Expressiveness | Ground clauses only (no variables; requires $\Theta(n^3)$ eager grounding) | | |
| Missing information | Open-World Assumption (unprovable = unknown, not false) | | |
| Termination | Hits cap on unprovable goals (Naive/SOS); Unit saturates on Horn KBs | | |
| Explainability | Refutation proof tree of resolution steps deriving $\square$ | | |

## First-order axioms (list or diagram)
