import Mathlib.RingTheory.Valuation.ValuationRing

/-!
## Definition 1.11 — Valuation Rings

**Definition 1.11.** A *valuation ring* is an integral domain `A` with fraction field `k`
such that for every `x ∈ k`, either `x ∈ A` or `x⁻¹ ∈ A`.

In Mathlib: `ValuationRing`.
-/

/-- A *valuation ring* (Sutherland Def 1.11) is an integral domain `A` such that
for every element of its fraction field, either it or its inverse lies in `A`.
In Mathlib: `ValuationRing`. -/
def IsValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop :=
  ValuationRing A
