# References for Corollary1_5

## Mathlib Coverage

**Status:** partial

The corollary (positive characteristic ⟹ all absolute values non-archimedean; finite field ⟹ only trivial absolute value) does not have a direct Mathlib theorem. Follows from Lemma1_4 + CharP facts. Needs to be formalized here.

### Relevant Declarations

- `CharP.cast_eq_zero_iff` (Mathlib.Algebra.CharP.Defs)
  Character of a ring; used to show n · 1 = 0 in positive characteristic.

## Gaps / Original Work Needed

- The statement: every absolute value on a field of positive characteristic is non-archimedean
- The statement: the only absolute value on a finite field is the trivial one

## External Sources

- **Neukirch, Algebraic Number Theory, Chapter II §1, Remark after Def 1.1**
  Standard result: in characteristic p, n·1 = 0 for some n ≥ 1, so |n| = 0. Then Lemma1_4 applies.
