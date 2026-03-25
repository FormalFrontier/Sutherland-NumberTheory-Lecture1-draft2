import Mathlib.Tactic.Recall
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean

/-!
## Example 1.3 — The Trivial Absolute Value

**Example 1.3.** The map `|·| : k → ℝ_≥0` defined by `|x| = 1` if `x ≠ 0` and
`|0| = 0` is the *trivial absolute value* on `k`. It is nonarchimedean.

### Mathlib correspondence

- `AbsoluteValue.trivial` — the trivial absolute value on any decidable `CommGroupWithZero`.
- `AbsoluteValue.trivial_apply` — `|x| = 1` for `x ≠ 0`.
-/

/-- **Example 1.3.** The trivial absolute value. -/
recall AbsoluteValue.trivial

/-- **Example 1.3.** The trivial absolute value maps nonzero elements to 1. -/
recall AbsoluteValue.trivial_apply

/-- **Example 1.3.** The trivial absolute value is nonarchimedean. -/
theorem trivialAbsoluteValue_isNonarchimedean {k : Type*} [DecidableEq k] [Field k] :
    IsNonarchimedean (⇑(AbsoluteValue.trivial : AbsoluteValue k ℤ)) := by
  intro x y
  by_cases hx : x = 0
  · simp [AbsoluteValue.trivial, hx]
  · by_cases hy : y = 0
    · simp [AbsoluteValue.trivial, hy]
    · by_cases hxy : x + y = 0 <;> simp [AbsoluteValue.trivial, hx, hy, hxy]
