import SutherlandNumberTheoryLecture1Draft2.Chapter1.Proposition1_28
import Mathlib.NumberTheory.Zsqrtd.Basic
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
## Example 1.29 — (1 + √7)/2 is Not Integral over ℤ

**Example 1.29.** Consider `α = (1 + √7)/2`. Its minimal polynomial is
`x² - x - 3/2 ∉ ℤ[x]`, so `α` is not integral over `ℤ` (by Proposition 1.28).

This contrasts with Example 1.24, where `(1 + √5)/2` IS integral over `ℤ`
(minimal polynomial `x² - x - 1 ∈ ℤ[x]`).
-/

/-- `(1 + √7)/2` is not integral over `ℤ` (Example 1.29):
its minimal polynomial over `ℚ` is `x² - x - 3/2 ∉ ℤ[x]`. -/
theorem halfOnePlusSqrt7_not_integral :
    ¬IsIntegral ℤ ((1 + Real.sqrt 7) / 2 : ℝ) := by
  sorry
