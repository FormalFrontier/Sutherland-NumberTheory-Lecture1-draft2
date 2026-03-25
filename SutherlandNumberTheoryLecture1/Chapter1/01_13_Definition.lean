import SutherlandNumberTheoryLecture1.Chapter1.«01_12_Definition»
import Mathlib.RingTheory.LocalRing.ResidueField.Basic

/-!
## Definition 1.13 — Residue Fields

**Definition 1.13.** The *residue field* of a local ring `A` with maximal ideal `𝔪` is
the field `A/𝔪`.

In Mathlib: `IsLocalRing.ResidueField A` (or `LocalRing.ResidueField A`).
-/

/-- The *residue field* of a local ring `A` (Sutherland Def 1.13)
is `A / 𝔪` where `𝔪` is the unique maximal ideal.
In Mathlib: `IsLocalRing.ResidueField A`. -/
abbrev ResidueField' (A : Type*) [CommRing A] [IsLocalRing A] :=
  IsLocalRing.ResidueField A
