import SutherlandNumberTheoryLecture1.Chapter1.Definition1_2
import Mathlib.NumberTheory.Padics.PadicNorm
import Mathlib.NumberTheory.Ostrowski

/-!
## Definition 1.7 — The `p`-adic Valuation and Absolute Value

**Definition 1.7.** For a prime `p`, the *`p`-adic valuation* `vₚ : ℚ → ℤ ∪ {∞}` is defined
by `vₚ(±∏ q^{eₓ}) = eₚ` and `vₚ(0) = ∞`.
The *`p`-adic absolute value* is `|x|ₚ = p^{-vₚ(x)}` (with `|0|ₚ = 0`).

In Mathlib:
- `padicValRat p x` is `vₚ(x)` for `x : ℚ` (in `ℤ`, returning 0 for `x = 0`)
- `padicNorm p x` is `|x|ₚ` for `x : ℚ`
- `Rat.AbsoluteValue.padic p` is the `p`-adic absolute value as an `AbsoluteValue ℚ ℝ`
-/

/-- The `p`-adic valuation `vₚ : ℚ → ℤ` (Sutherland Def 1.7).
In Mathlib, `padicValRat p x` gives the `p`-adic valuation (0 for `x = 0`). -/
def padicValuation (p : ℕ) [hp : Fact p.Prime] (x : ℚ) : ℤ :=
  padicValRat p x

/-- The `p`-adic norm `|·|ₚ : ℚ → ℝ_≥0` (Sutherland Def 1.7).
In Mathlib, `padicNorm p x` gives `p^{-vₚ(x)}`. -/
noncomputable def padicNormAt (p : ℕ) [Fact p.Prime] (x : ℚ) : ℝ :=
  padicNorm p x

/-- The `p`-adic absolute value on `ℚ` as an `AbsoluteValue ℚ ℝ` (Sutherland Def 1.7). -/
noncomputable def padicAbsoluteValueOn (p : ℕ) [hp : Fact p.Prime] : AbsoluteValue ℚ ℝ :=
  Rat.AbsoluteValue.padic p
