import SutherlandNumberTheoryLecture1.Chapter1.Definition1_17
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
## Definition 1.19 — Integral Closure and Integrally Closed Rings

**Definition 1.19.** Given a ring extension `B/A`, the *integral closure of `A` in `B`*
is `Ã = {b ∈ B | b is integral over A}`.
When `Ã = A`, we say `A` is *integrally closed in `B`*.
For a domain `A`, its *integral closure* is its integral closure in `Frac(A)`,
and `A` is *integrally closed* (or *normal*) if it equals its integral closure in `Frac(A)`.

In Mathlib:
- `integralClosure A B` is the integral closure of `A` in `B`
- `IsIntegrallyClosed A` means `A` is integrally closed in `Frac(A)`
-/

/-- The *integral closure* of `A` in `B` (Sutherland Def 1.19).
In Mathlib: `integralClosure A B`. -/
abbrev IntegralClosure' (A B : Type*) [CommRing A] [CommRing B] [Algebra A B] :=
  integralClosure A B

/-- A domain `A` is *integrally closed* (Sutherland Def 1.19) if it equals
its integral closure in its fraction field.
In Mathlib: `IsIntegrallyClosed A`. -/
def IsNormal (A : Type*) [CommRing A] [IsDomain A] : Prop :=
  IsIntegrallyClosed A
