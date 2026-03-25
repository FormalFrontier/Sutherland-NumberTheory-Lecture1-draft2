# Formalization Progress — Sutherland Number Theory Lecture 1

Human-facing summary of all completed stages. Generated 2026-03-25.

---

## Stage 1.1–1.3: PDF Extraction, Lean Build, Frontmatter Detection

**Completed:** 2026-03-25 (PR #11)

- Extracted 7 pages from the source PDF
- Initialized Lean/Lake project with Mathlib dependency; `lake build` green
- Detected frontmatter metadata

---

## Stage 1.4: Page Transcription

**Completed:** 2026-03-25 (PR #19)

- Transcribed all 7 pages to Markdown in `pages/`

---

## Stage 1.5–1.6: Structure Analysis and Blob Extraction

**Completed:** 2026-03-25 (PR #20)

- Identified 40 items in Chapter 1 (definitions, theorems, examples, remarks, discussion blobs)
- Extracted individual blob files to `blobs/Chapter1/` (68 files including `.refs.md` sidecars)
- Classified 28 items as formalizable; 12 as non-formalizable (discussions, section intros, reference lists)

---

## Stage 2.1–2.2: Dependency Analysis

**Completed:** 2026-03-25 (PR #21)

- Built internal dependency graph: `dependencies/internal.json`
- Identified external (Mathlib) dependencies: `dependencies/external.json`

---

## Stage 2.3–2.4: Mathlib Coverage and External Sources Research

**Completed:** 2026-03-25 (PR #22)

- Searched Mathlib for existing coverage of each item
- Classified items into Tier 1 (direct Mathlib), Tier 2 (Mathlib with work), Tier 3 (original proof needed)
- Documented external sources and reference attachments

---

## Stage 2.5–2.6: Readiness Report and Reference Attachment

**Completed:** 2026-03-25 (PR #23)

- Wrote `READINESS.md` with per-item verdicts and proof strategy notes
- Attached external references to blob files

---

## Stage 3.1: Lean Scaffolding

**Completed:** 2026-03-25 (PR #24)

- Created `SutherlandNumberTheoryLecture1/Chapter1.lean` root import
- Created 28 `.lean` files under `SutherlandNumberTheoryLecture1/Chapter1/`
- All 28 formalizable items have real definitions (no definition-level sorries)
- `lake build` succeeded with 3,144 jobs, zero errors
- Promoted all 28 items: `extracted` → `scaffolded`

---

## Stage 3.2: Scaffolding Review

**Completed:** 2026-03-25 (PR #25)

- Automated scan confirmed **zero definition-level sorries** across all 28 items
- Spot-checked 6 items against blob text for correctness
- Promoted all 28 items: `scaffolded` → `definition_verified`

---

## Stage 3.3: Proof Filling

**Completed:** 2026-03-25 (PRs #37, #42, #52, #56, #62, #70)

- Filled proof sorries for all 28 numbered items using Mathlib APIs and original proofs
- Key results proved:
  - `01_20_Proposition` — transitivity of integrality (`Algebra.IsIntegral.trans`)
  - `01_25_Proposition` — valuation rings are integrally closed (chain: `ValuationRing → IsBezout → GCDMonoid → IsIntegrallyClosed`)
  - `01_23_Corollary` — UFDs are integrally closed (`GCDMonoid.toIsIntegrallyClosed`)
  - `01_04_Lemma` — nonarchimedean iff bounded on ℕ (original proof filling a Mathlib gap)
  - `01_05_Corollary` — absolute values in positive characteristic; trivial on finite fields
  - `01_16_Theorem` — DVR ↔ local PID (Mathlib definitional equivalence)
- `01_24_Example` (ℤ[√5] not integrally closed): proof completed in PR #56

---

## Stage 3.4: Dependency Trimming

**Completed:** 2026-03-25 (PR #41)

- Updated `dependencies/internal.json` to store only **direct** Lean import dependencies
- Eliminated transitive closure bloat; each item lists only its actual `import` statements

---

## Stage 3.5: Proof Polishing

**Completed:** 2026-03-25 (PR #45, PR #52, PR #69)

- Simplified tactics and reduced proof size in 4 files:
  - `01_20_Proposition.lean`: one-liner term-mode proof
  - `01_25_Proposition.lean`: `Classical.choice inferInstance` replacing 3-line `Nonempty` dance
  - `01_16_Theorem.lean`: anonymous constructor replacing 5-line tactic block
  - `01_07_Definition.lean`: removed unnecessary named binding to silence linter warning
- All numbered items advanced to `proof_polished`
- Build clean (zero warnings on polished items)

---

## Stage 3.6: Upstreaming Analysis

**Completed:** 2026-03-25 (PR #53, PR #69)

- `UPSTREAMING.md` written at repository root
- Triaged all `proof_polished` items; 4 candidates identified, 24 rejected

### Upstreaming Candidates

| Item | Declaration | Reason |
|------|-------------|--------|
| `01_04_Lemma` | `sutherland_lemma1_4` | Full iff (nonarchimedean ↔ bounded on ℕ) for abstract `AbsoluteValue`; gap between `AbsoluteValue` and `NormedField` APIs |
| `01_05_Corollary` | `sutherland_corollary1_5_posChar`, `sutherland_corollary1_5_finite` | `AbsoluteValue` + `CharP` / `Fintype` results absent from Mathlib |
| `01_24_Example` | `zsqrtd5_not_integrallyClosed` | No `IsIntegrallyClosed` result for `Zsqrtd` in Mathlib |
| `01_28_Proposition` | `sutherland_prop1_28` | Full iff for minimal polynomial characterization of integrality; Mathlib has only the forward direction |

---

## Coverage Gap Remediation

**Completed:** 2026-03-25 (PRs #83, #84, #85, #86, #88, #89, #90, #96, #98)

A coverage audit identified 8 items with incomplete formalization (discussion blobs missing Lean files, definitions missing recalls). This phase addressed all gaps:

- **01_07_Definition** (PR #84): Added `Rat.AbsoluteValue.padic` recall
- **01_10_Definition** (PR #84): Added 6 declarations — `Valuation` recall, `valueGroup` recall, `IsRankOneDiscrete` example, `not_isField` recall, valuation→absolute value documentation, cross-reference comments
- **01_10a_Discussion** (PR #83): Created `.lean` file with all 6 claims — `IsDomain` instance, `AddValuation.map_inv`, `ValuationRing` property, `isUnit_iff_valuation_eq_one`, unit group, valuation trichotomy
- **01_11a_Discussion** (PR #90): Created `.lean` file with all 6 claims — uniformizer characterization, unique factorization, PID+UFD instances, `ideal_eq_span_pow_irreducible`, total order on ideals, maximal ideal = (π) and unique nonzero prime
- **01_13a_Discussion** (PR #86): Created `.lean` file with all 5 claims — `addVal`, `maximalIdeal`, `equivValuationSubring`, `isRankOneDiscrete`, uniformizer ↔ generator
- **01_15_Example** (PR #89): Added `PowerSeries.order`, `order_mul`, `order_eq_emultiplicity_X` recalls
- **01_27_Remark** (PR #85, #98): Added `NumberField.Order` structure definition; proved `NumberField.Order.le_ringOfIntegers` (last sorry in codebase)
- **CI fix** (PR #88): Fixed docgen-action failure on v4.29.0-rc8 toolchain
- **Final audit** (PR #96): Reconciled all items.json statuses with actual file states

---

## File Renaming

**Completed:** 2026-03-25 (PR #71)

- Renamed all item `.lean` files to sortable naming convention (e.g., `Lemma1_4.lean` → `01_04_Lemma.lean`)

---

## Item Status Summary

| Status | Count | Notes |
|--------|-------|-------|
| `proof_polished` | 31 | All 31 formalizable items (28 numbered + 3 discussion blobs) |
| `non_formalizable` | 1 | `01_24a_Discussion` — one-liner corollary covered by instance chain |
| `extracted` | 8 | Section intros + reference list — permanently at this status |
| **Total** | **40** | All Chapter 1 items accounted for |

---

## Build Status

`lake build` passes on `main`. All 31 formalizable items compile with zero errors, zero sorries, zero warnings.
