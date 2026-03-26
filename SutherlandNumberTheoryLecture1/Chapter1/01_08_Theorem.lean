import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.Ostrowski
import SutherlandNumberTheoryLecture1.Chapter1.«01_06_Definition»

/-!
## Theorem 1.8 — Ostrowski's Theorem

**Theorem 1.8** (Ostrowski's Theorem). Every nontrivial absolute value on `ℚ` is
equivalent to `|·|ₚ` for some `p ≤ ∞`.

This is fully proved in Mathlib as `Rat.AbsoluteValue.equiv_real_or_padic`.
We restate it using the book's `AreEquivalent` (Definition 1.6) via the bridging
theorem `areEquivalent_iff_isEquiv`.
-/

/-- **Theorem 1.8** (Ostrowski). Every nontrivial absolute value on `ℚ` is equivalent
to the real absolute value or to a `p`-adic absolute value for a unique prime `p`. -/
recall Rat.AbsoluteValue.equiv_real_or_padic (f : AbsoluteValue ℚ ℝ)
    (hf : f.IsNontrivial) :
    f.IsEquiv Rat.AbsoluteValue.real ∨
    ∃! p : ℕ, ∃ _ : Fact p.Prime, f.IsEquiv (Rat.AbsoluteValue.padic p)

/-- **Theorem 1.8** restated using the book's Definition 1.6 (`AreEquivalent`). -/
theorem Rat.AbsoluteValue.areEquivalent_real_or_padic (f : AbsoluteValue ℚ ℝ)
    (hf : f.IsNontrivial) :
    f.AreEquivalent Rat.AbsoluteValue.real ∨
    ∃! p : ℕ, ∃ _ : Fact p.Prime, f.AreEquivalent (Rat.AbsoluteValue.padic p) := by
  simp only [AbsoluteValue.areEquivalent_iff_isEquiv]
  exact Rat.AbsoluteValue.equiv_real_or_padic f hf
