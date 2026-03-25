import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.Padics.PadicNorm
import Mathlib.NumberTheory.Ostrowski

/-!
## Definition 1.7 — The `p`-adic Valuation and Absolute Value

**Definition 1.7.** For a prime `p`, the *`p`-adic valuation* `vₚ : ℚ → ℤ ∪ {∞}` is defined
by `vₚ(±∏ q^{eₓ}) = eₚ` and `vₚ(0) = ∞`.
The *`p`-adic absolute value* is `|x|ₚ = p^{-vₚ(x)}` (with `|0|ₚ = 0`).

### Mathlib correspondence

- `padicValRat p x` — the `p`-adic valuation of `x : ℚ` (returns `0` for `x = 0`)
- `padicNorm p x` — the `p`-adic norm `p ^ (-vₚ(x))` as a `ℚ`
- `Rat.AbsoluteValue.padic p` — the `p`-adic absolute value bundled as `AbsoluteValue ℚ ℝ`
-/

/-- **Definition 1.7.** The `p`-adic valuation `vₚ(x)` for `x : ℚ`. Returns `0` for `x = 0`. -/
recall padicValRat (p : ℕ) (q : ℚ) : ℤ

/-- **Definition 1.7.** The `p`-adic norm `|x|ₚ = p ^ (-vₚ(x))` as a rational number. -/
recall padicNorm (p : ℕ) (q : ℚ) : ℚ

/-- **Definition 1.7.** The `p`-adic absolute value `|x|ₚ` bundled as `AbsoluteValue ℚ ℝ`. -/
recall Rat.AbsoluteValue.padic (p : ℕ) [Fact p.Prime] : AbsoluteValue ℚ ℝ
