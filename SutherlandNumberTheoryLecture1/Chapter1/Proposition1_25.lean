import SutherlandNumberTheoryLecture1.Chapter1.Definition1_11
import SutherlandNumberTheoryLecture1.Chapter1.Definition1_19
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.PrincipalIdealDomain
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed

/-!
## Proposition 1.25 — Valuation Rings are Integrally Closed

**Proposition 1.25.** Every valuation ring is integrally closed.

*Proof.* Let `A` be a valuation ring, `α ∈ Frac(A)` integral over `A`.
If `α ∉ A`, then `α⁻¹ ∈ A`. Multiplying `αⁿ + ... + a₀ = 0` by `α^{-(n-1)}`
gives `α ∈ A`, contradiction.

In Mathlib: Every valuation ring is a Bézout domain (`IsBezout`), and every Bézout
domain is a GCD domain (`GCDMonoid`), and every GCD domain is integrally closed
(`GCDMonoid.toIsIntegrallyClosed`).
-/

/-- **Proposition 1.25** (Sutherland). Every valuation ring is integrally closed. -/
theorem sutherland_prop1_25 (A : Type*) [CommRing A] [IsDomain A] [ValuationRing A] :
    IsIntegrallyClosed A := by
  -- ValuationRing → IsBezout → GCDMonoid (noncanonical) → IsIntegrallyClosed
  haveI : GCDMonoid A := Classical.choice inferInstance
  exact GCDMonoid.toIsIntegrallyClosed
