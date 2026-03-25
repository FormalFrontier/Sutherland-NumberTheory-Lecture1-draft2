import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
## Corollary 1.21 — Integral Closure is Integrally Closed

**Corollary 1.21.** If `B/A` is a ring extension, the integral closure of `A` in `B`
is integrally closed in `B`.

*Proof.* Let `A'` be the integral closure of `A` in `B`, and `A''` the integral closure
of `A'` in `B`. By Proposition 1.20, `A''` is integral over `A`, so `A'' ⊆ A'`.
Thus `A' = A''`.

In Mathlib: `IsIntegrallyClosedIn` applied to `integralClosure A B`.
-/

/-- **Corollary 1.21.** The integral closure of `A` in `B` is integrally closed in `B`. -/
example (A B : Type*) [CommRing A] [CommRing B] [Algebra A B] :
    IsIntegrallyClosedIn (integralClosure A B) B :=
  inferInstance
