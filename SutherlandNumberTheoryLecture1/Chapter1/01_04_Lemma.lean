import SutherlandNumberTheoryLecture1.Chapter1.«01_02_Definition»
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean
import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Analysis.Normed.Field.Ultra
import Mathlib.Analysis.Normed.Group.Ultra

/-!
## Lemma 1.4 — Characterization of Nonarchimedean Absolute Values

**Lemma 1.4.** An absolute value `|·|` on a field `k` is nonarchimedean if and only if
`|1 + ⋯ + 1| ≤ 1` for all `n ≥ 1` (i.e., `|(n : k)| ≤ 1` for all `n : ℕ`).

The forward direction (nonarchimedean ⟹ bounded on ℕ) is in Mathlib as
`IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean`.
The converse needs original proof: use the binomial theorem and take limits.
-/

/-- **Lemma 1.4** (Sutherland). An absolute value on a field is nonarchimedean
iff it is bounded by 1 on all natural number multiples of 1. -/
theorem sutherland_lemma1_4 {k : Type*} [Field k] (f : AbsoluteValue k ℝ) :
    IsNonarchimedean (⇑f) ↔ ∀ n : ℕ, f n ≤ 1 := by
  constructor
  · intro hna n
    exact IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean hna
  · intro hbnd
    letI : NormedField k := f.toNormedField
    haveI : IsUltrametricDist k :=
      IsUltrametricDist.isUltrametricDist_of_forall_norm_natCast_le_one hbnd
    exact IsUltrametricDist.isNonarchimedean_norm
