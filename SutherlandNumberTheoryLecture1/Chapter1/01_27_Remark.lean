import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.LinearAlgebra.Dimension.Free

/-!
## Remark 1.27 — 𝒪_K as a Free ℤ-Module

**Remark 1.27.** The notation `ℤ_K` is also used for the ring of integers of `K`.
The symbol `𝒪` emphasizes that `𝒪_K` is the *maximal order* of `K`.
In any `ℚ`-algebra `K` of dimension `r`, an *order* is a subring that is also a free
`ℤ`-module of rank `r`. In particular, `𝒪_K` is a free `ℤ`-module of rank `[K : ℚ]`.

### Mathlib correspondence

The freeness is automatic (`Module.Free ℤ (𝓞 K)` is an instance).
The rank equality is `NumberField.RingOfIntegers.rank`.
-/

/-- **Remark 1.27.** `𝓞 K` is a free `ℤ`-module. -/
example {K : Type*} [Field K] [NumberField K] :
    Module.Free ℤ (NumberField.RingOfIntegers K) := inferInstance

/-- **Remark 1.27.** The `ℤ`-rank of `𝓞 K` equals `[K : ℚ]`. -/
recall NumberField.RingOfIntegers.rank (K : Type*) [Field K] [NumberField K] :
    Module.finrank ℤ (NumberField.RingOfIntegers K) = Module.finrank ℚ K
