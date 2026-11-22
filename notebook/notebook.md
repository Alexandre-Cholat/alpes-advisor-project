# Notebook (one page)

Pair: …   Instance: small

## Numerical answers
| Question | Answer |
|---|---|
| Q1.1 / Q1.2 | |
| Q2.1 – Q2.2 | **Q2.1:** **(E2)** (3 clauses, Skolem $f(m)$): $\{\neg\text{Massif}(m), \text{Summit}(f(m))\}$, $\{\neg\text{Massif}(m), \text{InMassif}(f(m),m)\}$, $\{\neg\text{Massif}(m), \text{High}(f(m))\}$. **Axiom (c)** (1 clause, no $\exists$): $\{\neg\text{Commune}(c), \neg\text{Department}(d_1), \neg\text{Department}(d_2), \neg\text{LocatedIn}(c,d_1), \neg\text{LocatedIn}(c,d_2), d_1=d_2\}$.<br>**Q2.2:** **(1)** Unifiable, $\text{MGU } \sigma = \{x \mapsto h(a), z \mapsto a\}$, unified: $\text{Neighbour}(h(a), g(a))$. **(2)** Not unifiable (occurs check fails on $y = g(y)$). |
| Q2.3 (resolvent measurements) | **Provable** `LocatedIn(aiguille_croche, auvergne_rhone_alpes)`: $n=10$ (736 cl.): naive `462`, sos `273`, unit `73` ($\square$); $n=12$ (1,338 cl.): naive `534`, sos `379`, unit `81` ($\square$); $n=14$ (2,204 cl.): naive `606`, sos `501`, unit `89` ($\square$).<br>**False (`refute`)** `LocatedIn(hauteluce, haute_savoie)`: $n=10$: `3 / 18 / 3` ($\square$); $n=12$: `3 / 22 / 3` ($\square$); $n=14$: `3 / 26 / 3` ($\square$).<br>**Not provable** `LocatedIn(les_houches, savoie)`: $n=10$: naive/sos `100,000` (cap), unit `806` (sat.); $n=12$: `100,000 / 100,000 / 1,284`; $n=14$: `100,000 / 100,000 / 1,802`. |
| Q2.4 – Q2.5 | **Q2.4:** **Unit** is most efficient (Horn KB $\implies$ refutation-complete; avoids non-unit blow-up; SOS beats Naive on multi-step proofs). On unprovable goals, Naive/SOS generate non-unit clauses until the `100,000` cap, whereas Unit saturates cleanly.<br>**Q2.5:** $C(n) = f + n(n-1)(n-2) + n_c\binom{n_d}{2} = \Theta(n^3)$. **Small** ($n=28$): **`19,696`** clauses ($29,800$ incl. massifs); **Medium** ($n=501$): **`125,000,112`** clauses ($140,608,092$ incl. massifs). Eager grounding does not scale $\implies$ first-order unification is needed. |
| Q3.1 | |
| Q3.2 (findall / setof / count) | |
| Q3.3 | |
| Q3.4 (not snowy resorts, resorts without altitude) | |
| Q3.5 | |
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
