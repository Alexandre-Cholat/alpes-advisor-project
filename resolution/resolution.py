#!/usr/bin/env python3
"""Skeleton: propositional resolution prover.

Usage: python resolution/resolution.py extract_10.txt prove "LocatedIn(mont_charvin_q3321741,auvergne_rhone_alpes)" sos
       python resolution/resolution.py extract_10.txt refute "LocatedIn(manigod,savoie)" unit
Modes:      prove X  -> the clause -X is added (refutation)   |   refute X -> the clause X is added
Strategies to implement: naive | sos | unit
A clause is a frozenset of integers (atom i > 0, negative literal = -i). The empty clause is frozenset().
"""
import sys, time
import heapq

def load(path):
    """PROVIDED: reads the clause file. Returns (list of clauses, dict atom -> integer)."""
    atoms, kb = {}, []
    for line in open(path, encoding="utf-8"):
        if line.startswith("#"):
            continue
        c = set()
        for l in line.split("#")[0].split():
            i = atoms.setdefault(l.lstrip("-"), len(atoms) + 1)
            c.add(-i if l.startswith("-") else i)
        kb.append(frozenset(c))
    return kb, atoms


def resolve(c1, c2):
    """TODO: return the list of resolvents of c1 and c2 (frozensets).
    One resolvent for each literal l of c1 whose opposite -l is in c2. Discard tautologies."""
    resolvents = []
    for literal in c1:
        if -literal not in c2:
            continue
        resolvent = (c1 - {literal}) | (c2 - {-literal})
        if any(-value in resolvent for value in resolvent):
            continue
        resolvent = frozenset(resolvent)
        if resolvent not in resolvents:
            resolvents.append(resolvent)
    return resolvents

def prove(kb, goal, strategy, cap=100_000):
    """TODO: resolution loop. goal = the clause to refute or the negation of clause to prove.
    Returns (found: bool, number of resolvents generated: int).
    Hint: keep a set of clauses already seen (avoid duplicates), pick a "given" clause at each
    round, resolve it with the clauses already processed according to the strategy, and stop on
    the empty clause, on saturation, or when cap is exceeded."""
    strategy = strategy.lower().strip()
    if strategy not in {"naive", "sos", "unit"}:
        raise ValueError(f"Unknown strategy: {strategy}")

    seen = set()
    processed = []
    unprocessed = []
    counter = 0

    def push(clause):
        nonlocal counter
        heapq.heappush(unprocessed, (len(clause), counter, clause))
        counter += 1

    if strategy == "sos":
        for c in kb:
            if c == frozenset():
                return True, 0
            if c not in seen:
                seen.add(c)
                processed.append(c)
        for c in goal:
            if c == frozenset():
                return True, 0
            if c not in seen:
                seen.add(c)
                push(c)
    else:
        for c in list(kb) + list(goal):
            if c == frozenset():
                return True, 0
            if c not in seen:
                seen.add(c)
                push(c)

    gen = 0
    while unprocessed:
        _, _, given = heapq.heappop(unprocessed)
        processed.append(given)
        for other in processed:
            if strategy == "unit" and len(given) != 1 and len(other) != 1:
                continue
            for res in resolve(given, other):
                gen += 1
                if res == frozenset():
                    return True, gen
                if res not in seen:
                    seen.add(res)
                    push(res)
                if gen >= cap:
                    return False, gen

    return False, gen


if __name__ == "__main__":
    file, mode, atom, strat = sys.argv[1:5]
    kb, atoms = load(file)
    if (atom not in atoms) :
        sys.exit(f"The goal {atom} is not an atom of the provided KB")
    i = atoms[atom]
    goal = [frozenset([-i if mode == "prove" else i])]
    t0 = time.time()
    found, gen = prove(kb, goal, strat)
    print(f"{strat}: {'empty clause' if found else 'no contradiction'} | resolvents generated: {gen} | {time.time()-t0:.2f}s")
