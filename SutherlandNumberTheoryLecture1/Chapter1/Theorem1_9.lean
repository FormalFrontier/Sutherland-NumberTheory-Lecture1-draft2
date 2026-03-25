import SutherlandNumberTheoryLecture1.Chapter1.Definition1_7
import Mathlib.NumberTheory.NumberField.ProductFormula

/-!
## Theorem 1.9 — Product Formula

**Theorem 1.9** (Product Formula). For every `x ∈ ℚˣ`,
$$\prod_{p ≤ ∞} |x|_p = 1.$$

This follows from the general number field product formula in Mathlib
(`NumberField.prod_abs_eq_one`), specialized to `ℚ`.
-/

/-- **Theorem 1.9** (Product Formula, Sutherland). For every nonzero rational `x`,
the product over all places of `|x|` equals 1.

In Mathlib: `NumberField.prod_abs_eq_one` for a number field `K`. -/
theorem sutherland_theorem1_9 {x : ℚ} (hx : x ≠ 0) :
    (∏ w : NumberField.InfinitePlace ℚ, w x ^ w.mult) *
    ∏ᶠ w : NumberField.FinitePlace ℚ, w x = 1 :=
  NumberField.prod_abs_eq_one hx
