import SutherlandNumberTheoryLecture1.Chapter1.Proposition1_28
import Mathlib.NumberTheory.Zsqrtd.Basic
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed

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
  intro h
  -- (1 - √7)/2 is also integral over ℤ
  have hconj : IsIntegral ℤ ((1 - Real.sqrt 7) / 2 : ℝ) := by
    have heq : (1 - Real.sqrt 7) / 2 = 1 - (1 + Real.sqrt 7) / 2 := by ring
    rw [heq]; exact isIntegral_one.sub h
  -- α * (1-α) = (1 - 7)/4 = -3/2
  have hval : ((1 + Real.sqrt 7) / 2) * ((1 - Real.sqrt 7) / 2) = (-3 : ℝ) / 2 := by
    have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
    have : ((1 + Real.sqrt 7) / 2) * ((1 - Real.sqrt 7) / 2) =
        (1 - Real.sqrt 7 ^ 2) / 4 := by ring
    rw [this, h7]; norm_num
  -- So -3/2 : ℝ is integral over ℤ
  have hR : IsIntegral ℤ ((-3 : ℝ) / 2) := hval ▸ h.mul hconj
  -- The map ℚ → ℝ is injective
  have hinj : Function.Injective (algebraMap ℚ ℝ) := by
    intro a b hab; exact_mod_cast hab
  -- So -3/2 : ℚ is integral over ℤ (via isIntegral_algebraMap_iff)
  have hQ : IsIntegral ℤ ((-3 : ℚ) / 2) := by
    -- algebraMap ℚ ℝ = Rat.cast, so algebraMap ℚ ℝ (-3/2 : ℚ) = (-3 : ℝ)/2
    have hcast : algebraMap ℚ ℝ ((-3 : ℚ) / 2) = (-3 : ℝ) / 2 := by
      rw [show algebraMap ℚ ℝ ((-3 : ℚ) / 2) = (((-3 : ℚ) / 2 : ℚ) : ℝ) from rfl]
      push_cast; ring
    exact (isIntegral_algebraMap_iff hinj).mp (hcast ▸ hR)
  -- ℤ is integrally closed in ℚ, so -3/2 ∈ ℤ
  haveI : IsIntegrallyClosed ℤ := GCDMonoid.toIsIntegrallyClosed
  rw [IsIntegrallyClosed.isIntegral_iff] at hQ
  obtain ⟨a, ha⟩ := hQ
  -- ha : algebraMap ℤ ℚ a = -3/2; since a ∈ ℤ, a * 2 = -3, contradiction
  have ha' : (a : ℚ) = -3 / 2 := ha
  have h2 : (a : ℤ) * 2 = -3 := by exact_mod_cast (show (a : ℚ) * 2 = -3 by linarith)
  omega
