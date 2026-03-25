import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_2
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean

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
theorem sutherland_lemma1_4 {k : Type*} [Field k] (f : AbsoluteValue k ℝ)
    (hf1 : f 1 = 1) :
    IsNonarchimedean (⇑f) ↔ ∀ n : ℕ, f n ≤ 1 := by
  constructor
  · intro hna n
    exact IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean hna
  · intro hbnd
    sorry
