import Mathlib.Tactic.Recall
import Mathlib.RingTheory.IntegralClosure.IsIntegralClosure.Basic

/-!
## Proposition 1.20 — Transitivity of Integrality

**Proposition 1.20.** If `C/B/A` is a tower of ring extensions in which `B` is integral
over `A` and `C` is integral over `B`, then `C` is integral over `A`.

In Mathlib: `Algebra.IsIntegral.trans`.
-/

variable {R : Type*} [CommRing R] {B : Type*} [CommRing B] [Algebra R B]

/-- **Proposition 1.20.** Integrality is transitive: if `B/A` and `C/B` are integral
extensions, then `C/A` is integral. -/
example (A : Type*) [CommRing A] [Algebra R A] [Algebra A B] [IsScalarTower R A B]
    [Algebra.IsIntegral R A] [Algebra.IsIntegral A B] : Algebra.IsIntegral R B :=
  Algebra.IsIntegral.trans A
