import Mathlib.Analysis.AbsoluteValue.Equivalence

/-!
## Definition 1.6 — Equivalence of Absolute Values

**Definition 1.6.** Two absolute values `|·|` and `|·|'` on the same field `k` are
*equivalent* if there exists `α ∈ ℝ_{>0}` such that `|x|' = |x|^α` for all `x ∈ k`.

### Mathlib correspondence

Mathlib's `AbsoluteValue.IsEquiv v w` uses an equivalent characterization via
order-preservation: `∀ x y, v x ≤ v y ↔ w x ≤ w y`. For real-valued absolute values
on a field, this is equivalent to the book's power-law definition: if one absolute value
is a positive real power of the other, then they preserve the same ordering, and conversely.

We use Mathlib's `AbsoluteValue.IsEquiv` throughout this formalization rather than
defining a separate notion, since Ostrowski's Theorem (1.8) is proved in Mathlib using
`IsEquiv`. The book's Definition 1.6 corresponds exactly to `AbsoluteValue.IsEquiv`.
-/
