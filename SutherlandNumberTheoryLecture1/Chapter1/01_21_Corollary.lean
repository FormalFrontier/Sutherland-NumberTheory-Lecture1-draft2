import SutherlandNumberTheoryLecture1.Chapter1.«01_19_Definition»
import SutherlandNumberTheoryLecture1.Chapter1.«01_20_Proposition»
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
## Corollary 1.21 — Integral Closure is Integrally Closed

**Corollary 1.21.** If `B/A` is a ring extension, the integral closure of `A` in `B`
is integrally closed in `B`.

*Proof.* Let `A'` be the integral closure of `A` in `B`, and `A''` the integral closure
of `A'` in `B`. By Proposition 1.20, `A''` is integral over `A`, so `A'' ⊆ A'`.
Thus `A' = A''`.

In Mathlib: `integralClosure.isIntegralClosure`.
-/

/-- **Corollary 1.21** (Sutherland). The integral closure of `A` in `B` is integrally
closed in `B`. -/
theorem sutherland_corollary1_21 {A B : Type*} [CommRing A] [CommRing B] [Algebra A B] :
    IsIntegralClosure (integralClosure A B) A B :=
  integralClosure.isIntegralClosure A B
