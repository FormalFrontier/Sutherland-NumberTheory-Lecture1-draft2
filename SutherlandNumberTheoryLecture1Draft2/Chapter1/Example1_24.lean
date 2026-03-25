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
  open Polynomial in
  refine ⟨X ^ 2 - X - 1, ?_, ?_⟩
  · have h1 : (X ^ 2 - X - 1 : ℤ[X]).natDegree = 2 := by compute_degree!
    unfold Monic leadingCoeff
    rw [h1]
    simp [coeff_X, coeff_one]
  · simp [eval₂_sub, eval₂_pow, eval₂_X, eval₂_one]
    nlinarith [Real.sq_sqrt (show (5 : ℝ) ≥ 0 by norm_num)]

/-- `ℤ[√5]` is not integrally closed (Example 1.24).
The element `(1 + √5)/2` lies in `Frac(ℤ[√5])`, satisfies `x² - x - 1 = 0`,
but is not in `ℤ[√5]` itself. -/
theorem zsqrtd5_not_integrallyClosed :
    ¬IsIntegrallyClosed (Zsqrtd 5) := by
  -- IsDomain/Field instances require Zsqrtd.Nonsquare for d : ℕ.
  -- Since (5 : ℤ) = ↑(5 : ℕ) definitionally, we use `change` then provide Nonsquare 5.
  change ¬IsIntegrallyClosed (Zsqrtd ↑(5 : ℕ))
  haveI : Zsqrtd.Nonsquare (5 : ℕ) := ⟨fun n h => by
    have h1 : n < 3 := by nlinarith
    interval_cases n <;> omega⟩
  rw [isIntegrallyClosed_iff (K := FractionRing (Zsqrtd ↑(5 : ℕ)))]
  push_neg
  -- 2 ≠ 0 in ℤ[√5], so its image is nonzero in the fraction field
  have hb : (⟨2, 0⟩ : Zsqrtd ↑(5 : ℕ)) ≠ 0 := by decide
  have hbF : algebraMap (Zsqrtd ↑(5 : ℕ)) (FractionRing (Zsqrtd ↑(5 : ℕ))) ⟨2, 0⟩ ≠ 0 :=
    IsFractionRing.to_map_ne_zero_of_mem_nonZeroDivisors (mem_nonZeroDivisors_of_ne_zero hb)
  -- Witness: φ = (1 + √5)/2 in FractionRing(ℤ[√5])
  refine ⟨algebraMap (Zsqrtd ↑(5 : ℕ)) _ ⟨1, 1⟩ / algebraMap (Zsqrtd ↑(5 : ℕ)) _ ⟨2, 0⟩, ?_, ?_⟩
  · -- φ is integral over ℤ[√5]: it satisfies x² - x - 1 = 0
    open Polynomial in
    refine ⟨X ^ 2 - X - 1, ?_, ?_⟩
    · -- Monic
      have h1 : (X ^ 2 - X - 1 : (Zsqrtd ↑(5 : ℕ))[X]).natDegree = 2 := by compute_degree!
      unfold Monic leadingCoeff
      rw [h1]
      simp [coeff_sub, coeff_X_pow, coeff_X, coeff_one]
    · -- φ satisfies x² - x - 1 = 0: clear denominator, then compute in ℤ[√5]
      simp only [eval₂_sub, eval₂_pow, eval₂_X, eval₂_one]
      set am := algebraMap (Zsqrtd ↑(5 : ℕ)) (FractionRing (Zsqrtd ↑(5 : ℕ)))
      have key : am ⟨1, 1⟩ ^ 2 - am ⟨1, 1⟩ * am ⟨2, 0⟩ - am ⟨2, 0⟩ ^ 2 = 0 := by
        rw [← map_pow, ← map_mul, ← map_sub, ← map_pow, ← map_sub]
        simp [show (⟨1, 1⟩ : Zsqrtd ↑(5 : ℕ)) ^ 2 - ⟨1, 1⟩ * ⟨2, 0⟩ - ⟨2, 0⟩ ^ 2 = 0
          from by decide]
      field_simp [hbF]
      linear_combination key
  · -- φ = am y would force 2·y.im = 1 in ℤ, a contradiction
    -- Goal: ∀ y : Zsqrtd ↑5, am y ≠ am ⟨1,1⟩ / am ⟨2,0⟩
    -- Use rintro y hy (not ⟨y,hy⟩ which would destructure the Zsqrtd structure)
    rintro y hy
    have hinj := IsFractionRing.injective (Zsqrtd ↑(5 : ℕ)) (FractionRing (Zsqrtd ↑(5 : ℕ)))
    have h_eq : y * ⟨2, 0⟩ = ⟨1, 1⟩ := by
      apply hinj
      rw [map_mul, hy]
      exact div_mul_cancel₀ _ hbF
    have := congr_arg Zsqrtd.im h_eq
    simp [Zsqrtd.im_mul] at this
    omega
