import SutherlandNumberTheoryLecture1Draft2.Chapter1.Lemma1_4
import Mathlib.Algebra.CharP.Basic
import Mathlib.Algebra.CharP.Frobenius
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
theorem sutherland_corollary1_5_posChar {k : Type*} [Field k] {p : ℕ} [CharP k p] (hp : 0 < p)
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    IsNonarchimedean (⇑f) := by
  rw [sutherland_lemma1_4 f hf1]
  intro n
  -- The nat cast (n : k) satisfies (n : k)^p = (n : k) by the Frobenius endomorphism
  by_cases hn : (n : k) = 0
  · -- In this case f n = f 0 = 0 ≤ 1
    have : f n = 0 := by rw [show (n : k) = 0 from hn]; exact map_zero f
    linarith [f.nonneg n]
  · -- p must be prime since k is a field
    have hprime : Nat.Prime p :=
      (CharP.char_is_prime_or_zero k p).resolve_right (Nat.pos_iff_ne_zero.mp hp)
    haveI : Fact (Nat.Prime p) := ⟨hprime⟩
    -- Frobenius sends nat casts to themselves: (n : k)^p = (n : k)
    have hn_pow : (n : k) ^ p = n := by
      have h := map_natCast (frobenius k p) n
      rwa [frobenius_def] at h
    -- Hence f(n)^p = f(n^p) = f(n)
    have hfn_pow : f n ^ p = f n := by rw [← f.map_pow, hn_pow]
    have hfn_pos : 0 < f n := f.pos hn
    -- From f(n)^p = f(n) and f(n) > 0, deduce f(n)^(p-1) = 1, so f(n) = 1
    have hfn_pm1 : f n ^ (p - 1) = 1 :=
      mul_right_cancel₀ (ne_of_gt hfn_pos)
        (show f n ^ (p - 1) * f n = 1 * f n from by
          rw [one_mul, ← pow_succ, show p - 1 + 1 = p from by omega]
          exact hfn_pow)
    linarith [(pow_eq_one_iff_of_nonneg (le_of_lt hfn_pos)
      (show p - 1 ≠ 0 from by have := hprime.one_lt; omega)).mp hfn_pm1]

/-- **Corollary 1.5** (Sutherland). The only absolute value on a finite field is
the trivial one. -/
theorem sutherland_corollary1_5_finite {k : Type*} [Field k] [Fintype k] [DecidableEq k]
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    f = AbsoluteValue.trivial := by
  apply AbsoluteValue.ext
  intro x
  by_cases hx : x = 0
  · simp [hx, map_zero, AbsoluteValue.trivial]
  · -- For x ≠ 0: x^q = x (Fermat), so f(x)^q = f(x), so f(x) = 1 = trivial(x)
    have hfx_pos : 0 < f x := f.pos hx
    have hq : x ^ Fintype.card k = x := FiniteField.pow_card x
    have hfx_pow : f x ^ Fintype.card k = f x := by rw [← f.map_pow, hq]
    -- Fintype.card k ≥ 2 since k is a nontrivial field
    have hcard_ge2 : 2 ≤ Fintype.card k := Fintype.one_lt_card_iff_nontrivial.mpr inferInstance
    have hfx_pm1 : f x ^ (Fintype.card k - 1) = 1 :=
      mul_right_cancel₀ (ne_of_gt hfx_pos)
        (show f x ^ (Fintype.card k - 1) * f x = 1 * f x from by
          rw [one_mul, ← pow_succ, show Fintype.card k - 1 + 1 = Fintype.card k from by omega]
          exact hfx_pow)
    have hfx_eq : f x = 1 :=
      (pow_eq_one_iff_of_nonneg (le_of_lt hfx_pos)
        (show Fintype.card k - 1 ≠ 0 from by omega)).mp hfx_pm1
    rw [hfx_eq, AbsoluteValue.trivial_apply hx]
