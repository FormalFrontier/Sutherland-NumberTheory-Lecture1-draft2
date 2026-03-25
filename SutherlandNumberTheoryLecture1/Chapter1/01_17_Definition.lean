import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
## Definition 1.17 — Integral Elements

**Definition 1.17.** Given a ring extension `A ⊆ B`, an element `b ∈ B` is *integral over `A`*
if it is a root of a monic polynomial in `A[x]`. The ring `B` is *integral over `A`*
if all its elements are.

In Mathlib:
- `IsIntegral A b` for `b : B` means `b` is integral over `A`
- `Algebra.IsIntegral A B` means every element of `B` is integral over `A`
-/

/-- An element `b` of a ring extension `B/A` is *integral over `A`*
(Sutherland Def 1.17) if it satisfies a monic polynomial over `A`.
In Mathlib: `IsIntegral A b`. -/
def IsIntegralOver {A B : Type*} [CommRing A] [CommRing B] [Algebra A B] (b : B) : Prop :=
  IsIntegral A b

/-- A ring extension `B/A` is an *integral extension* (Sutherland Def 1.17)
if every element of `B` is integral over `A`.
In Mathlib: `Algebra.IsIntegral A B`. -/
def IsIntegralExtension (A B : Type*) [CommRing A] [CommRing B] [Algebra A B] : Prop :=
  Algebra.IsIntegral A B
