import Mathlib.Algebra.GCDMonoid.IntegrallyClosed
import Mathlib.RingTheory.UniqueFactorizationDomain.Basic
import Mathlib.RingTheory.UniqueFactorizationDomain.GCDMonoid

/-!
## Corollary 1.23 — UFDs are Integrally Closed

**Corollary 1.23.** Every unique factorization domain is integrally closed.
In particular, every PID is integrally closed.

*Proof.* The rational root test generalizes from `ℤ` to any UFD.

In Mathlib: the instance chain `UFD → GCDMonoid → IsIntegrallyClosed`.
-/

/-- **Corollary 1.23.** Every UFD is integrally closed. -/
example {A : Type*} [CommRing A] [IsDomain A] [UniqueFactorizationMonoid A] :
    IsIntegrallyClosed A := inferInstance

/-- **Corollary 1.23.** In particular, every PID is integrally closed. -/
example {A : Type*} [CommRing A] [IsDomain A] [IsPrincipalIdealRing A] :
    IsIntegrallyClosed A := inferInstance
