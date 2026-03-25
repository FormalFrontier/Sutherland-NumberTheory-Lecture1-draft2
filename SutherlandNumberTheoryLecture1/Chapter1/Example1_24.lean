import SutherlandNumberTheoryLecture1.Chapter1.Definition1_19
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
  open Polynomial in
  refine ⟨X ^ 2 - X - 1, ?_, ?_⟩
  · have h1 : (X ^ 2 - X - 1 : ℤ[X]).natDegree = 2 := by compute_degree!
    unfold Monic leadingCoeff
    rw [h1]
    simp [coeff_X, coeff_one]
  · simp [eval₂_sub, eval₂_pow, eval₂_X, eval₂_one]
    nlinarith [Real.sq_sqrt (show (5 : ℝ) ≥ 0 by norm_num)]

/-- `ℤ[√5]` is not integrally closed (Example 1.24). -/
theorem zsqrtd5_not_integrallyClosed :
    ¬IsIntegrallyClosed (Zsqrtd 5) := by
  -- Provide Nonsquare 5, making Zsqrtd 5 an integral domain
  haveI h5ns : Zsqrtd.Nonsquare (5 : ℕ) := ⟨fun n h => by
    have hn : n ≤ 2 := by nlinarith
    interval_cases n <;> omega⟩
  haveI : IsDomain (ℤ√(5 : ℕ)) := inferInstance
  intro hic
  -- φ = (1+√5)/2 = ⟨1,1⟩/2 in FractionRing(Zsqrtd 5) is integral over Zsqrtd 5
  -- but not in Zsqrtd 5 (since 2*a = ⟨1,1⟩ has no solution in Zsqrtd 5)
  have h2nd : (2 : Zsqrtd 5) ∈ nonZeroDivisors (Zsqrtd 5) :=
    mem_nonZeroDivisors_of_ne_zero (by decide)
  have h2' : algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) 2 ≠ 0 :=
    IsFractionRing.to_map_ne_zero_of_mem_nonZeroDivisors h2nd
  let φ : FractionRing (Zsqrtd 5) :=
    algebraMap (Zsqrtd 5) _ (⟨1, 1⟩ : Zsqrtd 5) / algebraMap _ _ (2 : Zsqrtd 5)
  -- φ is integral over Zsqrtd 5: satisfies X^2 - X - 1 = 0
  have hφ : IsIntegral (Zsqrtd 5) φ := by
    open Polynomial in
    refine ⟨X ^ 2 - X - 1, ?_, ?_⟩
    · -- Monic
      have h1 : (X ^ 2 - X - 1 : (Zsqrtd 5)[X]).natDegree = 2 := by compute_degree!
      unfold Monic leadingCoeff; rw [h1]; simp [coeff_X, coeff_one]
    · -- Polynomial evaluation at φ equals 0
      -- First prove: (map ⟨1,1⟩)^2 - (map ⟨1,1⟩) * (map 2) - (map 2)^2 = 0
      have hkey : algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) (⟨1,1⟩ : Zsqrtd 5) ^ 2 -
          algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) (⟨1,1⟩ : Zsqrtd 5) *
          algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) 2 -
          algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) 2 ^ 2 = 0 := by
        have h : (⟨1, 1⟩ : Zsqrtd 5) ^ 2 - ⟨1, 1⟩ * 2 - 2 ^ 2 = 0 := by decide
        have h1 := congr_arg (algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5))) h
        rw [map_zero] at h1
        simp only [map_sub, map_pow, map_mul] at h1
        exact h1
      -- Expand aeval φ (X^2 - X - 1) and clear denominators
      simp only [eval₂_sub, eval₂_pow, eval₂_X, eval₂_one, φ]
      field_simp [h2']
      linear_combination hkey
  -- Apply IsIntegrallyClosed to get a preimage
  rw [isIntegrallyClosed_iff (FractionRing (Zsqrtd 5))] at hic
  obtain ⟨a, ha⟩ := hic hφ
  -- ha : algebraMap _ _ a = φ = ⟨1,1⟩ / 2
  -- So 2 * a = ⟨1,1⟩
  have h2a : 2 * a = ⟨1, 1⟩ := by
    apply IsFractionRing.injective (Zsqrtd 5) (FractionRing (Zsqrtd 5))
    rw [map_mul, ha]
    simp only [φ]
    exact mul_div_cancel₀ _ h2'
  -- But (2 * a).re = 2 * a.re = 1 is impossible in ℤ
  have hre := congr_arg Zsqrtd.re h2a
  simp only [Zsqrtd.re_mul,
             show (2 : Zsqrtd 5).re = (2 : ℤ) from by decide,
             show (2 : Zsqrtd 5).im = (0 : ℤ) from by decide,
             mul_zero, zero_mul, add_zero] at hre
  omega
