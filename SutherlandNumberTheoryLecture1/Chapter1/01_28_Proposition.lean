import SutherlandNumberTheoryLecture1.Chapter1.«01_19_Definition»
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed

/-!
## Proposition 1.28 — Integrality and Minimal Polynomials

**Proposition 1.28.** Let `A` be an integrally closed domain with fraction field `K`.
Let `α` be an element of a finite extension `L/K`, with minimal polynomial `f ∈ K[x]`.
Then `α` is integral over `A` if and only if `f ∈ A[x]`.

*Proof (⟹).* Each conjugate `αᵢ` of `α` is also integral over `A` (via the same monic poly).
The coefficients of `f` are symmetric functions of the `αᵢ`,
hence in `integralClosure A K̄ ∩ K = A`.

In Mathlib: `IsIntegrallyClosed.isIntegral_iff` and related lemmas in `Minpoly.IsIntegrallyClosed`.
-/

/-- **Proposition 1.28** (Sutherland). For an integrally closed domain `A` with fraction
field `K`, an element `α` of a finite extension `L/K` is integral over `A` iff
its minimal polynomial over `K` has coefficients in `A`.

Uses `minpoly.isIntegrallyClosed_eq_field_fractions'`. -/
theorem sutherland_prop1_28 {A K L : Type*} [CommRing A] [IsDomain A] [IsIntegrallyClosed A]
    [Field K] [Field L] [Algebra A K] [IsFractionRing A K]
    [Algebra K L] [Algebra A L] [IsScalarTower A K L]
    [FiniteDimensional K L] (α : L) :
    IsIntegral A α ↔
      (minpoly A α).map (algebraMap A K) = minpoly K α := by
  constructor
  · intro h
    exact (minpoly.isIntegrallyClosed_eq_field_fractions' (R := A) (K := K) h).symm
  · intro h
    by_contra hnotint
    rw [minpoly.eq_zero hnotint, Polynomial.map_zero] at h
    haveI : Algebra.IsIntegral K L := Algebra.IsIntegral.of_finite K L
    have hK : IsIntegral K α := Algebra.IsIntegral.isIntegral α
    exact (minpoly.monic hK).ne_zero h.symm
