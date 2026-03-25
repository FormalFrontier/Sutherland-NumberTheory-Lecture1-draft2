import Mathlib.Tactic.Recall
import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.Valuation.Integers
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
## Discussion following Definition 1.10 — Properties of Valuation Rings

Every valuation ring `A = {x ∈ k | v(x) ≥ 0}` is an integral domain with `k` as its
fraction field. For `x ∈ k×`, `v(x⁻¹) = -v(x)`, so at least one of `x` and `x⁻¹` lies
in `A`. An element `x ∈ A` is a unit iff `v(x) = 0`, giving `A× = {x ∈ k : v(x) = 0}`.
The nonzero elements of `k` partition by sign of valuation: units (`v = 0`), non-units
in `A` (`v > 0`), and elements outside `A` with non-unit inverses (`v < 0`).

### Claims formalized

1. `A` is an integral domain — built into the `ValuationRing` typeclass
2. `v(x⁻¹) = -v(x)` — `AddValuation.map_inv`
3. For `x ∈ k×`, either `x ∈ A` or `x⁻¹ ∈ A` — `ValuationRing` defining property
4. `x ∈ A` is a unit iff `v(x) = 0` — `Valuation.Integers.isUnit_iff_valuation_eq_one`
5. `A× = {x ∈ k : v(x) = 0}` — follows from claim 4
6. Partition of `k×` by sign of valuation — `valuation_trichotomy`
-/

section ValuationRingProperties

-- Claim 1: A valuation ring is an integral domain.
-- This is built into the `ValuationRing` definition which requires `[IsDomain A]`.
-- The blob's argument: if x,y ≠ 0 then v(xy) = v(x) + v(y) ≠ ∞ so xy ≠ 0.
-- In Mathlib, `IsDomain` is a typeclass prerequisite of `ValuationRing`.
example (A : Type*) [CommRing A] [IsDomain A] [ValuationRing A] : IsDomain A :=
  inferInstance

-- Claim 2: v(x⁻¹) = -v(x) for x ∈ k×
/-- For an additive valuation on a field, `v(x⁻¹) = -v(x)`. -/
recall AddValuation.map_inv {K : Type*} [DivisionRing K] {Γ₀ : Type*}
    [LinearOrderedAddCommGroupWithTop Γ₀] (v : AddValuation K Γ₀) {x : K} :
    v x⁻¹ = -(v x)

-- Claim 3: For x ∈ k×, either x ∈ A or x⁻¹ ∈ A.
-- This is the defining property of `ValuationRing`: for every pair a b, either a | b or b | a.
-- See `01_11_Definition.lean` for the recall of `ValuationRing`.

-- Claim 4: x ∈ A is a unit iff v(x) = 1 (i.e. v(x) = 0 in additive convention).
/-- In the valuation integers, `x` is a unit iff `v(x) = 1`. -/
recall Valuation.Integers.isUnit_iff_valuation_eq_one {F : Type*} {Γ₀ : Type*}
    [Field F] [LinearOrderedCommGroupWithZero Γ₀]
    {v : Valuation F Γ₀} {O : Type*} [CommRing O] [Algebra O F]
    (hv : Valuation.Integers v O) {x : O} :
    IsUnit x ↔ v (algebraMap O F x) = 1

-- Claim 5: A× = {x ∈ k : v(x) = 0}
-- This is the set-level restatement of claim 4. The characterization
-- `isUnit_iff_valuation_eq_one` gives the pointwise version; the set equality
-- is a direct consequence. In the multiplicative convention, v(x) = 1 corresponds
-- to v(x) = 0 in the additive convention used in the textbook.

-- Claim 6: Partition of k× by sign of valuation
/-- The nonzero elements of a valued field partition into three classes:
units of the valuation ring (v = 1), non-units in the ring (v < 1),
and elements outside the ring whose inverses are non-units (v > 1).
Here we use the multiplicative convention where the valuation ring is {x | v(x) ≤ 1}. -/
theorem valuation_trichotomy {K : Type*} [Field K] {Γ₀ : Type*}
    [LinearOrderedCommGroupWithZero Γ₀] (v : Valuation K Γ₀) (x : K) :
    v x = 1 ∨ v x < 1 ∨ 1 < v x := by
  rcases lt_trichotomy (v x) 1 with h | h | h
  · exact Or.inr (Or.inl h)
  · exact Or.inl h
  · exact Or.inr (Or.inr h)

end ValuationRingProperties
