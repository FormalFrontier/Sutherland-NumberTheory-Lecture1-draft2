import SutherlandNumberTheoryLecture1.Chapter1.Definition1_2
import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.AbsoluteValue.Equivalence

/-!
## Definition 1.6 — Equivalence of Absolute Values

**Definition 1.6.** Two absolute values `|·|` and `|·|'` on the same field `k` are
*equivalent* if there exists `α ∈ ℝ_{>0}` such that `|x|' = |x|^α` for all `x ∈ k`.

In Mathlib, this is `AbsoluteValue.IsEquiv`.
-/

/-- Two absolute values on the same field are *equivalent* (Sutherland Def 1.6)
if one is a positive real power of the other. In Mathlib: `AbsoluteValue.IsEquiv`. -/
def SutherlandEquivAbsoluteValue {k : Type*} [Field k]
    (f g : AbsoluteValue k ℝ) : Prop :=
  AbsoluteValue.IsEquiv f g
