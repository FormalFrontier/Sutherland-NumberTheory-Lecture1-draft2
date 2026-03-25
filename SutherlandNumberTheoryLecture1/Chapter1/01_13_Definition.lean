import Mathlib.Tactic.Recall
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

/-!
## Definition 1.13 — Residue Fields

**Definition 1.13.** The *residue field* of a local ring `A` with maximal ideal `𝔪` is
the field `A/𝔪`.

### Mathlib correspondence

This is `IsLocalRing.ResidueField A`, defined as the quotient of `A` by its
maximal ideal. The projection map is `IsLocalRing.residue A : A →+* ResidueField A`.
-/

/-- **Definition 1.13.** The *residue field* of a local ring is the quotient `A / 𝔪`. -/
recall IsLocalRing.ResidueField (A : Type*) [CommRing A] [IsLocalRing A] : Type _
