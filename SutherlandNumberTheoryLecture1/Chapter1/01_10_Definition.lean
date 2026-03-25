import Mathlib.Tactic.Recall
import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.Valuation.Discrete.Basic
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
- `Valuation.IsRankOneDiscrete` — discrete valuation (value group ≅ ℤ)
- `IsDiscreteValuationRing A` — `A` is a local PID that is not a field
  (equivalent to being the valuation ring of a discrete valuation on `Frac(A)`)
- `Valuation.integer v` — the valuation ring `{x | v x ≤ 1}`
- `IsDiscreteValuationRing.not_isField` — a DVR cannot be a field

The construction `v ↦ |·|_v = c^{v(·)}` (valuation → nonarchimedean absolute value)
does not have a single Mathlib declaration; it is the composition of the valuation
with exponentiation. The equivalence between Mathlib's DVR definition (local PID, not
a field) and the textbook's (valuation ring of a discrete valuation) is proved in
`01_16_Theorem.lean` as `sutherland_theorem1_16`.
-/

/-- **Definition 1.10** (valuation, multiplicative convention). A valuation `v : R → Γ₀`
with `v(0) = 0`, `v(1) = 1`, `v(xy) = v(x)·v(y)`, and
`v(x + y) ≤ max(v(x), v(y))`. -/
recall Valuation (R : Type*) (Γ₀ : Type*)
    [LinearOrderedCommMonoidWithZero Γ₀] [Ring R] : Type _

/-- **Definition 1.10** (valuation, additive convention). The additive version `v : R → Γ₀`
satisfying `v(x + y) ≥ min(v(x), v(y))`. -/
recall AddValuation (R : Type*) [Ring R] (Γ₀ : Type*)
    [LinearOrderedAddCommMonoidWithTop Γ₀] : Type _

/-- **Definition 1.10** (value group). The image of `v` in `Γ₀ˣ` is the *value group*.
In Mathlib, `MonoidWithZeroHom.valueGroup v` is the range of `v` as a subgroup of `Γ₀ˣ`. -/
example {R : Type*} [Ring R] {Γ₀ : Type*}
    [LinearOrderedCommGroupWithZero Γ₀] (v : Valuation R Γ₀) :
    Subgroup Γ₀ˣ := MonoidWithZeroHom.valueGroup v

/-- **Definition 1.10** (discrete valuation). A valuation is discrete when its value group
is isomorphic to `ℤ`. -/
recall Valuation.IsRankOneDiscrete {Γ₀ : Type*} [LinearOrderedCommGroupWithZero Γ₀]
    {R : Type*} [Ring R] (v : Valuation R Γ₀) : Prop

/-- **Definition 1.10** (DVR). A *discrete valuation ring* is an integral domain that is
a local PID and not a field. -/
recall IsDiscreteValuationRing (R : Type*) [CommRing R] [IsDomain R] : Prop

/-- **Definition 1.10** (DVR is not a field). A DVR cannot be a field, since
`v(Frac A) = ℤ ≠ ℤ≥0 = v(A)`.
See also `sutherland_theorem1_16` in `01_16_Theorem.lean` for the equivalence between
Mathlib's DVR definition and the textbook's. -/
recall IsDiscreteValuationRing.not_isField {R : Type*} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R] : ¬IsField R

/-- **Definition 1.10** (valuation ring). For every element of `Frac(A)`, either it or its
inverse lies in `A`. -/
recall ValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop
