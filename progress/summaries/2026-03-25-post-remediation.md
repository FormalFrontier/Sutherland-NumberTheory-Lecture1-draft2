# Summary: 15 PRs Merged Since Last Summary

**Period:** 2026-03-25T04:02Z – 2026-03-25T23:12Z
**Context:** After the initial Stage 3 completion, a coverage audit revealed gaps in discussion blobs and definition recalls. This summary covers the remediation phase and final project completion.

---

## Merged PRs (chronological)

| PR | Title | Category |
|----|-------|----------|
| #56 | feat: fill sorry in zsqrtd5_not_integrallyClosed (Example 1.24) | proof filling |
| #62 | Stage 3.3: Fill Example1_24 and Example1_29 | proof filling |
| #63 | End-of-project meditate: pipeline reflection | documentation |
| #66 | Fix PR #61: close stale PR and issue #60 | coordination cleanup |
| #68 | Fix PR #65: rebase or close Stage 3.5 polish | coordination cleanup |
| #71 | refactor: rename item files to sortable naming convention | refactoring |
| #69 | Stage 3.5 polish and upstreaming addendum for Example1_24 | polish |
| #70 | feat: Stage 3.3 — prove Cor1_5 finite case and Example1_24 | proof filling |
| #83 | 01_10a_Discussion: valuation ring properties — all 6 claims | coverage gap |
| #85 | Coverage gap: 01_27_Remark — order definition and maximal order | coverage gap |
| #88 | Fix CI: docgen-action fails on v4.29.0-rc8 toolchain | CI fix |
| #84 | Core valuation definitions and p-adic absolute value | coverage gap |
| #90 | Coverage gap: 01_11a_Discussion — uniformizers, PID, ideal structure | coverage gap |
| #86 | Coverage gap: 01_13a_Discussion — DVR determines unique valuation | coverage gap |
| #89 | Coverage gap: 01_15_Example — explicit valuation on k((t)) | coverage gap |
| #96 | Final coverage audit and items.json update | audit |
| #98 | Prove 01_27_Remark: NumberField.Order.le_ringOfIntegers | last sorry |

## What Changed

### Phase 1: Example1_24 completion (PRs #56, #62, #69, #70)
The hardest proof in the project — `ℤ[√5]` is not integrally closed — was completed by constructing an explicit element `(1+√5)/2` in the fraction ring, showing it's integral via `decide`, and deriving a contradiction from `Irrational (√5)`. The `Corollary1_5` finite case was also proved. The upstreaming verdict for `01_24_Example` was changed from "rejected" to "candidate" after confirming Mathlib has no `IsIntegrallyClosed` result for `Zsqrtd`.

### Phase 2: File renaming (PR #71)
All `.lean` files renamed from `Lemma1_4.lean`-style to `01_04_Lemma.lean`-style for natural sort ordering.

### Phase 3: Coverage gap remediation (PRs #83–#90, #96, #98)
A systematic audit found 8 items with incomplete formalization:
- 3 discussion blobs (`01_10a`, `01_11a`, `01_13a`) needed `.lean` files created from scratch
- 2 definitions (`01_07`, `01_10`) needed additional recall declarations
- 1 example (`01_15`) needed explicit valuation recalls
- 1 remark (`01_27`) needed a structure definition and proof (last sorry in codebase)
- CI needed a fix for docgen-action compatibility with the v4.29.0-rc8 toolchain

### Phase 4: Final proof (PR #98)
`NumberField.Order.le_ringOfIntegers` — the last remaining `sorry` — was proved using the chain: free ℤ-module of finite rank → Module.Finite → IsIntegral → in integral closure = 𝓞 K.

## Current Project State

**Zero sorries.** All 31 formalizable items are at `proof_polished`. The codebase builds cleanly.

| Status | Count |
|--------|-------|
| `proof_polished` | 31 |
| `non_formalizable` | 1 |
| `extracted` | 8 |
| **Total** | **40** |

### Lean files: 31
- 28 numbered items (definitions, theorems, propositions, corollaries, examples, remarks)
- 3 discussion blobs with original formalizations

### Upstreaming candidates: 4
1. `01_04_Lemma` — nonarchimedean ↔ bounded on ℕ (AbsoluteValue API gap)
2. `01_05_Corollary` — absolute values + CharP/Fintype
3. `01_24_Example` — `Zsqrtd 5` not integrally closed
4. `01_28_Proposition` — full iff for minimal polynomial characterization

## items.json Consistency

Verified against actual Lean files:
- All items with `proof_polished` have corresponding `.lean` files
- No orphan `.lean` files (every file has an items.json entry)
- Zero `sorry` occurrences across all 31 `.lean` files
- Two items previously at `sorry_free` (01_10a_Discussion, 01_11a_Discussion) promoted to `proof_polished`

## Remaining Open Issues

- #97: Fix merge conflicts in PR #95 (claimed — but PR #95 was already closed as duplicate; issue may be stale)
- #100: Meditate: proof quality audit (claimed by another agent)
- No unclaimed issues remain
