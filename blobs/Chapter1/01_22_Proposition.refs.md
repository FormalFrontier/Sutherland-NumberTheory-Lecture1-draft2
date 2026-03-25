# References for 01_22_Proposition

## Mathlib Coverage

**Status:** full

ℤ is a GCDMonoid in Mathlib, so IsIntegrallyClosed ℤ follows automatically. The lecture proves it directly using the rational root test.

### Relevant Declarations

- `GCDMonoid.toIsIntegrallyClosed` (Mathlib.Algebra.GCDMonoid.IntegrallyClosed)
  Every GCD monoid (in particular every UFD, and hence every PID, and hence ℤ) is integrally closed.

- `Int.instIsIntegrallyClosed` (Mathlib.Algebra.GCDMonoid.IntegrallyClosed)
  Instance: ℤ is integrally closed (derived from GCDMonoid).
