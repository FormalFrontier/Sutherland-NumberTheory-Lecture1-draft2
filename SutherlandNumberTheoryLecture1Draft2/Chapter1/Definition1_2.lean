import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean
import Mathlib.Data.Real.Basic

/-!
## Definition 1.2 — Absolute Values

**Definition 1.2.** An *absolute value* on a field `k` is a map `|·| : k → ℝ_≥0` such that
for all `x y : k`:
1. `|x| = 0 ↔ x = 0`
2. `|x * y| = |x| * |y|`
3. `|x + y| ≤ |x| + |y|`

If additionally `|x + y| ≤ max(|x|, |y|)`, the absolute value is *nonarchimedean*;
otherwise it is *archimedean*.

In Mathlib, this is `AbsoluteValue k ℝ`.
The nonarchimedean condition is `IsNonarchimedean (⇑f)`.
-/

/-- An absolute value on a field `k` in the sense of Sutherland Definition 1.2
is the same as `AbsoluteValue k ℝ` in Mathlib. -/
abbrev SutherlandAbsoluteValue (k : Type*) [Field k] := AbsoluteValue k ℝ

/-- An absolute value `f` on a field is *nonarchimedean* (Sutherland Def 1.2)
if `f (x + y) ≤ max (f x) (f y)` for all `x y`.
In Mathlib, this is `IsNonarchimedean (⇑f)`. -/
def isNonarchimedeanAbsVal {k : Type*} [Field k]
    (f : AbsoluteValue k ℝ) : Prop :=
  _root_.IsNonarchimedean (fun x => f x)
