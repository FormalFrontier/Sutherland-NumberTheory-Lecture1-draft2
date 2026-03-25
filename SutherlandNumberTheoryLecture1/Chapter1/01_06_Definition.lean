import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
## Definition 1.6 — Equivalence of Absolute Values

**Definition 1.6.** Two absolute values `|·|` and `|·|'` on the same field `k` are
*equivalent* if there exists `α ∈ ℝ_{>0}` such that `|x|' = |x|^α` for all `x ∈ k`.

### Mathlib correspondence

Mathlib's `AbsoluteValue.IsEquiv v w` uses an equivalent characterization via
order-preservation: `∀ x y, v x ≤ v y ↔ w x ≤ w y`. For real-valued absolute values
this is equivalent to the power-law definition above.

We formalize the book's definition directly.
-/

/-- **Definition 1.6.** Two absolute values on `k` are *equivalent* if one is a positive
real power of the other: `∃ α > 0, ∀ x, g x = (f x) ^ α`. -/
def AbsoluteValue.AreEquivalent {k : Type*} [Field k]
    (f g : AbsoluteValue k ℝ) : Prop :=
  ∃ α : ℝ, 0 < α ∧ ∀ x : k, g x = (f x) ^ α
