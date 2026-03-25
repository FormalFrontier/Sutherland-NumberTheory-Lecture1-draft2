import Mathlib.RingTheory.Localization.AtPrime.Basic
import Mathlib.RingTheory.LocalRing.ResidueField.Basic
import Mathlib.RingTheory.Ideal.NatInt
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.DedekindDomain.Dvr
import Mathlib.Data.ZMod.QuotientRing

/-!
## Example 1.14 — The Ring `ℤ_{(p)}`

**Example 1.14.** For the `p`-adic valuation `vₚ : ℚ → ℤ ∪ {∞}`, the valuation ring is
$$ℤ_{(p)} = \{a/b ∈ ℚ ∣ a, b ∈ ℤ, p ∤ b\},$$
which is the localization of `ℤ` at the prime ideal `(p)`.
The maximal ideal is `𝔪 = (p)` and the residue field is `ℤ_{(p)}/pℤ_{(p)} ≃ 𝔽_p`.

In Mathlib, `ℤ_{(p)}` is `Localization.AtPrime (Ideal.span {(p : ℤ)})`.
The DVR property follows from `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`
since `ℤ` is a Dedekind domain.
-/

/-- The prime ideal `(p)` in `ℤ` has the `IsPrime` property when `p` is a prime natural number. -/
theorem primeIdealZ_isPrime (p : ℕ) [hp : Fact p.Prime] :
    (Ideal.span {(p : ℤ)} : Ideal ℤ).IsPrime := by
  rw [Ideal.span_singleton_prime (by exact_mod_cast hp.out.ne_zero)]
  exact Nat.prime_iff_prime_int.mp hp.out

/-- **Example 1.14.** The localization `ℤ_{(p)}` is a DVR.
This delegates to Mathlib's `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`,
which establishes the result for any Dedekind domain localized at a nonzero prime. -/
theorem localization_at_prime_is_dvr (p : ℕ) [hp : Fact p.Prime]
    (I : Ideal ℤ) [I.IsPrime] (hI : I = Ideal.span {(p : ℤ)}) :
    IsDiscreteValuationRing (Localization.AtPrime I) := by
  have hI_ne_bot : I ≠ ⊥ := by
    rw [hI, ne_eq, Ideal.span_singleton_eq_bot]
    exact mod_cast hp.out.ne_zero
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain ℤ hI_ne_bot _

/-- **Example 1.14.** The residue field of `ℤ_{(p)}` is isomorphic to `ℤ/pℤ ≃ 𝔽_p`. -/
theorem localization_at_prime_residue_field (p : ℕ) [hp : Fact p.Prime]
    (I : Ideal ℤ) [I.IsPrime] (hI : I = Ideal.span {(p : ℤ)}) :
    Nonempty (IsLocalRing.ResidueField (Localization.AtPrime I) ≃+* ZMod p) := by
  subst hI
  haveI : (Ideal.span {(p : ℤ)}).IsMaximal :=
    Ideal.IsPrime.isMaximal inferInstance (by
      rw [ne_eq, Ideal.span_singleton_eq_bot]
      exact mod_cast hp.out.ne_zero)
  exact ⟨(IsLocalization.AtPrime.equivQuotMaximalIdeal
    (Ideal.span {(p : ℤ)}) (Localization.AtPrime _)).symm.trans
    (Int.quotientSpanNatEquivZMod p)⟩
