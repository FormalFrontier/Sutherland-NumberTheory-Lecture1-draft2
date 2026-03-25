# References for 01_16_Theorem

## Mathlib Coverage

**Status:** partial

Several of the equivalences in Theorem 1.16 are provable from Mathlib. The full 7-way equivalence stated in the lecture needs to be assembled from multiple Mathlib lemmas.

### Relevant Declarations

- `IsDiscreteValuationRing` (Mathlib.RingTheory.DiscreteValuationRing.Basic)
  The DVR class in Mathlib is defined as: local PID that is not a field.

- `DiscreteValuationRing.iff_pid_with_one_nonzero_prime` (Mathlib.RingTheory.DiscreteValuationRing.Basic)
  DVR iff PID with unique nonzero prime ideal.

- `IsDedekindDomain.isDVR_of_onlyOnePrime` (Mathlib.RingTheory.DedekindDomain.DVR)
  Characterizes DVRs among Dedekind domains (noetherian integrally closed dim ≤ 1).

## Gaps / Original Work Needed

- The full 7-way equivalence for DVRs as stated in the lecture. Mathlib has several of these but not all bundled as a single theorem.

## External Sources

- **Sutherland lecture notes, Theorem 1.16**
  The proof of each equivalence is standard algebra. Mathlib contains: DVR = local PID (the base definition), and can build the characterization via Noetherian valuation rings, integrally closed Noetherian local rings of dimension 1, regular Noetherian local rings of dimension 1.

- **Serre, Local Fields, Chapter I**
  Detailed treatment of DVR characterizations.
