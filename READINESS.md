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
| Chapter1/Introduction | Narrative introduction |
| Chapter1/Remark1_1 | Motivational context, no formalizable statement |
| Chapter1/Section1_2_Intro | Section heading text |
| Chapter1/Section1_3_Intro | Section heading text |
| Chapter1/Section1_4_Intro | Section heading text |
| Chapter1/Section1_5_Intro | Section heading text |
| Chapter1/Section1_6_Intro | Section heading text |
| Chapter1/Discussion_after_Definition1_10 | Explanatory prose |
| Chapter1/Discussion_after_Definition1_11 | Explanatory prose |
| Chapter1/Discussion_after_Definition1_13 | Explanatory prose |
| Chapter1/Discussion_after_Example1_24 | Explanatory prose |
| Chapter1/References | Bibliography |

---

## Ready to Formalize — Full Mathlib Coverage

These items can be formalized immediately by writing Lean statements that use (or mirror) the corresponding Mathlib declarations. No new mathematical work is required.

| ID | Key Mathlib Declarations |
|----|--------------------------|
| Chapter1/Definition1_2 | `AbsoluteValue`, `IsNonarchimedean` |
| Chapter1/Example1_3 | `AbsoluteValue.abs`, `AbsoluteValue.trivial`, `Rat.AbsoluteValue.padic` |
| Chapter1/Definition1_6 | `AbsoluteValue.IsEquiv` |
| Chapter1/Definition1_7 | `padicValNat`, `padicNorm`, `Rat.AbsoluteValue.padic` |
| Chapter1/Theorem1_8 | `Rat.AbsoluteValue.equiv_real_or_padic` (Ostrowski) |
| Chapter1/Theorem1_9 | `NumberField.prod_abs_eq_one` (product formula) |
| Chapter1/Definition1_10 | `Valuation`, `IsDiscreteValuationRing`, `Valuation.integer` |
| Chapter1/Definition1_11 | `ValuationRing` |
| Chapter1/Definition1_12 | `IsLocalRing` |
| Chapter1/Definition1_13 | `IsLocalRing.ResidueField` |
| Chapter1/Definition1_17 | `IsIntegral`, `Algebra.IsIntegral` |
| Chapter1/Proposition1_18 | `IsIntegral.add`, `IsIntegral.mul` |
| Chapter1/Definition1_19 | `integralClosure`, `IsIntegrallyClosed` |
| Chapter1/Proposition1_20 | `Algebra.IsIntegral.trans` |
| Chapter1/Corollary1_21 | `integralClosure.isIntegrallyClosedOfFiniteExtension` |
| Chapter1/Proposition1_22 | `GCDMonoid.toIsIntegrallyClosed`, `Int.instIsIntegrallyClosed` |
| Chapter1/Corollary1_23 | `GCDMonoid.toIsIntegrallyClosed`, `UniqueFactorizationMonoid.instGCDMonoid` |
| Chapter1/Proposition1_25 | `Valuation.isIntegrallyClosed` |
| Chapter1/Definition1_26 | `NumberField`, `RingOfIntegers` |
| Chapter1/Proposition1_28 | `IsIntegrallyClosed.isIntegral_iff_leadingCoeff_dvd` |

---

## Needs Original Work — Partial Mathlib Coverage

These items have Mathlib support for part of the statement but require original proof work for the gaps. See the corresponding `.refs.md` files for details.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/Lemma1_4 | Converse direction: `\|n\| ≤ 1` for all n ∈ ℕ ⟹ absolute value is non-archimedean. Forward direction is in Mathlib. |
| Chapter1/Corollary1_5 | Full statement: pos. characteristic ⟹ non-archimedean; finite field ⟹ only trivial abs. value. Depends on Lemma1_4. |
| Chapter1/Example1_14 | Explicit identification of maximal ideal and residue field of ℤ_(p). Construction is in Mathlib. |
| Chapter1/Example1_15 | Assembling t-adic valuation on k((t)) from `PowerSeries.order`; the DVR structure of k[[t]]. |
| Chapter1/Theorem1_16 | 7-way DVR characterization. Multiple Mathlib lemmas cover subsets; full equivalence needs assembly. |
| Chapter1/Remark1_27 | 𝒪_K as free ℤ-module of rank [K:ℚ] (finiteness). Integrally closed part is in Mathlib; order/freeness is partial. |

---

## Needs Original Work — No Mathlib Coverage

These items require concrete computations with no direct Mathlib theorem. External sources are available in the `.refs.md` files.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/Example1_24 | Show (1+√5)/2 is integral over ℤ but not in ℤ[√5]. Concrete algebraic computation. |
| Chapter1/Example1_29 | Show (1+√7)/2 has minimal polynomial x²−x−3/2 ∉ ℤ[x] (hence not integral over ℤ). Concrete computation. |

---

## Suggested Formalization Order

Follow the book order within each tier. Items earlier in the list unblock later items.

**Tier 1 — Foundations (no dependencies on earlier Chapter 1 items):**
1. Definition1_2 (absolute values — central definition of §1.2)
2. Example1_3 (standard, trivial, p-adic abs. values)
3. Definition1_6 (equivalence of absolute values)
4. Definition1_7 (p-adic valuation and absolute value on ℚ)
5. Theorem1_8 (Ostrowski's theorem for ℚ — can reuse Mathlib directly)
6. Theorem1_9 (product formula — can reuse Mathlib directly)
7. Definition1_10 (valuations and DVRs)
8. Definition1_11 (valuation rings)
9. Definition1_12 (local rings)
10. Definition1_13 (residue fields)

**Tier 2 — Absolute value theory (depends on Def1_2/Def1_7):**
11. Lemma1_4 (characterization of non-archimedean — needs original proof of converse)
12. Corollary1_5 (depends on Lemma1_4)

**Tier 3 — DVR theory (depends on Def1_10–Def1_13):**
13. Example1_14 (ℤ_(p) as a local ring with residue field 𝔽_p)
14. Example1_15 (k[[t]] as a DVR)
15. Theorem1_16 (DVR characterizations — complex assembly from Mathlib)

**Tier 4 — Integral closure (independent of §§1.2–1.5):**
16. Definition1_17 (integral elements)
17. Proposition1_18 (sum and product of integral elements are integral)
18. Definition1_19 (integral closure, integrally closed rings)
19. Proposition1_20 (transitivity of integrality)
20. Corollary1_21 (integral closure is integrally closed)
21. Proposition1_22 (ℤ is integrally closed)
22. Corollary1_23 (UFD ⟹ integrally closed)
23. Example1_24 (ℤ[√5] not integrally closed — needs computation)
24. Proposition1_25 (valuation rings are integrally closed)
25. Definition1_26 (number fields and rings of integers)
26. Remark1_27 (𝒪_K is a free ℤ-module of rank [K:ℚ])
27. Proposition1_28 (α integral iff min. poly. in A[x])
28. Example1_29 (depends on Proposition1_28)

---

## Concerns / Infrastructure Notes

1. **Theorem1_16 complexity:** The 7-way DVR equivalence is the most complex single item. It requires assembling results from `DiscreteValuationRing.Basic`, `DedekindDomain.DVR`, and possibly `RingTheory.Noetherian`. A dedicated sub-issue with careful decomposition is recommended.

2. **Lemma1_4 converse:** The converse direction (|n| ≤ 1 for all n ⟹ non-archimedean) is not a standalone Mathlib lemma. It appears inside Ostrowski's proof. The proof strategy is in `blobs/Chapter1/Lemma1_4.refs.md`: use the binomial theorem with a limit argument.

3. **Example1_24 and Example1_29:** These are concrete algebraic computations in ℤ[√5] and ℤ[√7]. Lean's `norm_num` or `decide` may handle them, but the ring ℤ[√d] may need to be set up explicitly using `Zsqrtd` from Mathlib.

4. **Remark1_27 freeness:** The fact that 𝒪_K is a free ℤ-module of rank [K:ℚ] (`NumberField.RingOfIntegers.rank`) is in Mathlib but may need careful instance assembly. The "order" concept (sub-ℤ-algebra of finite rank) is not a standalone Mathlib typeclass.

5. **Book-vs-Mathlib API alignment:** Several definitions (especially `AbsoluteValue`, `Valuation`) use bundled structures in Mathlib that may differ slightly from the lecture's formulation. Formalization agents should read the `.refs.md` notes carefully before choosing statement forms.
