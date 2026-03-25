# References for Definition1_11

## Mathlib Coverage

**Status:** full

ValuationRing matches the lecture definition (A is a valuation ring iff for all x ∈ K, x ∈ A or x⁻¹ ∈ A).

### Relevant Declarations

- `ValuationRing` (Mathlib.RingTheory.Valuation.ValuationRing)
  Class: integral domain where for any pair of elements, one divides the other (equivalently: for all x in FracField, x ∈ A or x⁻¹ ∈ A).

- `PreValuationRing` (Mathlib.RingTheory.Valuation.ValuationRing)
  Weaker version without domain assumption.
