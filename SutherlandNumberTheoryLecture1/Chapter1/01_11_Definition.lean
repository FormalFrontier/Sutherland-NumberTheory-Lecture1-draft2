import Mathlib.Tactic.Recall
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
## Definition 1.11 — Valuation Rings

**Definition 1.11.** A *valuation ring* is an integral domain `A` with fraction field `k`
such that for every `x ∈ k`, either `x ∈ A` or `x⁻¹ ∈ A`.

### Mathlib correspondence

This is `ValuationRing A` in Mathlib, defined via the equivalent condition:
for every `a b : A`, either `a ∣ b` or `b ∣ a`.
-/

/-- **Definition 1.11.** A *valuation ring* is an integral domain where for every pair
of elements, one divides the other. -/
recall ValuationRing (A : Type*) [CommRing A] [IsDomain A] : Prop
