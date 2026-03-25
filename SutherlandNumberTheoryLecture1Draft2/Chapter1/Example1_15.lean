import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_10
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors
import Mathlib.RingTheory.DiscreteValuationRing.Basic

/-!
## Example 1.15 — Power Series Ring as DVR

**Example 1.15.** For any field `k`, the power series ring `k[[t]]` is a DVR with
fraction field `k((t))` (Laurent series). The valuation `v : k((t)) → ℤ ∪ {∞}` sends
`∑_{n ≥ n₀} aₙ tⁿ` (with `a_{n₀} ≠ 0`) to `n₀`. The valuation ring is `k[[t]]`.

In Mathlib: `PowerSeries.IsDVR` or the `IsDiscreteValuationRing (PowerSeries k)` instance.
-/

/-- The power series ring `k[[t]]` over a field `k` is a DVR (Example 1.15). -/
theorem powerSeries_isDVR (k : Type*) [Field k] :
    IsDiscreteValuationRing (PowerSeries k) := by
  sorry
