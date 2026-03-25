import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Valuation.Integers

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

In Mathlib:
- `Valuation k Γ₀` is the Mathlib valuation structure (using a linearly ordered comm. group)
- `IsDVR` (or `IsDiscreteValuationRing`) is the DVR predicate
- `Valuation.integer` is the valuation ring
-/

/-- A *discrete valuation ring* (DVR) in the sense of Sutherland Def 1.10
is an integral domain that is integrally closed, noetherian, and local of dimension 1.
In Mathlib: `IsDiscreteValuationRing`. -/
def IsDVR (A : Type*) [CommRing A] [IsDomain A] : Prop :=
  IsDiscreteValuationRing A
