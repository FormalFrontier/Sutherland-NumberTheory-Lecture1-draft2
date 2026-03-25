# Formalization Readiness Report

**Generated:** 2026-03-25 (Stage 2.5)
**Source:** `research/mathlib-coverage.json`, `research/external-sources.json`, `blobs/Chapter1/`

---

## Summary

- **40 total items** in Chapter 1
- **12 non-formalizable** (section intros, discussion blobs, references)
- **28 formalizable** items (definitions, theorems, lemmas, propositions, examples, remarks)
  - **20 fully covered** by Mathlib — these can be formalized as wrappers or existence proofs pointing at Mathlib
  - **6 partially covered** by Mathlib — require original proof work for gaps
  - **2 require entirely original work** (no Mathlib coverage, but external sources available)

---

## Non-Formalizable Items (skip in Phase 3)

These are discussion blobs, section introductions, or reference lists with no mathematical content to formalize.

| ID | Reason |
|----|--------|
| Chapter1/01_00_Introduction | Narrative introduction |
| Chapter1/01_01_Remark | Motivational context, no formalizable statement |
| Chapter1/01_02s_Introduction | Section heading text |
| Chapter1/01_03s_Introduction | Section heading text |
| Chapter1/01_04s_Introduction | Section heading text |
| Chapter1/01_05s_Introduction | Section heading text |
| Chapter1/01_06s_Introduction | Section heading text |
| Chapter1/01_10a_Discussion | Explanatory prose |
| Chapter1/01_11a_Discussion | Explanatory prose |
| Chapter1/01_13a_Discussion | Explanatory prose |
| Chapter1/01_24a_Discussion | Explanatory prose |
| Chapter1/01_99_References | Bibliography |

---

## Ready to Formalize — Full Mathlib Coverage

These items can be formalized immediately by writing Lean statements that use (or mirror) the corresponding Mathlib declarations. No new mathematical work is required.

| ID | Key Mathlib Declarations |
|----|--------------------------|
| Chapter1/01_02_Definition | `AbsoluteValue`, `IsNonarchimedean` |
| Chapter1/01_03_Example | `AbsoluteValue.abs`, `AbsoluteValue.trivial`, `Rat.AbsoluteValue.padic` |
| Chapter1/01_06_Definition | `AbsoluteValue.IsEquiv` |
| Chapter1/01_07_Definition | `padicValNat`, `padicNorm`, `Rat.AbsoluteValue.padic` |
| Chapter1/01_08_Theorem | `Rat.AbsoluteValue.equiv_real_or_padic` (Ostrowski) |
| Chapter1/01_09_Theorem | `NumberField.prod_abs_eq_one` (product formula) |
| Chapter1/01_10_Definition | `Valuation`, `IsDiscreteValuationRing`, `Valuation.integer` |
| Chapter1/01_11_Definition | `ValuationRing` |
| Chapter1/01_12_Definition | `IsLocalRing` |
| Chapter1/01_13_Definition | `IsLocalRing.ResidueField` |
| Chapter1/01_17_Definition | `IsIntegral`, `Algebra.IsIntegral` |
| Chapter1/01_18_Proposition | `IsIntegral.add`, `IsIntegral.mul` |
| Chapter1/01_19_Definition | `integralClosure`, `IsIntegrallyClosed` |
| Chapter1/01_20_Proposition | `Algebra.IsIntegral.trans` |
| Chapter1/01_21_Corollary | `integralClosure.isIntegrallyClosedOfFiniteExtension` |
| Chapter1/01_22_Proposition | `GCDMonoid.toIsIntegrallyClosed`, `Int.instIsIntegrallyClosed` |
| Chapter1/01_23_Corollary | `GCDMonoid.toIsIntegrallyClosed`, `UniqueFactorizationMonoid.instGCDMonoid` |
| Chapter1/01_25_Proposition | `Valuation.isIntegrallyClosed` |
| Chapter1/01_26_Definition | `NumberField`, `RingOfIntegers` |
| Chapter1/01_28_Proposition | `IsIntegrallyClosed.isIntegral_iff_leadingCoeff_dvd` |

---

## Needs Original Work — Partial Mathlib Coverage

These items have Mathlib support for part of the statement but require original proof work for the gaps. See the corresponding `.refs.md` files for details.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/01_04_Lemma | Converse direction: `\|n\| ≤ 1` for all n ∈ ℕ ⟹ absolute value is non-archimedean. Forward direction is in Mathlib. |
| Chapter1/01_05_Corollary | Full statement: pos. characteristic ⟹ non-archimedean; finite field ⟹ only trivial abs. value. Depends on 01_04_Lemma. |
| Chapter1/01_14_Example | Explicit identification of maximal ideal and residue field of ℤ_(p). Construction is in Mathlib. |
| Chapter1/01_15_Example | Assembling t-adic valuation on k((t)) from `PowerSeries.order`; the DVR structure of k[[t]]. |
| Chapter1/01_16_Theorem | 7-way DVR characterization. Multiple Mathlib lemmas cover subsets; full equivalence needs assembly. |
| Chapter1/01_27_Remark | 𝒪_K as free ℤ-module of rank [K:ℚ] (finiteness). Integrally closed part is in Mathlib; order/freeness is partial. |

---

## Needs Original Work — No Mathlib Coverage

These items require concrete computations with no direct Mathlib theorem. External sources are available in the `.refs.md` files.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/01_24_Example | Show (1+√5)/2 is integral over ℤ but not in ℤ[√5]. Concrete algebraic computation. |
| Chapter1/01_29_Example | Show (1+√7)/2 has minimal polynomial x²−x−3/2 ∉ ℤ[x] (hence not integral over ℤ). Concrete computation. |

---

## Suggested Formalization Order

Follow the book order within each tier. Items earlier in the list unblock later items.

**Tier 1 — Foundations (no dependencies on earlier Chapter 1 items):**
1. 01_02_Definition (absolute values — central definition of §1.2)
2. 01_03_Example (standard, trivial, p-adic abs. values)
3. 01_06_Definition (equivalence of absolute values)
4. 01_07_Definition (p-adic valuation and absolute value on ℚ)
5. 01_08_Theorem (Ostrowski's theorem for ℚ — can reuse Mathlib directly)
6. 01_09_Theorem (product formula — can reuse Mathlib directly)
7. 01_10_Definition (valuations and DVRs)
8. 01_11_Definition (valuation rings)
9. 01_12_Definition (local rings)
10. 01_13_Definition (residue fields)

**Tier 2 — Absolute value theory (depends on Def1_2/Def1_7):**
11. 01_04_Lemma (characterization of non-archimedean — needs original proof of converse)
12. 01_05_Corollary (depends on 01_04_Lemma)

**Tier 3 — DVR theory (depends on Def1_10–Def1_13):**
13. 01_14_Example (ℤ_(p) as a local ring with residue field 𝔽_p)
14. 01_15_Example (k[[t]] as a DVR)
15. 01_16_Theorem (DVR characterizations — complex assembly from Mathlib)

**Tier 4 — Integral closure (independent of §§1.2–1.5):**
16. 01_17_Definition (integral elements)
17. 01_18_Proposition (sum and product of integral elements are integral)
18. 01_19_Definition (integral closure, integrally closed rings)
19. 01_20_Proposition (transitivity of integrality)
20. 01_21_Corollary (integral closure is integrally closed)
21. 01_22_Proposition (ℤ is integrally closed)
22. 01_23_Corollary (UFD ⟹ integrally closed)
23. 01_24_Example (ℤ[√5] not integrally closed — needs computation)
24. 01_25_Proposition (valuation rings are integrally closed)
25. 01_26_Definition (number fields and rings of integers)
26. 01_27_Remark (𝒪_K is a free ℤ-module of rank [K:ℚ])
27. 01_28_Proposition (α integral iff min. poly. in A[x])
28. 01_29_Example (depends on 01_28_Proposition)

---

## Concerns / Infrastructure Notes

1. **01_16_Theorem complexity:** The 7-way DVR equivalence is the most complex single item. It requires assembling results from `DiscreteValuationRing.Basic`, `DedekindDomain.DVR`, and possibly `RingTheory.Noetherian`. A dedicated sub-issue with careful decomposition is recommended.

2. **01_04_Lemma converse:** The converse direction (|n| ≤ 1 for all n ⟹ non-archimedean) is not a standalone Mathlib lemma. It appears inside Ostrowski's proof. The proof strategy is in `blobs/Chapter1/01_04_Lemma.refs.md`: use the binomial theorem with a limit argument.

3. **01_24_Example and 01_29_Example:** These are concrete algebraic computations in ℤ[√5] and ℤ[√7]. Lean's `norm_num` or `decide` may handle them, but the ring ℤ[√d] may need to be set up explicitly using `Zsqrtd` from Mathlib.

4. **01_27_Remark freeness:** The fact that 𝒪_K is a free ℤ-module of rank [K:ℚ] (`NumberField.RingOfIntegers.rank`) is in Mathlib but may need careful instance assembly. The "order" concept (sub-ℤ-algebra of finite rank) is not a standalone Mathlib typeclass.

5. **Book-vs-Mathlib API alignment:** Several definitions (especially `AbsoluteValue`, `Valuation`) use bundled structures in Mathlib that may differ slightly from the lecture's formulation. Formalization agents should read the `.refs.md` notes carefully before choosing statement forms.
