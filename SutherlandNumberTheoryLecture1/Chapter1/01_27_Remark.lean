import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.LinearAlgebra.Dimension.Free
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
## Remark 1.27 — 𝒪_K as a Free ℤ-Module and Maximal Order

**Remark 1.27.** The notation `ℤ_K` is also used for the ring of integers of `K`.
The symbol `𝒪` emphasizes that `𝒪_K` is the *maximal order* of `K`.
In any `ℚ`-algebra `K` of dimension `r`, an *order* is a subring that is also a free
`ℤ`-module of rank `r`, equivalently a `ℤ`-lattice in `K` that is also a ring.
In particular, `𝒪_K` is a free `ℤ`-module of rank `[K : ℚ]`, and it is the maximal
order: it contains every order in `K`.

### Mathlib correspondence

The freeness is automatic (`Module.Free ℤ (𝓞 K)` is an instance).
The rank equality is `NumberField.RingOfIntegers.rank`.
The order definition is not in Mathlib; we define it here as `NumberField.Order`.
-/

/-- **Remark 1.27.** `𝓞 K` is a free `ℤ`-module. -/
example {K : Type*} [Field K] [NumberField K] :
    Module.Free ℤ (NumberField.RingOfIntegers K) := inferInstance

/-- **Remark 1.27.** The `ℤ`-rank of `𝓞 K` equals `[K : ℚ]`. -/
recall NumberField.RingOfIntegers.rank (K : Type*) [Field K] [NumberField K] :
    Module.finrank ℤ (NumberField.RingOfIntegers K) = Module.finrank ℚ K

/-! ### Order definition

An *order* in a number field `K` is a subring of `K` that is also a free `ℤ`-module
of rank `[K : ℚ]`. The equivalent description as a "ℤ-lattice in K that is also a ring"
is just a restatement in lattice-theoretic language and is not separately formalized. -/

/-- An **order** in a number field `K` is a subring of `K` that is a free `ℤ`-module
of rank `[K : ℚ]`. -/
structure NumberField.Order (K : Type*) [Field K] [NumberField K] where
  /-- The underlying subring of `K`. -/
  carrier : Subring K
  /-- The subring is a free `ℤ`-module. -/
  free : Module.Free ℤ carrier
  /-- The `ℤ`-rank equals `[K : ℚ]`. -/
  rank_eq : Module.finrank ℤ carrier = Module.finrank ℚ K

/-! ### 𝒪_K is the maximal order

Every element of an order is integral over `ℤ` (since it lies in a finitely generated
`ℤ`-module), hence belongs to the integral closure `𝒪_K`. -/

/-- **Remark 1.27.** `𝒪_K` is the maximal order: every order in `K` is contained in `𝒪_K`. -/
theorem NumberField.Order.le_ringOfIntegers {K : Type*} [Field K] [NumberField K]
    (O : NumberField.Order K) (x : K) (hx : x ∈ O.carrier) :
    x ∈ (algebraMap (NumberField.RingOfIntegers K) K).range := by
  haveI := O.free
  have hfin : Module.Finite ℤ O.carrier :=
    Module.finite_of_finrank_pos (O.rank_eq ▸ Module.finrank_pos (R := ℚ) (M := K))
  have hint : IsIntegral ℤ (⟨x, hx⟩ : O.carrier) := IsIntegral.of_finite ℤ _
  rw [RingHom.mem_range]
  exact IsIntegralClosure.isIntegral_iff.mp (hint.algebraMap (R := ℤ))
