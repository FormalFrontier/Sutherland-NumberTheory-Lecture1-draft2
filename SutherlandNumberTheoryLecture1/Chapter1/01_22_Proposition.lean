import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
## Proposition 1.22 — ℤ is Integrally Closed

**Proposition 1.22.** The ring `ℤ` is integrally closed.

*Proof.* Use the rational root test: if `r/s ∈ ℚ` (with `gcd(r,s) = 1`) satisfies a
monic polynomial over `ℤ`, clearing denominators shows `s | rⁿ`, so `s = ±1`.

In Mathlib this follows automatically: `ℤ` is a UFD, every UFD is a GCD monoid,
and every GCD monoid is integrally closed.
-/

/-- **Proposition 1.22.** `ℤ` is integrally closed. -/
example : IsIntegrallyClosed ℤ := inferInstance
