import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.Ostrowski

/-!
## Theorem 1.8 — Ostrowski's Theorem

**Theorem 1.8** (Ostrowski's Theorem). Every nontrivial absolute value on `ℚ` is
equivalent to `|·|ₚ` for some `p ≤ ∞`.

This is fully proved in Mathlib as `Rat.AbsoluteValue.equiv_real_or_padic`.
-/

/-- **Theorem 1.8** (Ostrowski). Every nontrivial absolute value on `ℚ` is equivalent
to the real absolute value or to a `p`-adic absolute value for a unique prime `p`. -/
recall Rat.AbsoluteValue.equiv_real_or_padic (f : AbsoluteValue ℚ ℝ)
    (hf : f.IsNontrivial) :
    f.IsEquiv Rat.AbsoluteValue.real ∨
    ∃! p : ℕ, ∃ _ : Fact p.Prime, f.IsEquiv (Rat.AbsoluteValue.padic p)
