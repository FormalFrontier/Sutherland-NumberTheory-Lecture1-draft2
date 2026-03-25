import Mathlib.RingTheory.LocalRing.Basic

/-!
## Definition 1.12 — Local Rings

**Definition 1.12.** A *local ring* is a commutative ring with a unique maximal ideal.

In Mathlib: `IsLocalRing` (previously `LocalRing`).
-/

/-- A *local ring* (Sutherland Def 1.12) is a commutative ring with a unique maximal ideal.
In Mathlib: `IsLocalRing`. -/
def IsLocalRing' (A : Type*) [CommRing A] : Prop :=
  IsLocalRing A
