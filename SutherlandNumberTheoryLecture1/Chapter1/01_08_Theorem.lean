import SutherlandNumberTheoryLecture1.Chapter1.«01_06_Definition»
import SutherlandNumberTheoryLecture1.Chapter1.«01_07_Definition»
import Mathlib.NumberTheory.Ostrowski

/-!
## Theorem 1.8 — Ostrowski's Theorem

**Theorem 1.8** (Ostrowski's Theorem). Every nontrivial absolute value on `ℚ` is
equivalent to `|·|ₚ` for some `p ≤ ∞`.

This is fully proved in Mathlib as `Rat.AbsoluteValue.equiv_real_or_padic`.
-/

/-- **Theorem 1.8** (Ostrowski's Theorem, Sutherland). Every nontrivial absolute value
on `ℚ` is equivalent to `|·|_∞` or to `|·|_p` for some prime `p`.

In Mathlib: `Rat.AbsoluteValue.equiv_real_or_padic`. -/
theorem sutherland_theorem1_8 (f : AbsoluteValue ℚ ℝ) (hf : f.IsNontrivial) :
    f.IsEquiv Rat.AbsoluteValue.real ∨
    ∃! p : ℕ, ∃ _ : Fact p.Prime, f.IsEquiv (Rat.AbsoluteValue.padic p) :=
  Rat.AbsoluteValue.equiv_real_or_padic f hf
