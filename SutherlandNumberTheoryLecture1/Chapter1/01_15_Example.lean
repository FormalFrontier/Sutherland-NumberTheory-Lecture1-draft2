import Mathlib.Tactic.Recall
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.PowerSeries.Order

/-!
## Example 1.15 — Power Series Ring as DVR

**Example 1.15.** For any field `k`, the power series ring `k[[t]]` is a DVR with
fraction field `k((t))` (Laurent series). The valuation `v : k((t)) → ℤ ∪ {∞}` sends
`∑_{n ≥ n₀} aₙ tⁿ` (with `a_{n₀} ≠ 0`) to `n₀`. The valuation ring is `k[[t]]`.

In Mathlib, the DVR instance for `k⟦X⟧` is automatic. The valuation on `k⟦X⟧` is
`PowerSeries.order`, which gives the multiplicity of `X` in `φ` — equivalently,
the index of the first nonzero coefficient. For `f ∈ k((t))×`, the valuation `v(f)`
is the *order of vanishing* of `f` at zero.
-/

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is a DVR for any field `k`. -/
example {k : Type*} [Field k] : IsDiscreteValuationRing k⟦X⟧ := inferInstance

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is also a valuation ring. -/
example {k : Type*} [Field k] : ValuationRing k⟦X⟧ := inferInstance

/-! ### The valuation on k⟦X⟧

The valuation `v(∑ aₙ Xⁿ) = n₀` where `a_{n₀} ≠ 0` is `PowerSeries.order` in Mathlib.
It is the greatest `n` such that `X^n` divides `φ`, equivalently the index of the
first nonzero coefficient. For nonzero `f`, this is the *order of vanishing* of `f`
at zero: the multiplicity of `X` as a factor.
-/

-- `PowerSeries.order φ` is the greatest `n : ℕ∞` such that `X^n ∣ φ`.
-- This is the valuation `v(φ) = n₀` from Example 1.15: for `φ = ∑_{n ≥ n₀} aₙ Xⁿ`
-- with `a_{n₀} ≠ 0`, `order φ = n₀`. The order is `⊤` iff `φ = 0`.
open PowerSeries in
recall PowerSeries.order (R : Type*) [Semiring R] (φ : PowerSeries R) : ℕ∞

-- `order` is an additive valuation: `order (φ * ψ) = order φ + order ψ`.
open PowerSeries in
recall PowerSeries.order_mul (R : Type*) [Semiring R] [NoZeroDivisors R]
  (φ ψ : PowerSeries R) :
  PowerSeries.order (φ * ψ) = PowerSeries.order φ + PowerSeries.order ψ

-- The order equals the multiplicity of `X` in `φ`, connecting the
-- valuation-theoretic view with the algebraic notion of multiplicity.
open PowerSeries in
recall PowerSeries.order_eq_emultiplicity_X (R : Type*) [Semiring R] (φ : PowerSeries R) :
  PowerSeries.order φ = emultiplicity PowerSeries.X φ

/-! ### Valuation at other points

The book mentions that for every `α ∈ k`, one can similarly define a valuation `v_α`
on `k((t))` as the order of vanishing of `f` at `α` (via the Laurent series expansion
about `α`). This corresponds to shifting the indeterminate `X ↦ X - C α` and taking
the order. A full formalization would require working with the substitution
`PowerSeries.map` composed with the shift; this is beyond the scope of Example 1.15
and is left as documentation-only.

-- TODO: v_α formalization would require `PowerSeries.eval` or substitution infrastructure
-- that is not currently available in Mathlib. This is a documentation-only claim.
-/
