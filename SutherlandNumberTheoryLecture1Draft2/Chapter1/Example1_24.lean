import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_19
import Mathlib.NumberTheory.Zsqrtd.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
## Example 1.24 — ℤ[√5] is Not Integrally Closed

**Example 1.24.** The ring `ℤ[√5]` is not a UFD (nor a PID) because it is not
integrally closed: consider `φ = (1 + √5)/2 ∈ Frac(ℤ[√5])`, which is integral over `ℤ`
since `φ² - φ - 1 = 0`, but `φ ∉ ℤ[√5]`.

In Mathlib, `ℤ[√5]` is `ℤ√5 := Zsqrtd 5`.
-/

/-- `φ = (1 + √5)/2` satisfies `φ² - φ - 1 = 0`,
so it is integral over `ℤ` (Example 1.24).
The minimal polynomial is `x² - x - 1 ∈ ℤ[x]`. -/
theorem goldenRatio_isIntegral :
    IsIntegral ℤ ((1 + Real.sqrt 5) / 2 : ℝ) := by
  sorry

/-- `ℤ[√5]` is not integrally closed (Example 1.24). -/
theorem zsqrtd5_not_integrallyClosed :
    ¬IsIntegrallyClosed (Zsqrtd 5) := by
  sorry
