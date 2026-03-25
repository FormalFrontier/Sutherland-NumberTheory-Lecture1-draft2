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

**Completed:** 2026-03-25 (PRs #37, #42, #52, #56)

- Filled proof sorries for 27 of 28 items using Mathlib APIs and original proofs
- Key results proved:
  - `01.20.Proposition` — transitivity of integrality (`Algebra.IsIntegral.trans`)
  - `01.25.Proposition` — valuation rings are integrally closed (chain: `ValuationRing → IsBezout → GCDMonoid → IsIntegrallyClosed`)
  - `01.23.Corollary` — UFDs are integrally closed (`GCDMonoid.toIsIntegrallyClosed`)
  - `01.04.Lemma` — nonarchimedean iff bounded on ℕ (original proof filling a Mathlib gap)
  - `01.05.Corollary` — absolute values in positive characteristic; trivial on finite fields
  - `01.16.Theorem` — DVR ↔ local PID (Mathlib definitional equivalence)
- `01.24.Example` (ℤ[√5] not integrally closed): proof completed in PR #56

---

## Stage 3.4: Dependency Trimming

**Completed:** 2026-03-25 (PR #41)

- Updated `dependencies/internal.json` to store only **direct** Lean import dependencies
- Eliminated transitive closure bloat; each item lists only its actual `import` statements

---

## Stage 3.5: Proof Polishing

**Completed:** 2026-03-25 (PR #45, PR #52)

- Simplified tactics and reduced proof size in 4 files:
  - `01.20.Proposition.lean`: one-liner term-mode proof
  - `01.25.Proposition.lean`: `Classical.choice inferInstance` replacing 3-line `Nonempty` dance
  - `01.16.Theorem.lean`: anonymous constructor replacing 5-line tactic block
  - `01.07.Definition.lean`: removed unnecessary named binding to silence linter warning
- All 27 items advanced to `proof_polished`
- Build clean (zero warnings on polished items)

---

## Stage 3.6: Upstreaming Analysis

**Completed:** 2026-03-25 (PR #53)

- `UPSTREAMING.md` written at repository root
- Triaged all 27 `proof_polished` items; 3 candidates identified, 24 rejected

### Upstreaming Candidates

| Item | Declaration | Reason |
|------|-------------|--------|
| `01.04.Lemma` | `sutherland_lemma1_4` | Full iff (nonarchimedean ↔ bounded on ℕ) for abstract `AbsoluteValue`; gap between `AbsoluteValue` and `NormedField` APIs |
| `01.05.Corollary` | `sutherland_corollary1_5_posChar`, `sutherland_corollary1_5_finite` | `AbsoluteValue` + `CharP` / `Fintype` results absent from Mathlib |
| `01.28.Proposition` | `sutherland_prop1_28` | Full iff for minimal polynomial characterization of integrality; Mathlib has only the forward direction |

---

## Item Status Summary

| Status | Count | Notes |
|--------|-------|-------|
| `proof_polished` | 28 | All 28 formalizable items |
| `extracted` | 12 | Non-formalizable items (discussions, section intros, reference lists) — permanently at this status |
| **Total** | **40** | All Chapter 1 items accounted for |

---

## Build Status

`lake build` passes on `main`. All 28 `proof_polished` items compile with zero warnings.
