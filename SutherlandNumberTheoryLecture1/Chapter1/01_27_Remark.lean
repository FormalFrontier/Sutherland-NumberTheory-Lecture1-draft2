import SutherlandNumberTheoryLecture1.Chapter1.«01_26_Definition»
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.LinearAlgebra.Dimension.Free

/-!
## Remark 1.27 — 𝒪_K as a Free ℤ-Module

**Remark 1.27.** The notation `ℤ_K` is also used for the ring of integers of `K`.
The symbol `𝒪` emphasizes that `𝒪_K` is the *maximal order* of `K`.
In any `ℚ`-algebra `K` of dimension `r`, an *order* is a subring that is also a free
`ℤ`-module of rank `r`. In particular, `𝒪_K` is a free `ℤ`-module of rank `[K : ℚ]`.

In Mathlib: `NumberField.RingOfIntegers.rank` and the `Module.Free` instance.
-/

/-- **Remark 1.27** (Sutherland). The ring of integers `𝒪_K` of a number field `K`
is a free `ℤ`-module of rank `[K : ℚ]`. -/
theorem sutherland_remark1_27 (K : Type*) [Field K] [NumberField K] :
    Module.Free ℤ (NumberField.RingOfIntegers K) :=
  inferInstance

/-- **Remark 1.27** (Sutherland). The `ℤ`-rank of `𝒪_K` equals `[K : ℚ]`. -/
theorem sutherland_remark1_27_rank (K : Type*) [Field K] [NumberField K] :
    Module.finrank ℤ (NumberField.RingOfIntegers K) = Module.finrank ℚ K :=
  NumberField.RingOfIntegers.rank K
