import Mathlib.Tactic.Recall
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
## Definition 1.19 — Integral Closure and Integrally Closed Rings

**Definition 1.19.** Given a ring extension `B/A`, the *integral closure of `A` in `B`*
is `Ã = {b ∈ B | b is integral over A}`.
When `Ã = A`, we say `A` is *integrally closed in `B`*.
For a domain `A`, its *integral closure* is its integral closure in `Frac(A)`,
and `A` is *integrally closed* (or *normal*) if it equals its integral closure in `Frac(A)`.

### Mathlib correspondence

- `integralClosure A B` — the subalgebra of elements of `B` integral over `A`
- `IsIntegrallyClosed A` — abbreviation for `IsIntegrallyClosedIn A (FractionRing A)`
-/

/-- **Definition 1.19.** The *integral closure* of `R` in `A` is the subalgebra of
elements satisfying a monic polynomial over `R`. -/
recall integralClosure (R A : Type*) [CommRing R] [CommRing A] [Algebra R A] :
    Subalgebra R A

/-- **Definition 1.19.** A domain is *integrally closed* (or *normal*) if every element
of its fraction field that is integral over it already belongs to it. -/
recall IsIntegrallyClosed (R : Type*) [CommRing R] : Prop
