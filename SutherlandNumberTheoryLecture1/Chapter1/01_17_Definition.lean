import Mathlib.Tactic.Recall
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Defs
import Mathlib.RingTheory.IntegralClosure.Algebra.Defs

/-!
## Definition 1.17 — Integral Elements

**Definition 1.17.** Given a ring extension `A ⊆ B`, an element `b ∈ B` is *integral over `A`*
if it is a root of a monic polynomial in `A[x]`. The ring `B` is *integral over `A`*
if all its elements are.

### Mathlib correspondence

- `IsIntegral A b` — `b : B` satisfies a monic polynomial over `A`
- `Algebra.IsIntegral A B` — every element of `B` is integral over `A`
-/

/-- **Definition 1.17.** An element `x : A` is *integral* over `R` if it is a root of
some monic polynomial `p : R[X]`. -/
recall IsIntegral (R : Type*) {A : Type*} [CommRing R] [Ring A] [Algebra R A] (x : A) : Prop

/-- **Definition 1.17.** An algebra `A` over `R` is an *integral extension* if every
element of `A` is integral over `R`. -/
recall Algebra.IsIntegral (R A : Type*) [CommRing R] [Ring A] [Algebra R A] : Prop
