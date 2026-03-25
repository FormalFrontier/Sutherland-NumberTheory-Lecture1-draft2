import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
## Example 1.15 — Power Series Ring as DVR

**Example 1.15.** For any field `k`, the power series ring `k[[t]]` is a DVR with
fraction field `k((t))` (Laurent series). The valuation `v : k((t)) → ℤ ∪ {∞}` sends
`∑_{n ≥ n₀} aₙ tⁿ` (with `a_{n₀} ≠ 0`) to `n₀`. The valuation ring is `k[[t]]`.

In Mathlib, the DVR instance for `k⟦X⟧` is automatic.
-/

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is a DVR for any field `k`. -/
example {k : Type*} [Field k] : IsDiscreteValuationRing k⟦X⟧ := inferInstance

open PowerSeries in
set_option backward.isDefEq.respectTransparency false in
/-- **Example 1.15.** `k⟦X⟧` is also a valuation ring. -/
example {k : Type*} [Field k] : ValuationRing k⟦X⟧ := inferInstance
