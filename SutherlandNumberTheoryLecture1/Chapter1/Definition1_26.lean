import SutherlandNumberTheoryLecture1.Chapter1.Definition1_19
import Mathlib.NumberTheory.NumberField.Basic

/-!
## Definition 1.26 — Number Fields and Rings of Integers

**Definition 1.26.** A *number field* `K` is a finite extension of `ℚ`.
The *ring of integers* `𝒪_K` is the integral closure of `ℤ` in `K`.

In Mathlib:
- `NumberField K` is the class asserting `K` is a number field (finite extension of `ℚ`)
- `RingOfIntegers K` (or `𝓞 K`) is the ring of integers of `K`
-/

/-- A *number field* (Sutherland Def 1.26) is a finite extension of `ℚ`.
In Mathlib: `NumberField K`. -/
def IsNumberField (K : Type*) [Field K] [Algebra ℚ K] : Prop :=
  NumberField K

/-- The *ring of integers* `𝒪_K` of a number field `K` (Sutherland Def 1.26)
is the integral closure of `ℤ` in `K`.
In Mathlib: `NumberField.RingOfIntegers K` (also written `𝓞 K`). -/
abbrev RingOfIntegers' (K : Type*) [Field K] [NumberField K] :=
  NumberField.RingOfIntegers K
