# References for 01_10_Definition

## Mathlib Coverage

**Status:** full

Valuation and DVR are both fully covered in Mathlib.

### Relevant Declarations

- `Valuation` (Mathlib.RingTheory.Valuation.Basic)
  Structure for valuations: ring homomorphism k× → Γ₀ satisfying v(x+y) ≥ min(v(x),v(y)). Discrete valuations use Γ₀ = ℤ with WithTop.

- `IsDiscreteValuationRing` (Mathlib.RingTheory.DiscreteValuationRing.Basic)
  Class for DVRs: local PID that is not a field.

- `Valuation.integer` (Mathlib.RingTheory.Valuation.Basic)
  The valuation ring {x : k | v(x) ≥ 0} of a valuation v on a field k.
