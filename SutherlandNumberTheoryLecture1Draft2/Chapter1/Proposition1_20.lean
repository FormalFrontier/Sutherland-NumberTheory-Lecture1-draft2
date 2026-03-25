import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_17
import SutherlandNumberTheoryLecture1Draft2.Chapter1.Definition1_19
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.RingTheory.IntegralClosure.IsIntegralClosure.Basic

/-!
## Proposition 1.20 — Transitivity of Integrality

**Proposition 1.20.** If `C/B/A` is a tower of ring extensions in which `B` is integral
over `A` and `C` is integral over `B`, then `C` is integral over `A`.

In Mathlib: `Algebra.IsIntegral.trans`.
-/

/-- **Proposition 1.20** (Sutherland). Integrality is transitive in towers of extensions. -/
theorem sutherland_prop1_20 {A B C : Type*} [CommRing A] [CommRing B] [CommRing C]
    [Algebra A B] [Algebra B C] [Algebra A C] [IsScalarTower A B C]
    (hBA : Algebra.IsIntegral A B) (hCB : Algebra.IsIntegral B C) :
    Algebra.IsIntegral A C :=
  haveI := hBA; haveI := hCB; Algebra.IsIntegral.trans (A := B)
