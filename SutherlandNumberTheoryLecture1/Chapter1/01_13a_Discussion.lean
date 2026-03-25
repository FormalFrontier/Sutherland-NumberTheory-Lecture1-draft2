import Mathlib.Tactic.Recall
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Valuation.Discrete.Basic

/-!
## Discussion following Definition 1.13 — DVR determines unique discrete valuation

Given a DVR `A` with maximal ideal `𝔪`, we can define `v(a)` as the unique `n` with
`(a) = 𝔪ⁿ`, and extend to the fraction field via `v(a/b) = v(a) - v(b)`. This gives a
discrete valuation on `k = Frac(A)` for which `A = {x ∈ k : v(x) ≥ 0}`. Moreover, this
valuation is uniquely determined: any discrete valuation on `k` with `A` as its valuation
ring must coincide with it. It follows that a uniformizer can equivalently be defined as
any generator of the maximal ideal, without reference to a valuation.

### Claims formalized

1. **Construction of v from DVR**: `IsDiscreteValuationRing.addVal` gives the additive
   valuation `v : A → ℕ∞` where `v(a) = n` iff `(a) = 𝔪ⁿ`.
2. **Extension to fraction field**: `HeightOneSpectrum.valuation` extends this to
   `k = Frac(A)` via the adic valuation of the maximal ideal.
3. **Valuation ring recovery**: `A ≃+* v.valuationSubring` — the DVR is isomorphic to
   the valuation subring of its fraction field under this valuation.
4. **Uniqueness**: The valuation on `k` with `A` as valuation ring is uniquely determined
   (the adic valuation is rank-one discrete).
5. **Uniformizer = generator of maximal ideal**: A generator of `𝔪` is a uniformizer for
   `v`, and conversely a uniformizer generates `𝔪`.
-/

section DVRValuation

/-! ### Claim 1: Additive valuation on a DVR

`IsDiscreteValuationRing.addVal R` defines `v : R → ℕ∞` by `v(a) = n` where
`(a) = 𝔪ⁿ` for the unique maximal ideal `𝔪`. This is the valuation from
the blob, restricted to `A`. -/

/-- The additive valuation on a DVR: `v(a) = n` where `(a) = 𝔪ⁿ`. -/
recall IsDiscreteValuationRing.addVal (R : Type*) [CommRing R] [IsDomain R]
    [IsDiscreteValuationRing R] : AddValuation R ℕ∞

/-! ### Claim 2: Extension to the fraction field

The adic valuation of the maximal ideal extends `addVal` to the fraction field
`K = Frac(A)`, giving a valuation `v : K → ℤₘ₀`. -/

/-- The maximal ideal of a DVR, viewed as a height-one prime (needed for the adic
valuation). -/
recall IsDiscreteValuationRing.maximalIdeal (A : Type*) [CommRing A] [IsDomain A]
    [IsDiscreteValuationRing A] : IsDedekindDomain.HeightOneSpectrum A

-- The adic valuation on the fraction field is
-- `(IsDiscreteValuationRing.maximalIdeal A).valuation K : Valuation K ℤₘ₀`
-- where `K` is a fraction ring of `A`.

/-! ### Claim 3: Valuation ring recovery

The DVR `A` is ring-isomorphic to the valuation subring `{x ∈ k : v(x) ≥ 0}`
of its fraction field under the adic valuation. -/

/-- A DVR `A` is isomorphic to the valuation subring of its fraction field
under the adic valuation. This formalizes `A = {x ∈ k : v(x) ≥ 0}`. -/
recall IsDiscreteValuationRing.equivValuationSubring (A : Type*) (K : Type*)
    [CommRing A] [IsDomain A] [IsDiscreteValuationRing A] [Field K] [Algebra A K]
    [IsFractionRing A K] :
    A ≃+* ((IsDiscreteValuationRing.maximalIdeal A).valuation K).valuationSubring

/-! ### Claim 4: The discrete valuation is uniquely determined

The adic valuation on `Frac(A)` is rank-one discrete. Since a rank-one discrete
valuation is determined by its valuation ring (up to equivalence), this is the
unique discrete valuation with `A` as valuation ring. -/

/-- The adic valuation on the fraction field of a DVR is rank-one discrete. -/
recall IsDiscreteValuationRing.isRankOneDiscrete (A : Type*) (K : Type*)
    [CommRing A] [IsDomain A] [IsDiscreteValuationRing A] [Field K] [Algebra A K]
    [IsFractionRing A K] :
    Valuation.IsRankOneDiscrete ((IsDiscreteValuationRing.maximalIdeal A).valuation K)

/-! ### Claim 5: Uniformizer = generator of maximal ideal

A generator of the maximal ideal is a uniformizer for the valuation, and conversely
a uniformizer generates the maximal ideal. This justifies defining uniformizers
without reference to a valuation. -/

/-- A generator of the maximal ideal of a discrete valuation's valuation subring
is a uniformizer. -/
recall Valuation.isUniformizer_of_maximalIdeal_eq_span
    {Γ : Type*} [LinearOrderedCommGroupWithZero Γ] {K : Type*} [Field K]
    (v : Valuation K Γ) [v.IsRankOneDiscrete] {r : v.valuationSubring}
    (hr : IsLocalRing.maximalIdeal v.valuationSubring = Ideal.span {r}) :
    v.IsUniformizer r

/-- A uniformizer generates the maximal ideal. -/
recall Valuation.IsUniformizer.is_generator
    {Γ : Type*} [LinearOrderedCommGroupWithZero Γ] {K : Type*} [Field K]
    {v : Valuation K Γ} [hv : v.IsRankOneDiscrete] {π : v.valuationSubring}
    (hπ : v.IsUniformizer π) :
    IsLocalRing.maximalIdeal v.valuationSubring = Ideal.span {π}

end DVRValuation
