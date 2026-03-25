import SutherlandNumberTheoryLecture1.Chapter1.«01_19_Definition»
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
## Proposition 1.22 — ℤ is Integrally Closed

**Proposition 1.22.** The ring `ℤ` is integrally closed.

*Proof.* Use the rational root test: if `r/s ∈ ℚ` (with `gcd(r,s) = 1`) satisfies a
monic polynomial over `ℤ`, clearing denominators shows `s | rⁿ`, so `s = ±1`.

In Mathlib: `Int.instIsIntegrallyClosed`.
-/

/-- **Proposition 1.22** (Sutherland). `ℤ` is integrally closed. -/
theorem sutherland_prop1_22 : IsIntegrallyClosed ℤ :=
  inferInstance
