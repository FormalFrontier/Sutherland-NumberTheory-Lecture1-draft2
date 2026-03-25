import Mathlib.Tactic.Recall
import Mathlib.RingTheory.LocalRing.Basic

/-!
## Definition 1.12 — Local Rings

**Definition 1.12.** A *local ring* is a commutative ring with a unique maximal ideal.

### Mathlib correspondence

This is `IsLocalRing A` in Mathlib, defined as: a nontrivial ring where `a + b = 1`
implies `a` is a unit or `b` is a unit (equivalent to unique maximal ideal).
-/

/-- **Definition 1.12.** A *local ring* is a nontrivial ring where `a + b = 1` implies
`a` or `b` is a unit. -/
recall IsLocalRing (R : Type*) [Semiring R] : Prop
