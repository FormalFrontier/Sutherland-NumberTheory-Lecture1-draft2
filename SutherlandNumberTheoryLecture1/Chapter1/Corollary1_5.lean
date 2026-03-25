import SutherlandNumberTheoryLecture1.Chapter1.Lemma1_4
import Mathlib.Algebra.CharP.Basic
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean
import Mathlib.FieldTheory.Finite.Basic

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
  have hp_ne : p ≠ 0 := Nat.pos_iff_ne_zero.mp hp
  have hp_prime : p.Prime := CharP.char_prime_of_ne_zero k hp_ne
  haveI : Fact p.Prime := ⟨hp_prime⟩
  rw [sutherland_lemma1_4 f hf1]
  intro n
  -- In char p, (n : k)^p = n by freshman's dream (induction + add_pow_char)
  have hfn_pow : f n ^ p = f n := by
    rw [← f.map_pow]
    congr 1
    induction n with
    | zero => simp [hp_ne]
    | succ m ih =>
      push_cast
      rw [add_pow_char, ih, one_pow]
  -- f(n) > 1 would give f(n)^p > f(n)^1 = f(n), contradicting f(n)^p = f(n)
  by_contra h_gt
  push_neg at h_gt
  have := pow_lt_pow_right₀ h_gt hp_prime.one_lt
  rw [pow_one, hfn_pow] at this
  exact lt_irrefl _ this

/-- **Corollary 1.5** (Sutherland). The only absolute value on a finite field is
the trivial one. -/
theorem sutherland_corollary1_5_finite {k : Type*} [Field k] [Fintype k] [DecidableEq k]
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    f = AbsoluteValue.trivial := by
  ext x
  by_cases hx : x = 0
  · simp [hx, f.map_zero]
  · rw [AbsoluteValue.trivial_apply hx]
    -- x^(q-1) = 1 in a finite field
    have hq : x ^ (Fintype.card k - 1) = 1 := FiniteField.pow_card_sub_one_eq_one x hx
    -- f(x)^(q-1) = f(x^(q-1)) = f(1) = 1
    have hfx_pow : f x ^ (Fintype.card k - 1) = 1 := by
      rw [← f.map_pow, hq, hf1]
    -- q ≥ 2 so q-1 ≥ 1 ≠ 0
    have hn : Fintype.card k - 1 ≠ 0 := by
      have : 1 < Fintype.card k := Fintype.one_lt_card
      omega
    -- f(x) ≥ 0 and f(x)^(q-1) = 1 imply f(x) = 1
    exact (pow_eq_one_iff_of_nonneg (f.nonneg x) hn).mp hfx_pow
