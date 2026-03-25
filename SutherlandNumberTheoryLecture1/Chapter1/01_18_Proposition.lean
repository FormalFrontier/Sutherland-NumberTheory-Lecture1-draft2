import Mathlib.Tactic.Recall
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

set_option autoImplicit true in
/-!
## Proposition 1.18 — Integral Elements are Closed Under + and ×

**Proposition 1.18.** Let `α, β ∈ B` be integral over `A ⊆ B`. Then `α + β` and `αβ`
are integral over `A`.

*Proof.* The proof constructs monic polynomials annihilating `α + β` and `αβ` using
resultants / symmetric functions of the roots of the minimal polynomials.

In Mathlib: `IsIntegral.add` and `IsIntegral.mul`.
-/

set_option autoImplicit true in
/-- **Proposition 1.18** (closure under +). The sum of integral elements is integral. -/
recall IsIntegral.add [CommRing R] [CommRing A] [Algebra R A]
    {x y : A} (hx : IsIntegral R x) (hy : IsIntegral R y) : IsIntegral R (x + y)

set_option autoImplicit true in
/-- **Proposition 1.18** (closure under ×). The product of integral elements is integral. -/
recall IsIntegral.mul [CommRing R] [CommRing A] [Algebra R A]
    {x y : A} (hx : IsIntegral R x) (hy : IsIntegral R y) : IsIntegral R (x * y)
