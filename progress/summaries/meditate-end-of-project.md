# End-of-Project Meditate: FormalFrontier Pipeline Reflection

**Project:** Sutherland Number Theory Lecture 1 (Chapter 1)
**Completed:** 2026-03-25
**Scope:** 28 formalizable items across 16 merged PRs, stages 1.1–3.6

---

## 1. Pipeline Quality: Stage-by-Stage Assessment

### Stage 1.1–1.3: PDF Extraction, Build Init, Frontmatter (PR #11)

**Worked well:** Single PR packaged three lightweight tasks efficiently. Lean/Lake project initialization with Mathlib dependency resolved cleanly on the first attempt.

**Friction:** None notable. These infrastructure tasks are well-suited to a single focused session and benefit from being combined into one PR.

### Stage 1.4: Page Transcription (PR #19)

**Worked well:** Mechanical work — transcribe 7 pages to Markdown. A single agent handled all 7 pages without difficulty. Output was clean enough that Stage 1.5 (structure analysis) required no corrections to the transcription.

**Friction:** None. This is pure data entry with no judgment calls.

### Stage 1.5–1.6: Structure Analysis and Blob Extraction (PR #20)

**Worked well:** Combined stages worked naturally together — identifying items and extracting them to files are tightly coupled tasks. Identified 40 items (28 formalizable, 12 non-formalizable) with accurate classification.

**Friction:** The instruction "Every byte of the book must belong to exactly one blob" requires careful attention. The `.refs.md` sidecar pattern for reference lists was a good solution discovered during this stage, but required judgment not specified in the original plan.

**Lesson learned:** Stage 1.5 instructions should explicitly note that unstructured discussion between numbered items is also a blob type, requiring its own entry. The CLAUDE.md now includes this ("Discussion Blobs Are First-Class").

### Stage 2.1–2.4: Dependency Analysis and Mathlib Coverage (PRs #21–#22)

**Worked well:** The tiered Mathlib coverage classification (Tier 1/2/3) proved accurate — Tier 1 items were indeed one-liners, Tier 2 required assembly, Tier 3 needed original proofs. No reclassifications were needed.

**Friction:** Transitive vs. direct dependency distinction required explicit guidance (now in CLAUDE.md: "Conservative Dependencies"). Early drafts stored transitive closure, requiring a Stage 3.4 trimming step.

### Stage 2.5–2.6: Readiness Report and Reference Attachment (PR #23)

**Worked well:** `READINESS.md` served as an effective handoff document for Stage 3 agents. Proof strategy notes were accurate enough that Stage 3.3 agents followed them successfully.

**Friction:** None notable.

### Stage 3.1: Lean Scaffolding (PR #24)

**Worked well:** 28 items scaffolded in a single PR — impressive throughput. The "Definitions Must Be Constructed" constraint (no `def := sorry`) was respected. `lake build` with 3,144 jobs passed cleanly.

**Friction:** At this scale (28 files), a single session is at the edge of what's comfortable. The agent succeeded, but a decomposition into batches would have been safer.

**Lesson learned:** For projects with more items (50+), Stage 3.1 should be decomposed by definition/theorem type or by chapter section to stay within session scope.

### Stage 3.2: Scaffolding Review (PR #25)

**Worked well:** Automated scan for definition-level sorries was a fast and reliable first pass. Spot-checking 6 items against blob text provided confidence without reviewing all 28.

**Friction:** None notable. The review correctly identified 12 items needing proof filling — matching exactly what Stage 3.3 had to address.

### Stage 3.3: Proof Filling (PRs #37, #42, #52, #56)

**Worked well:** The tiered classification from Stage 2 guided effort correctly. Tier 1 items (01.20.Proposition, 01.25.Proposition, 01.23.Corollary) were genuinely one-liners. Tier 2 items (01.16.Theorem, 01.04.Lemma) required assembly but found Mathlib APIs for each step.

**Hardest items:**
- **01.04.Lemma** (backward direction of nonarchimedean iff): Required bridging between `AbsoluteValue` and `NormedField` APIs. The book's proof sketch was not directly formalizable; the agent had to find an indirect route via `IsUltrametricDist`.
- **01.24.Example** (ℤ[√5] not integrally closed): Required working in `FractionRing (Zsqrtd 5)`, building an explicit element `φ = ⟨1,1⟩/2`, showing integrality, applying `IsIntegrallyClosed`, and deriving a contradiction via an integer arithmetic argument. This was the most technically complex proof in the project.

**Coordination failure:** Three agents worked independently on 01.24.Example (issues #32, #35, and the session that merged #56), producing PRs #58 and #59 both conflicting with the already-merged #56. The root cause was that issue #35 remained open after #56 merged, and the coordination system used issue-open as the signal for unclaimed work. When issue labels and PR merges are decoupled from issue closure, duplicate work happens.

**Lesson learned:** After a PR merges that closes an issue, ensure the issue is actually closed. The `coordination create-pr` command closes the issue via "Closes #N" in the PR body, but if multiple PRs reference the same issue number, only one will close it on merge.

### Stage 3.4: Dependency Trimming (PR #41)

**Worked well:** Clean, focused task — update one JSON file. The explicit constraint against transitive closure in CLAUDE.md was effective.

**Friction:** None. This stage was added retroactively (after early PRs stored transitive closure), which is the right design: establish the correct representation once proofs exist to determine actual imports.

### Stage 3.5: Proof Polishing (PRs #45, #52)

**Worked well:** Four items had meaningful simplifications. The one-liner term-mode proof for 01.20.Proposition and the `Classical.choice inferInstance` pattern for 01.25.Proposition are good examples of post-hoc cleanup that reduces noise.

**Friction:** PR #45 and PR #46/#47 (01.04.Lemma + 01.05.Corollary from Stage 3.3f) had merge conflicts, requiring a conflict-resolution PR (#52). Concurrent proof work on different files should be fine, but when two PRs touch the same imports or the same file, conflicts arise.

**Lesson learned:** Stage 3.5 polishing should claim items explicitly so two agents don't polish the same file. The coordination system handles this for issues but not for "file-level" work that isn't tracked in an issue.

### Stage 3.6: Upstreaming Analysis (PR #53)

**Worked well:** Three genuine candidates identified (01.04.Lemma, 01.05.Corollary, 01.28.Proposition). The analysis was thorough — specific Mathlib search paths documented, reasons for rejection stated, suggested target modules named.

**Friction:** None notable. This is a research + documentation task well-suited to a single session.

---

## 2. Formalization Lessons

### Which tactics were most effective

| Tactic | Use cases |
|--------|-----------|
| `inferInstance` | Mathlib instances for standard algebraic structures (DVR, integral closure) |
| `decide` | Small finite computations (e.g., proving `Zsqrtd.Nonsquare 5`) |
| `omega` | Integer/natural arithmetic conclusions |
| `compute_degree!` | Polynomial degree computations |
| `field_simp` + `linear_combination` | Field equations with denominators |
| `nlinarith` | Nonlinear real arithmetic (e.g., `Real.sqrt 5` bounds) |
| `interval_cases` | Case-splitting on small integer ranges |

### Patterns across the 28 items

**Pattern 1: Mathlib is more complete than it appears.** Many items that looked like they needed original proofs turned out to have direct Mathlib analogues. The key was searching by concept rather than by name — e.g., searching for `IsIntegrallyClosed` rather than "integrally closed ring."

**Pattern 2: Abstract API gaps require bridging.** The `AbsoluteValue` vs. `NormedField` API split caused genuine friction for 01.04.Lemma and 01.05.Corollary. Mathlib's API is not uniformly developed across abstraction levels — results available for concrete types or normed structures may not exist for abstract algebraic structures.

**Pattern 3: Definitional equalities are powerful.** 01.16.Theorem (DVR ↔ local PID) was proved in one line because Mathlib's `IsDiscreteValuationRing` is *defined* as a local PID that is not a field. Understanding when something is definitionally true (vs. requiring a nontrivial proof) is key to efficient formalization.

**Pattern 4: `FractionRing` algebra is tricky.** Working in `FractionRing R` requires careful use of `IsFractionRing.injective` to transport results back to `R`. The `field_simp` + `linear_combination` pattern reliably handles fraction clearing when you have the right hypotheses.

**Hardest items and why:**
1. **01.24.Example** — Required working in a non-standard fraction ring, building an explicit algebraic element, and producing a contradiction via integer arithmetic. Four agents attempted it before success.
2. **01.04.Lemma** — Backward direction required indirect proof via `NormedField` machinery that is conceptually at a different abstraction level than the statement.
3. **01.28.Proposition** — Full iff for minimal polynomial characterization; the backward direction required connecting `minpoly K α ≠ 0` to `IsIntegral A α`.

---

## 3. Agent Coordination Lessons

### What worked well

**Single-issue single-PR workflow:** The claim/branch/PR pattern worked reliably for independent issues. When agents work on truly disjoint issues, merge conflicts are rare and the workflow is frictionless.

**FIFO issue ordering:** Issuing work items in dependency order and having `list-unclaimed` return them in FIFO order meant agents naturally worked in the right sequence without explicit coordination.

**`coordination orient` as first step:** Starting every session with an orient that shows claimed/open/PR status effectively prevented most duplicate work.

### Coordination failures

**01.24.Example duplicate work:** Three sessions ended up working on the same theorem because issue #35 remained open after PR #56 merged. The issue title mentioned both 01.24.Example and 01.29.Example; PR #56 closed issue #32 (which covered only 01.24.Example). Issue #35 remained open, and subsequent agents saw it as unclaimed work.

**Root cause:** Issues that cover multiple items create ambiguity. When one item from an issue is completed in a separate PR, the issue stays open, attracting more agents. This happened because issues #32 and #35 covered the same item (01.24.Example) from different angles.

**Fix:** Each issue should cover exactly one formalizable item. "Multi-item" issues should be split immediately during planning, not consolidated for efficiency.

**Concurrent PR conflicts (PRs #46/#47):** Two agents wrote proofs for 01.04.Lemma and 01.05.Corollary in the same session, producing conflicting PRs. The conflict was resolved in PR #52. This happened because issue #42 covered both items together.

**Fix:** Same as above — one issue per item prevents concurrent-PR conflicts on the same file.

### Suggested improvements to `agent-worker-flow`

**1. Explicit "close issue after merge" step:** The workflow should note that when a PR merges via "Closes #N," the issue closes automatically — but only for the *first* PR to merge. If two PRs both say "Closes #N," the issue closes after the first merge, and the second PR's author should check whether the issue is already closed before proceeding.

**2. Scope check in Step 2:** The skill already has a scope check, but it should explicitly warn against issues that cover multiple formalizable items. A single issue covering item A and item B should be decomposed before claiming.

**3. Issue-closure verification:** After creating a PR with auto-merge, confirm the issue is actually closed once the PR merges. Don't assume "Closes #N" in the body guarantees closure (it may fail silently in some GitHub configurations).

---

## 4. Skill and Command Improvements

### Suggested changes to `agent-worker-flow`

**Add to Step 2 (Set Up):**

```markdown
### Issue scope check
If the issue covers more than one formalizable item (e.g., "Fill 01.04.Lemma and 01.05.Corollary"),
decompose it immediately:
```bash
echo "..." | coordination plan --label feature "Fill 01.04.Lemma (nonarchimedean iff)"
echo "..." | coordination plan --label feature "Fill 01.05.Corollary (char p absolute values)"
coordination skip <parent-issue> "Decomposed into #X, #Y — one issue per item"
```
This prevents concurrent-PR merge conflicts and duplicate work.
```

**Add to Step 7 (Publish):**

```markdown
### Verify issue closure
After auto-merge completes, confirm the issue was actually closed:
```bash
gh issue view <N> --json state --jq .state
```
If still open despite PR merged, close it manually:
```bash
gh issue close <N> --comment "Work completed in merged PR #M."
```
```

### Suggested CLAUDE.md addition

The following lesson from this project is worth adding to the project-level CLAUDE.md for future FormalFrontier projects:

**One Issue Per Formalizable Item (strict):** Never create an issue that covers two or more formalizable items, even if they seem small. Colocating items in one issue invites concurrent agents to race on the same work and creates ambiguity about what is "done."

---

## 5. Overall Assessment

This project demonstrated that the FormalFrontier pipeline can take a mathematics textbook chapter from PDF to fully-formalized Lean in a single day using parallel multi-agent work. The 16-PR, 28-item formalization proceeded smoothly except for the 01.24.Example coordination failure, which is fixable with the "one issue per item" rule.

The pipeline stages are well-designed. The biggest bottleneck was Stage 3.3 (proof filling) for hard items, which required multi-attempt agent work. The coordination system held up well under concurrent load. The main systemic weakness is that issues covering multiple items are a coordination hazard.

The three upstreaming candidates (01.04.Lemma, 01.05.Corollary, 01.28.Proposition) represent genuine additions to Mathlib — these gaps between the `AbsoluteValue` and `NormedField` API layers, and the missing full-iff for the minpoly characterization, are worth contributing back.
