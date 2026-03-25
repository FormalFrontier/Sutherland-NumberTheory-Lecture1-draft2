import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_19
import Mathlib.NumberTheory.Zsqrtd.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Localization.FractionRing
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
  -- 5 : ℕ is not a perfect square; needed for IsDomain (Zsqrtd 5) and Field (FractionRing ...)
  haveI h5ns : Zsqrtd.Nonsquare 5 := ⟨fun n h => by
    have h1 : n ≤ 2 := by nlinarith [Nat.zero_le n]
    linarith [Nat.mul_le_mul h1 h1]⟩
  -- Lean doesn't auto-unify (5 : ℤ) with ↑(5 : ℕ), so provide IsDomain explicitly
  haveI hdom : IsDomain (Zsqrtd 5) :=
    show IsDomain (Zsqrtd (↑(5 : ℕ))) from inferInstance
  -- 2 is nonzero in FractionRing (Zsqrtd 5)
  have h2mem : (2 : Zsqrtd 5) ∈ nonZeroDivisors (Zsqrtd 5) :=
    mem_nonZeroDivisors_of_ne_zero (by decide)
  have h2ne : (2 : FractionRing (Zsqrtd 5)) ≠ 0 := by
    have : algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) 2 = 2 := map_ofNat _ _
    rw [← this]
    exact IsFractionRing.to_map_ne_zero_of_mem_nonZeroDivisors h2mem
  intro hIC
  -- φ = (1+√5)/2 in FractionRing (ℤ[√5]), satisfies φ²-φ-1=0
  set φ : FractionRing (Zsqrtd 5) :=
    algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) ⟨1, 1⟩ / (2 : FractionRing (Zsqrtd 5))
    with hφ_def
  -- φ is integral over ℤ[√5] (satisfies the monic polynomial X²-X-1)
  have hφ_int : IsIntegral (Zsqrtd 5) φ := by
    refine ⟨Polynomial.X ^ 2 - Polynomial.X - 1, ?_, ?_⟩
    · -- Monic: the leading coefficient of X²-X-1 over Zsqrtd 5 is 1
      unfold Polynomial.Monic Polynomial.leadingCoeff
      have hdeg : (Polynomial.X ^ 2 - Polynomial.X - 1 : Polynomial (Zsqrtd 5)).natDegree = 2 := by
        compute_degree!
      rw [hdeg]
      simp [Polynomial.coeff_sub, Polynomial.coeff_X_pow, Polynomial.coeff_X, Polynomial.coeff_one]
    · -- eval₂ (algebraMap) φ (X²-X-1) = φ²-φ-1 = 0; clear denominators
      simp only [Polynomial.eval₂_sub, Polynomial.eval₂_pow, Polynomial.eval₂_X,
                 Polynomial.eval₂_one]
      rw [hφ_def]
      -- φ²-φ-1 = 0; clear denominators
      field_simp [h2ne]
      -- Goal: a*(a-2) - 2² = 2²*0, i.e., a²-2a-4=0, where a = algebraMap ⟨1,1⟩
      -- ⟨1,1⟩²-2*⟨1,1⟩-4 = ⟨6,2⟩-⟨2,2⟩-⟨4,0⟩ = ⟨0,0⟩ = 0 in Zsqrtd 5
      have key : (algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) ⟨1, 1⟩) ^ 2 -
                 2 * algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) ⟨1, 1⟩ - 4 = 0 := by
        have hval : (⟨1, 1⟩ : Zsqrtd 5) ^ 2 - 2 * ⟨1, 1⟩ - 4 = 0 := by decide
        have h := congr_arg (algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5))) hval
        simp only [map_sub, map_pow, map_mul, map_ofNat, map_zero] at h
        exact h
      linear_combination key
  -- By IsIntegrallyClosed, φ is in the image of algebraMap
  rw [IsIntegrallyClosed.isIntegral_iff] at hφ_int
  obtain ⟨y, hy⟩ := hφ_int
  -- From hy: algebraMap y = algebraMap ⟨1,1⟩ / 2, so 2*y = ⟨1,1⟩ in Zsqrtd 5
  have h2y : (2 : Zsqrtd 5) * y = ⟨1, 1⟩ := by
    apply IsFractionRing.injective (Zsqrtd 5) (FractionRing (Zsqrtd 5))
    rw [map_mul, hy, hφ_def]
    -- Goal: algebraMap 2 * (algebraMap ⟨1,1⟩ / 2) = algebraMap ⟨1,1⟩
    rw [show algebraMap (Zsqrtd 5) (FractionRing (Zsqrtd 5)) 2 = 2 from map_ofNat _ _]
    field_simp [h2ne]
  -- But 2*y.re = 1 in ℤ is impossible
  have hre := congr_arg Zsqrtd.re h2y
  simp only [Zsqrtd.re_mul, Zsqrtd.re_ofNat, Zsqrtd.im_ofNat,
             mul_zero, zero_mul, add_zero] at hre
  omega
