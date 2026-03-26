import Mathlib.Tactic.Recall
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.PowerSeries.Order
import Mathlib.RingTheory.LaurentSeries

/-!
## Example 1.15 — Power Series Ring as DVR

**Example 1.15.** For any field `k`, the power series ring `k[[t]]` is a DVR with
fraction field `k((t))` (Laurent series). The valuation `v : k((t)) → ℤ ∪ {∞}` sends
`∑_{n ≥ n₀} aₙ tⁿ` (with `a_{n₀} ≠ 0`) to `n₀`. The valuation ring is `k[[t]]`.

### Formalization strategy

The DVR and valuation ring instances for `k⟦X⟧` are automatic in Mathlib.
The X-adic valuation on Laurent series `k⸨X⸩` is provided by
`Valued K⸨X⸩ ℤᵐ⁰` (built from `PowerSeries.idealX`). The key connection —
that the valuation ring of this valuation is exactly `k⟦X⟧` — is
`LaurentSeries.val_le_one_iff_eq_coe`: a Laurent series has valuation ≤ 1
if and only if it is the image of a power series.
-/

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is a DVR for any field `k`. -/
example {k : Type*} [Field k] : IsDiscreteValuationRing k⟦X⟧ := inferInstance

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is also a valuation ring. -/
example {k : Type*} [Field k] : ValuationRing k⟦X⟧ := inferInstance

/-! ### The X-adic valuation on Laurent series

Mathlib equips the Laurent series field `k⸨X⸩` with the X-adic valuation via
the `Valued` instance, built from the height-one-spectrum valuation of the
prime ideal `(X) ⊂ k⟦X⟧`. For a power series `f`, the valuation measures
the X-adic order: the index of the first nonzero coefficient.
-/

open scoped LaurentSeries WithZero in
/-- The Laurent series field `k⸨X⸩` carries a canonical X-adic valuation with values in `ℤᵐ⁰`. -/
noncomputable example (k : Type*) [Field k] : Valued k⸨X⸩ ℤᵐ⁰ := inferInstance

/-! ### The valuation ring is k⟦X⟧

The mathematical content of Example 1.15: the valuation ring of the X-adic
valuation on `k((t))` is exactly `k[[t]]`. In Mathlib this is
`LaurentSeries.val_le_one_iff_eq_coe`: a Laurent series `f` satisfies
`v(f) ≤ 1` if and only if `f` comes from a power series.
-/

open scoped LaurentSeries WithZero in
open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15 (key result).** The valuation ring of the X-adic valuation on `k⸨X⸩`
is `k⟦X⟧`: a Laurent series has valuation ≤ 1 iff it is (the image of) a power series. -/
example (k : Type*) [Field k] (f : k⸨X⸩) :
    Valued.v f ≤ (1 : ℤᵐ⁰) ↔ ∃ F : k⟦X⟧, (F : k⸨X⸩) = f :=
  LaurentSeries.val_le_one_iff_eq_coe k f

/-! ### The order function as valuation

`PowerSeries.order` gives the valuation `v(φ) = n₀` from Example 1.15: for
`φ = ∑_{n ≥ n₀} aₙ Xⁿ` with `a_{n₀} ≠ 0`, `order φ = n₀`. The order is `⊤` iff `φ = 0`.
The order is multiplicative (`order (φ * ψ) = order φ + order ψ`) and equals the
multiplicity of `X` in `φ`, connecting the valuation-theoretic and algebraic views.
-/

open PowerSeries in
recall PowerSeries.order (R : Type*) [Semiring R] (φ : PowerSeries R) : ℕ∞

open PowerSeries in
recall PowerSeries.order_mul (R : Type*) [Semiring R] [NoZeroDivisors R]
  (φ ψ : PowerSeries R) :
  PowerSeries.order (φ * ψ) = PowerSeries.order φ + PowerSeries.order ψ

open PowerSeries in
recall PowerSeries.order_eq_emultiplicity_X (R : Type*) [Semiring R] (φ : PowerSeries R) :
  PowerSeries.order φ = emultiplicity PowerSeries.X φ

/-! ### The valuation determines the first nonzero coefficient

The X-adic valuation on power series is characterized by the vanishing of coefficients:
`v(f) ≤ exp(-d)` iff all coefficients below index `d` are zero. This is the precise
connection between the abstract valuation and the concrete "order of vanishing" from
the book.
-/

open scoped LaurentSeries WithZero in
open PowerSeries WithZero in
set_option backward.isDefEq.respectTransparency false in
/-- The valuation of a power series `f` satisfies `v(f) ≤ exp(-d)` iff all
coefficients of index `< d` vanish — i.e., the order of vanishing is at least `d`. -/
example (k : Type*) [Field k] {d : ℕ} (f : k⟦X⟧) :
    Valued.v (f : k⸨X⸩) ≤ Multiplicative.ofAdd (-d : ℤ) ↔
      ∀ n : ℕ, n < d → coeff n f = 0 :=
  LaurentSeries.intValuation_le_iff_coeff_lt_eq_zero k f

/-! ### Valuation at other points

The book mentions that for every `α ∈ k`, one can similarly define a valuation `v_α`
on `k((t))` as the order of vanishing of `f` at `α` (via the Laurent series expansion
about `α`). This corresponds to shifting the indeterminate `X ↦ X - C α` and taking
the order. A full formalization would require working with the substitution
`PowerSeries.map` composed with the shift; this is beyond the scope of Example 1.15
and is left as documentation-only.
-/
