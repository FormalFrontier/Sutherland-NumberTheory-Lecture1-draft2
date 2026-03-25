import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_17
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
## Proposition 1.18 — Integral Elements are Closed Under + and ×

**Proposition 1.18.** Let `α, β ∈ B` be integral over `A ⊆ B`. Then `α + β` and `αβ`
are integral over `A`.

*Proof.* Using the fact that roots of monic polynomials `f(α) = 0` and `g(β) = 0`
can be used to construct monic polynomials annihilating `α + β` and `αβ` via
resultants/symmetric functions.

In Mathlib: `IsIntegral.add` and `IsIntegral.mul`.
-/

/-- **Proposition 1.18** (Sutherland). The sum of two integral elements is integral. -/
theorem sutherland_prop1_18_add {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]
    {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α + β) :=
  hα.add hβ

/-- **Proposition 1.18** (Sutherland). The product of two integral elements is integral. -/
theorem sutherland_prop1_18_mul {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]
    {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α * β) :=
  hα.mul hβ
