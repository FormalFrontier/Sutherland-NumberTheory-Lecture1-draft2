import Mathlib.Tactic.Recall
import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Valuation.Integers
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
## Definition 1.10 — Valuations, Value Groups, Valuation Rings, and DVRs

**Definition 1.10.** A *valuation* on a field `k` is a group homomorphism `v : kˣ → ℝ`
such that `v(x + y) ≥ min(v(x), v(y))` for all `x y : k`.

We extend to `v : k → ℝ ∪ {∞}` by `v(0) = ∞`.
For `0 < c < 1`, `|x|_v = c^{v(x)}` is a nonarchimedean absolute value.
The *value group* is the image of `v` in `ℝ`.
A *discrete valuation* has value group `ℤ`.
The *valuation ring* is `A = {x ∈ k | v(x) ≥ 0}`.
A *discrete valuation ring* (DVR) is an integral domain that is the valuation ring
of its fraction field for a discrete valuation.

### Mathlib correspondence

- `Valuation k Γ₀` — a valuation on `k` with values in a linearly ordered group with zero
- `IsDiscreteValuationRing A` — `A` is a local PID that is not a field
  (equivalent to being the valuation ring of a discrete valuation on `Frac(A)`)
- `Valuation.integer v` — the valuation ring `{x | v x ≤ 1}`
-/

/-- **Definition 1.10** (valuation). A valuation on a field in the additive convention. -/
recall AddValuation (R : Type*) [Ring R] (Γ₀ : Type*)
    [LinearOrderedAddCommMonoidWithTop Γ₀] : Type _

/-- **Definition 1.10** (DVR). A *discrete valuation ring* is an integral domain that is
a local PID and not a field. -/
recall IsDiscreteValuationRing (R : Type*) [CommRing R] [IsDomain R] : Prop

/-- **Definition 1.10** (valuation ring). For every element of `Frac(A)`, either it or its
inverse lies in `A`. -/
recall ValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop
