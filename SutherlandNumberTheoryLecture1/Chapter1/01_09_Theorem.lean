import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.NumberField.ProductFormula

/-!
## Theorem 1.9 — Product Formula

**Theorem 1.9** (Product Formula). For every `x ∈ ℚˣ`,
$$\prod_{p ≤ ∞} |x|_p = 1.$$

This is a special case of the number field product formula, proved in Mathlib as
`NumberField.prod_abs_eq_one`. For `K = ℚ`, the product is over one infinite place
(the standard absolute value) and all finite places (the `p`-adic absolute values).
-/

/-- **Theorem 1.9** (Product Formula). For nonzero `x : K`, the product of `|x|_v`
over all places `v` of a number field `K` equals 1. -/
recall NumberField.prod_abs_eq_one {K : Type*} [Field K] [NumberField K]
    {x : K} (hx : x ≠ 0) :
    (∏ w : NumberField.InfinitePlace K, w x ^ w.mult) *
    ∏ᶠ w : NumberField.FinitePlace K, w x = 1
