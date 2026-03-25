import Mathlib.Tactic.Recall
import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Valuation.Integers
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.Valuation.Discrete.Basic
import Mathlib.Algebra.GroupWithZero.Range

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
- `Valuation.valueGroup v` — the value group (smallest subgroup of `Γˣ` containing the range)
- `ValueGroup₀ v` — the value group with zero adjoined
- `Valuation.IsRankOneDiscrete v` — discrete valuation (value group is cyclic and nontrivial)
- `IsDiscreteValuationRing A` — `A` is a local PID that is not a field
  (equivalent to being the valuation ring of a discrete valuation on `Frac(A)`)
- `Valuation.integer v` — the valuation ring `{x | v x ≤ 1}`
- `IsDiscreteValuationRing.not_isField` — a DVR cannot be a field
- The textbook's DVR definition (valuation ring of a discrete valuation on `Frac(A)`)
  is equivalent to Mathlib's (local PID, not a field); see `sutherland_theorem1_16`
  in `01_16_Theorem.lean`.
-/

/-- **Definition 1.10** (valuation). A valuation on a field in the additive convention. -/
recall AddValuation (R : Type*) [Ring R] (Γ₀ : Type*)
    [LinearOrderedAddCommMonoidWithTop Γ₀] : Type _

/-- **Definition 1.10** (valuation, multiplicative). A valuation `v : R → Γ₀` in the
multiplicative convention, mapping into a linearly ordered group with zero.
We extend `v` to all of `k` by `v(0) = 0` (which corresponds to `v(0) = ∞` in the
additive convention). -/
recall Valuation (R : Type*) (Γ₀ : Type*)
    [LinearOrderedCommMonoidWithZero Γ₀] [Ring R] : Type _

/-- **Definition 1.10** (value group). The smallest subgroup of `Γˣ` containing the
image of a monoid-with-zero homomorphism. For a valuation `v`, this is the value group. -/
recall MonoidWithZeroHom.valueGroup {A : Type*} {B : Type*} {F : Type*}
    [FunLike F A B] (f : F) [MonoidWithZero A] [MonoidWithZero B]
    [MonoidWithZeroHomClass F A B] : Subgroup Bˣ

/-- **Definition 1.10** (discrete valuation). A valuation is discrete if its value group
is cyclic and nontrivial — equivalently, isomorphic to `ℤ`. -/
example (R : Type*) (Γ₀ : Type*) [CommRing R] [LinearOrderedCommGroupWithZero Γ₀]
    (v : Valuation R Γ₀) [Valuation.IsRankOneDiscrete v] : True := trivial

/-- **Definition 1.10** (DVR). A *discrete valuation ring* is an integral domain that is
a local PID and not a field. -/
recall IsDiscreteValuationRing (R : Type*) [CommRing R] [IsDomain R] : Prop

/-- **Definition 1.10** (valuation ring). For every element of `Frac(A)`, either it or its
inverse lies in `A`. -/
recall ValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop

/-- **Definition 1.10** (DVR is not a field). A discrete valuation ring cannot be a field,
since `v(Frac A) = ℤ ≠ ℤ≥0 = v(A)`. -/
recall IsDiscreteValuationRing.not_isField {R : Type*} [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R] : ¬IsField R

section ValuationToAbsoluteValue

/-! ### Construction: valuation → nonarchimedean absolute value

Given a valuation `v` on a field `k` and `0 < c < 1`, the map `|x|_v = c^{v(x)}`
defines a nonarchimedean absolute value. This construction is not directly bundled
in Mathlib, but the key ingredient is `Valuation.RankOne` which provides an embedding
of the value group into `ℝ≥0`, effectively giving the same construction.

See `Mathlib.RingTheory.Valuation.RankOne` for the `Valuation.RankOne` class. -/

end ValuationToAbsoluteValue
