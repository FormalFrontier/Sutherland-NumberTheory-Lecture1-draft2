# References for 01_14_Example

## Mathlib Coverage

**Status:** partial

The construction of ℤ_(p) as a localization is in Mathlib; the identification of maximal ideal as (p) and residue field as 𝔽_p needs to be made explicit.

### Relevant Declarations

- `Localization.AtPrime` (Mathlib.RingTheory.Localization.AtPrime)
  The localization of ℤ at a prime ideal (p), giving ℤ_(p) = {a/b : p ∤ b}.

- `IsLocalRing.ResidueField` (Mathlib.RingTheory.LocalRing.ResidueField.Defs)
  The residue field of ℤ_(p) is ℤ/pℤ ≅ 𝔽_p.
