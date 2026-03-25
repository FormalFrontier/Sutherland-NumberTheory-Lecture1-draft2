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
| Chapter1/01.00.Introduction | Narrative introduction |
| Chapter1/01.01.Remark | Motivational context, no formalizable statement |
| Chapter1/01.02s.Introduction | Section heading text |
| Chapter1/01.03s.Introduction | Section heading text |
| Chapter1/01.04s.Introduction | Section heading text |
| Chapter1/01.05s.Introduction | Section heading text |
| Chapter1/01.06s.Introduction | Section heading text |
| Chapter1/01.10a.Discussion | Explanatory prose |
| Chapter1/01.11a.Discussion | Explanatory prose |
| Chapter1/01.13a.Discussion | Explanatory prose |
| Chapter1/01.24a.Discussion | Explanatory prose |
| Chapter1/01.99.References | Bibliography |

---

## Ready to Formalize — Full Mathlib Coverage

These items can be formalized immediately by writing Lean statements that use (or mirror) the corresponding Mathlib declarations. No new mathematical work is required.

| ID | Key Mathlib Declarations |
|----|--------------------------|
| Chapter1/01.02.Definition | `AbsoluteValue`, `IsNonarchimedean` |
| Chapter1/01.03.Example | `AbsoluteValue.abs`, `AbsoluteValue.trivial`, `Rat.AbsoluteValue.padic` |
| Chapter1/01.06.Definition | `AbsoluteValue.IsEquiv` |
| Chapter1/01.07.Definition | `padicValNat`, `padicNorm`, `Rat.AbsoluteValue.padic` |
| Chapter1/01.08.Theorem | `Rat.AbsoluteValue.equiv_real_or_padic` (Ostrowski) |
| Chapter1/01.09.Theorem | `NumberField.prod_abs_eq_one` (product formula) |
| Chapter1/01.10.Definition | `Valuation`, `IsDiscreteValuationRing`, `Valuation.integer` |
| Chapter1/01.11.Definition | `ValuationRing` |
| Chapter1/01.12.Definition | `IsLocalRing` |
| Chapter1/01.13.Definition | `IsLocalRing.ResidueField` |
| Chapter1/01.17.Definition | `IsIntegral`, `Algebra.IsIntegral` |
| Chapter1/01.18.Proposition | `IsIntegral.add`, `IsIntegral.mul` |
| Chapter1/01.19.Definition | `integralClosure`, `IsIntegrallyClosed` |
| Chapter1/01.20.Proposition | `Algebra.IsIntegral.trans` |
| Chapter1/01.21.Corollary | `integralClosure.isIntegrallyClosedOfFiniteExtension` |
| Chapter1/01.22.Proposition | `GCDMonoid.toIsIntegrallyClosed`, `Int.instIsIntegrallyClosed` |
| Chapter1/01.23.Corollary | `GCDMonoid.toIsIntegrallyClosed`, `UniqueFactorizationMonoid.instGCDMonoid` |
| Chapter1/01.25.Proposition | `Valuation.isIntegrallyClosed` |
| Chapter1/01.26.Definition | `NumberField`, `RingOfIntegers` |
| Chapter1/01.28.Proposition | `IsIntegrallyClosed.isIntegral_iff_leadingCoeff_dvd` |

---

## Needs Original Work — Partial Mathlib Coverage

These items have Mathlib support for part of the statement but require original proof work for the gaps. See the corresponding `.refs.md` files for details.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/01.04.Lemma | Converse direction: `\|n\| ≤ 1` for all n ∈ ℕ ⟹ absolute value is non-archimedean. Forward direction is in Mathlib. |
| Chapter1/01.05.Corollary | Full statement: pos. characteristic ⟹ non-archimedean; finite field ⟹ only trivial abs. value. Depends on 01.04.Lemma. |
| Chapter1/01.14.Example | Explicit identification of maximal ideal and residue field of ℤ_(p). Construction is in Mathlib. |
| Chapter1/01.15.Example | Assembling t-adic valuation on k((t)) from `PowerSeries.order`; the DVR structure of k[[t]]. |
| Chapter1/01.16.Theorem | 7-way DVR characterization. Multiple Mathlib lemmas cover subsets; full equivalence needs assembly. |
| Chapter1/01.27.Remark | 𝒪_K as free ℤ-module of rank [K:ℚ] (finiteness). Integrally closed part is in Mathlib; order/freeness is partial. |

---

## Needs Original Work — No Mathlib Coverage

These items require concrete computations with no direct Mathlib theorem. External sources are available in the `.refs.md` files.

| ID | What Needs Original Work |
|----|--------------------------|
| Chapter1/01.24.Example | Show (1+√5)/2 is integral over ℤ but not in ℤ[√5]. Concrete algebraic computation. |
| Chapter1/01.29.Example | Show (1+√7)/2 has minimal polynomial x²−x−3/2 ∉ ℤ[x] (hence not integral over ℤ). Concrete computation. |

---

## Suggested Formalization Order

Follow the book order within each tier. Items earlier in the list unblock later items.

**Tier 1 — Foundations (no dependencies on earlier Chapter 1 items):**
1. 01.02.Definition (absolute values — central definition of §1.2)
2. 01.03.Example (standard, trivial, p-adic abs. values)
3. 01.06.Definition (equivalence of absolute values)
4. 01.07.Definition (p-adic valuation and absolute value on ℚ)
5. 01.08.Theorem (Ostrowski's theorem for ℚ — can reuse Mathlib directly)
6. 01.09.Theorem (product formula — can reuse Mathlib directly)
7. 01.10.Definition (valuations and DVRs)
8. 01.11.Definition (valuation rings)
9. 01.12.Definition (local rings)
10. 01.13.Definition (residue fields)

**Tier 2 — Absolute value theory (depends on Def1_2/Def1_7):**
11. 01.04.Lemma (characterization of non-archimedean — needs original proof of converse)
12. 01.05.Corollary (depends on 01.04.Lemma)

**Tier 3 — DVR theory (depends on Def1_10–Def1_13):**
13. 01.14.Example (ℤ_(p) as a local ring with residue field 𝔽_p)
14. 01.15.Example (k[[t]] as a DVR)
15. 01.16.Theorem (DVR characterizations — complex assembly from Mathlib)

**Tier 4 — Integral closure (independent of §§1.2–1.5):**
16. 01.17.Definition (integral elements)
17. 01.18.Proposition (sum and product of integral elements are integral)
18. 01.19.Definition (integral closure, integrally closed rings)
19. 01.20.Proposition (transitivity of integrality)
20. 01.21.Corollary (integral closure is integrally closed)
21. 01.22.Proposition (ℤ is integrally closed)
22. 01.23.Corollary (UFD ⟹ integrally closed)
23. 01.24.Example (ℤ[√5] not integrally closed — needs computation)
24. 01.25.Proposition (valuation rings are integrally closed)
25. 01.26.Definition (number fields and rings of integers)
26. 01.27.Remark (𝒪_K is a free ℤ-module of rank [K:ℚ])
27. 01.28.Proposition (α integral iff min. poly. in A[x])
28. 01.29.Example (depends on 01.28.Proposition)

---

## Concerns / Infrastructure Notes

1. **01.16.Theorem complexity:** The 7-way DVR equivalence is the most complex single item. It requires assembling results from `DiscreteValuationRing.Basic`, `DedekindDomain.DVR`, and possibly `RingTheory.Noetherian`. A dedicated sub-issue with careful decomposition is recommended.

2. **01.04.Lemma converse:** The converse direction (|n| ≤ 1 for all n ⟹ non-archimedean) is not a standalone Mathlib lemma. It appears inside Ostrowski's proof. The proof strategy is in `blobs/Chapter1/01.04.Lemma.refs.md`: use the binomial theorem with a limit argument.

3. **01.24.Example and 01.29.Example:** These are concrete algebraic computations in ℤ[√5] and ℤ[√7]. Lean's `norm_num` or `decide` may handle them, but the ring ℤ[√d] may need to be set up explicitly using `Zsqrtd` from Mathlib.

4. **01.27.Remark freeness:** The fact that 𝒪_K is a free ℤ-module of rank [K:ℚ] (`NumberField.RingOfIntegers.rank`) is in Mathlib but may need careful instance assembly. The "order" concept (sub-ℤ-algebra of finite rank) is not a standalone Mathlib typeclass.

5. **Book-vs-Mathlib API alignment:** Several definitions (especially `AbsoluteValue`, `Valuation`) use bundled structures in Mathlib that may differ slightly from the lecture's formulation. Formalization agents should read the `.refs.md` notes carefully before choosing statement forms.
