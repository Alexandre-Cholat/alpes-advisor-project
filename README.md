# Alpes Advisor: starter directory

- `project.qmd`: the project statement (Quarto; read it first).
- `data/small`, `data/medium`: the data (Prolog facts, ASP facts, CSV).
- `resolution/`: `kb.py` (provided) and the skeleton `resolution.py` to complete.
- `fol/`, `prolog/`, `asp/`, `notebook/`: starter files to complete.

Requirements: Python 3.10+, SWI-Prolog 9+, clingo (`pip install clingo`).

Quick check of your installation:

    swipl data/small/facts.pl prolog/rules.pl      # then ?- commune(C).
    clingo data/small/facts.lp asp/params.lp 0
    python resolution/kb.py data/small/facts.pl 10
