import SutherlandNumberTheoryLecture1.Chapter1.Proposition1_22
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.RingTheory.UniqueFactorizationDomain.Basic
import Mathlib.RingTheory.UniqueFactorizationDomain.GCDMonoid

/-!
## Corollary 1.23 — UFDs are Integrally Closed

**Corollary 1.23.** Every unique factorization domain is integrally closed.
In particular, every PID is integrally closed.

*Proof.* The proof of Proposition 1.22 (rational root test) works for any UFD.

In Mathlib: `GCDMonoid.toIsIntegrallyClosed`.
-/

/-- **Corollary 1.23** (Sutherland). Every UFD is integrally closed. -/
theorem sutherland_corollary1_23 (A : Type*) [CommRing A] [IsDomain A]
    [UniqueFactorizationMonoid A] :
    IsIntegrallyClosed A :=
  inferInstance

/-- **Corollary 1.23** (Sutherland). Every PID is integrally closed. -/
theorem sutherland_corollary1_23_pid (A : Type*) [CommRing A] [IsDomain A]
    [IsPrincipalIdealRing A] :
    IsIntegrallyClosed A :=
  inferInstance
