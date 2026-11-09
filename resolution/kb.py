#!/usr/bin/env python3
"""kb.py: extract of n entities + propositional instantiation (provided to the students).

  python kb.py ../../data/small/facts.pl 8            # writes extract_8.txt
Output format: one clause per line, literals separated by spaces, '-' = negation.
Atoms: LocatedIn(x,y).  Lines starting with '#' are comments.
Axioms instantiated (on the entities of the extract, DISTINCT constants):
  T  transitivity: -LocatedIn(x,y) -LocatedIn(y,z) LocatedIn(x,z)         (n(n-1)(n-2) clauses)
  U  a commune lies in at most one department: -LocatedIn(c,d1) -LocatedIn(c,d2)   (d1 < d2)
  F  facts: LocatedIn(x,y) for each fact located_in(x,y) of the extract
"""
import re, sys
from itertools import permutations, combinations
from collections import defaultdict


def read_facts(path):
    t = open(path, encoding="utf-8").read()
    typ, located_in = {}, set()
    for kind in ("commune", "department", "region", "summit", "resort"):
        for x in re.findall(rf"^{kind}\((\w+)\)\.", t, re.M):
            typ[x] = kind
    for a, b in re.findall(r"^located_in\((\w+),\s*(\w+)\)\.", t, re.M):
        located_in.add((a, b))
    return typ, located_in


def extract(typ, located_in, n):
    par = defaultdict(set)
    for a, b in located_in:
        par[a].add(b)
    comm = lambda s: {c for c in par[s] if typ.get(c) == "commune"}
    dep = lambda c: {d for d in par[c] if typ.get(d) == "department"}
    reg = lambda d: {r for r in par[d] if typ.get(r) == "region"}
    summits = [s for s in typ if typ[s] == "summit" and comm(s)]
    score = lambda s: (len({d for c in comm(s) for d in dep(c)}), len(comm(s)), s)
    seed = max(summits, key=score)
    E = [seed]
    def add(x):
        if x not in E: E.append(x)
    for c in sorted(comm(seed)): add(c)
    for c in sorted(comm(seed)):
        for d in sorted(dep(c)): add(d)
    for c in sorted(comm(seed)):
        for d in dep(c):
            for r in sorted(reg(d)): add(r)
    core = len(E)
    if n < core:
        sys.exit(f"n too small: the core of the extract already contains {core} entities")
    # filling: a commune without department (the "not derivable" case), then resorts / summits / neighbouring communes
    orphelines = sorted(c for c in typ if typ[c] == "commune" and not dep(c))
    reste = orphelines + sorted(x for x in typ if typ[x] in ("resort", "summit") and comm(x) & set(E)) \
            + sorted(c for c in typ if typ[c] == "commune" and dep(c) & set(E))
    for x in reste:
        if len(E) < n: add(x)
    return seed, E, core


def clauses(typ, located_in, E):
    S = set(E)
    C = []
    for x, y in sorted(located_in):
        if x in S and y in S:
            C.append((f"F", [f"LocatedIn({x},{y})"]))
    for x, y, z in permutations(E, 3):
        C.append(("T", [f"-LocatedIn({x},{y})", f"-LocatedIn({y},{z})", f"LocatedIn({x},{z})"]))
    comm = [x for x in E if typ[x] == "commune"]
    deps = [x for x in E if typ[x] == "department"]
    for c in comm:
        for d1, d2 in combinations(deps, 2):
            C.append(("U", [f"-LocatedIn({c},{d1})", f"-LocatedIn({c},{d2})"]))
    return C


if __name__ == "__main__":
    typ, located_in = read_facts(sys.argv[1]); n = int(sys.argv[2])
    seed, E, core = extract(typ, located_in, n)
    C = clauses(typ, located_in, E)
    out = f"extract_{n}.txt"
    with open(out, "w", encoding="utf-8") as f:
        f.write(f"# entities ({len(E)}): {' '.join(E)}\n# start summit: {seed}\n")
        for k, c in C: f.write(" ".join(c) + f"   # {k}\n")
    print(f"{out}: {len(E)} entities, {len(C)} clauses ({sum(k=='F' for k,_ in C)} facts, "
          f"{sum(k=='T' for k,_ in C)} transitivity, {sum(k=='U' for k,_ in C)} uniqueness)")
