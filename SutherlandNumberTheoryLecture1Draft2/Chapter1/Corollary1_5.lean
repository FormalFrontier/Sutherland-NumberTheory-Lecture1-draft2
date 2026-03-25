import SutherlandNumberTheoryLecture1Draft2.Chapter1.Lemma1_4
import Mathlib.Algebra.CharP.Basic
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean

/-!
## Corollary 1.5 — Absolute Values in Positive Characteristic

**Corollary 1.5.** In a field of positive characteristic, every absolute value
is nonarchimedean, and the only absolute value on a finite field is the trivial one.

*Proof sketch:* If `char k = p > 0`, then every `n = 1 + ⋯ + 1` lies in `𝔽_p`
and satisfies `nᵖ = n`, so `f(n)ᵖ = f(n)`, meaning `f(n) ∈ {0, 1}`.
In particular `f(n) ≤ 1`, so `f` is nonarchimedean by Lemma 1.4.
For finite fields `|k| = q`, we have `xᵍ = x` for all `x`, so `f(x) ∈ {0,1}`.
-/

/-- **Corollary 1.5** (Sutherland). Every absolute value on a field of positive
characteristic is nonarchimedean. -/
theorem sutherland_corollary1_5_posChar {k : Type*} [Field k] [CharP k p] (hp : 0 < p)
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    IsNonarchimedean (⇑f) := by
  sorry

/-- **Corollary 1.5** (Sutherland). The only absolute value on a finite field is
the trivial one. -/
theorem sutherland_corollary1_5_finite {k : Type*} [Field k] [Fintype k] [DecidableEq k]
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    f = AbsoluteValue.trivial := by
  sorry
