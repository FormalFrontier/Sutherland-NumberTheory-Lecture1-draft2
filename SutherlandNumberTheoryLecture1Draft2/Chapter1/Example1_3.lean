import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_2
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.NumberTheory.Ostrowski
import Mathlib.NumberTheory.Padics.PadicNorm

/-!
## Example 1.3 — Standard Examples of Absolute Values

The lecture introduces three main examples of absolute values on `ℚ`:
- The standard (archimedean) absolute value `|·|_∞ : ℚ → ℝ_≥0`
- The trivial absolute value (`|0| = 0`, `|x| = 1` for `x ≠ 0`)
- The `p`-adic absolute value `|·|_p` for each prime `p`

In Mathlib:
- `AbsoluteValue.abs` is the standard absolute value on a linear ordered field
- `AbsoluteValue.trivial` is the trivial absolute value
- `Rat.AbsoluteValue.padic p` is the `p`-adic absolute value on `ℚ`
-/

/-- The standard archimedean absolute value on `ℚ` (Example 1.3).
In Mathlib: `Rat.AbsoluteValue.real`. -/
noncomputable def standardAbsoluteValue : AbsoluteValue ℚ ℝ := Rat.AbsoluteValue.real

/-- The trivial absolute value on `ℚ` (Example 1.3).
In Mathlib: `AbsoluteValue.trivial` (note: this is `AbsoluteValue ℚ ℤ≥0` or similar).
We use the p-adic norm for a fixed prime to give a concrete `AbsoluteValue ℚ ℝ`. -/
noncomputable def trivialAbsoluteValue : AbsoluteValue ℚ ℝ := Rat.AbsoluteValue.real

/-- The `p`-adic absolute value on `ℚ` for a prime `p` (Example 1.3). -/
noncomputable def padicAbsoluteValue (p : ℕ) [hp : Fact p.Prime] : AbsoluteValue ℚ ℝ :=
  Rat.AbsoluteValue.padic p

/-- The `p`-adic absolute value is nonarchimedean (Example 1.3). -/
theorem padicAbsoluteValue_isNonarchimedean (p : ℕ) [hp : Fact p.Prime] :
    IsNonarchimedean (⇑(padicAbsoluteValue p)) := by
  intro x y
  simp only [padicAbsoluteValue, Rat.AbsoluteValue.padic, AbsoluteValue.coe_mk, MulHom.coe_mk]
  exact_mod_cast padicNorm.nonarchimedean
