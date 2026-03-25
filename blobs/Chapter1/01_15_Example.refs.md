# References for 01_15_Example

## Mathlib Coverage

**Status:** partial

Basic constructions are in Mathlib. The specific valuation on k((t)) with value group ℤ and valuation ring k[[t]] can be assembled from these pieces.

### Relevant Declarations

- `PowerSeries` (Mathlib.RingTheory.PowerSeries.Basic)
  Formal power series ring k[[t]].

- `LaurentSeries` (Mathlib.RingTheory.LaurentSeries)
  Laurent series field k((t)) = fraction field of k[[t]].

- `PowerSeries.order` (Mathlib.RingTheory.PowerSeries.Order)
  Order of vanishing at 0 for a power series; gives the t-adic valuation.
