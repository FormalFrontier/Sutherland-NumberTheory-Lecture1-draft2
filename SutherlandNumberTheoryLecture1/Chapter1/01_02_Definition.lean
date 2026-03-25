import Mathlib.Tactic.Recall
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.Basic

/-!
## Definition 1.2 — Absolute Values

**Definition 1.2.** An *absolute value* on a field `k` is a map `|·| : k → ℝ_≥0` such that
for all `x y : k`:
1. `|x| = 0 ↔ x = 0`
2. `|x * y| = |x| * |y|`
3. `|x + y| ≤ |x| + |y|`

If additionally `|x + y| ≤ max(|x|, |y|)`, the absolute value is *nonarchimedean*;
otherwise it is *archimedean*.

### Mathlib correspondence

Sutherland's "absolute value on a field `k`" is `AbsoluteValue k ℝ` in Mathlib —
a bundled multiplicative map to `ℝ` satisfying positivity, multiplicativity, and the
triangle inequality.

The nonarchimedean condition `|x + y| ≤ max(|x|, |y|)` is `IsNonarchimedean f`,
defined as `∀ a b, f (a + b) ≤ f a ⊔ f b`.
-/

/-- **Definition 1.2** (absolute value). In Mathlib, an absolute value on a semiring `R`
with values in an ordered semiring `S` is a bundled multiplicative map satisfying
positivity, multiplicativity, and the triangle inequality. -/
recall AbsoluteValue (R : Type*) (S : Type*) [Semiring R] [Semiring S] [PartialOrder S] :
    Type _

variable {R : Type*} [Semiring R] [LinearOrder R] [IsStrictOrderedRing R]

/-- **Definition 1.2** (nonarchimedean). An absolute value is *nonarchimedean* if
`f (a + b) ≤ max (f a) (f b)` for all `a b`. -/
recall IsNonarchimedean {α : Type*} [Add α] (f : α → R) : Prop :=
  ∀ a b : α, f (a + b) ≤ f a ⊔ f b
