# Upstreaming Analysis — Stage 3.6

Triage of all 31 `proof_polished` items from Chapter 1 for upstreaming to Mathlib.

**Summary:** 4 items are candidates; 27 are rejected.

---

## Candidates

### 01_04_Lemma — Nonarchimedean Absolute Value iff Bounded on ℕ

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/01_04_Lemma` |
| **Declaration** | `sutherland_lemma1_4` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/01_04_Lemma.lean` |
| **Suggested Mathlib module** | `Mathlib.Algebra.Order.AbsoluteValue.Nonarchimedean` (new file) or `Mathlib.Analysis.Normed.Field.Ultra` |

**Lean statement:**
```lean
theorem sutherland_lemma1_4 {k : Type*} [Field k] (f : AbsoluteValue k ℝ)
    (hf1 : f 1 = 1) :
    IsNonarchimedean (⇑f) ↔ ∀ n : ℕ, f n ≤ 1
```

**Why it's new:** Mathlib has the forward direction
(`IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean`) and the iff at the
`NormedField` level (`isUltrametricDist_iff_forall_norm_natCast_le_one` in
`Mathlib.Analysis.Normed.Field.Ultra`), but there is **no iff statement for abstract
`AbsoluteValue`**. The backward direction (bounded on ℕ → nonarchimedean) for an
`AbsoluteValue` requires constructing a `NormedField` from the absolute value and
appealing to `IsUltrametricDist`. This is a gap between the `AbsoluteValue` and
`NormedField` APIs that is worth closing.

---

### 01_05_Corollary — Absolute Values in Positive Characteristic

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/01_05_Corollary` |
| **Declarations** | `sutherland_corollary1_5_posChar`, `sutherland_corollary1_5_finite` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/01_05_Corollary.lean` |
| **Suggested Mathlib module** | `Mathlib.Algebra.Order.AbsoluteValue.Nonarchimedean` (new file) or `Mathlib.Analysis.Normed.Field.Ultra` |

**Lean statements:**
```lean
theorem sutherland_corollary1_5_posChar {k : Type*} [Field k] [CharP k p] (hp : 0 < p)
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    IsNonarchimedean (⇑f)

theorem sutherland_corollary1_5_finite {k : Type*} [Field k] [Fintype k] [DecidableEq k]
    (f : AbsoluteValue k ℝ) (hf1 : f 1 = 1) :
    f = AbsoluteValue.trivial
```

**Why it's new:** No result in Mathlib connects `CharP` or `Fintype` to
`IsNonarchimedean` for abstract `AbsoluteValue`. The positive characteristic result
uses Frobenius (`add_pow_char`) to show `f n ∈ {0,1}`, giving `f n ≤ 1`. The finite
field result uses `FiniteField.pow_card_sub_one_eq_one` to force `f x = 1` for all
nonzero `x`. Both are standard textbook results absent from Mathlib's API.

---

### 01_28_Proposition — Integrality iff Minimal Polynomial over A

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/01_28_Proposition` |
| **Declaration** | `sutherland_prop1_28` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/01_28_Proposition.lean` |
| **Suggested Mathlib module** | `Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed` |

**Lean statement:**
```lean
theorem sutherland_prop1_28 {A K L : Type*} [CommRing A] [IsDomain A] [IsIntegrallyClosed A]
    [Field K] [Field L] [Algebra A K] [IsFractionRing A K]
    [Algebra K L] [Algebra A L] [IsScalarTower A K L]
    [FiniteDimensional K L] (α : L) :
    IsIntegral A α ↔
      (minpoly A α).map (algebraMap A K) = minpoly K α
```

**Why it's new:** Mathlib has `minpoly.isIntegrallyClosed_eq_field_fractions'` (the
forward direction: `IsIntegral A α → (minpoly A α).map (algebraMap A K) = minpoly K α`)
in `Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed`. However, the **full iff** is not
present as a standalone lemma. The backward direction (`minpoly map = minpoly K →
IsIntegral A α`) requires that `minpoly K α ≠ 0` (which follows from `L/K` being
finite) and then deduces integrality from the monic polynomial. This is a useful
completion of the minpoly API.

**Phase 2 deep research (2026-03-25):** Exhaustive search of
`Mathlib/FieldTheory/Minpoly/IsIntegrallyClosed.lean` confirms:
- Forward direction: `isIntegrallyClosed_eq_field_fractions'` (line 59) — `IsIntegral R s → minpoly K s = (minpoly R s).map (algebraMap R K)`
- Related iffs exist for *leading coefficient* conditions (`isIntegral_iff_isUnit_leadingCoeff`, `isIntegral_iff_leadingCoeff_dvd`) but NOT for the minpoly-map-equality characterization
- `minpoly.ne_zero_iff` in `Basic.lean` gives `minpoly A x ≠ 0 ↔ IsIntegral A x` but this is distinct from the map-equality iff
- No backward direction (`minpoly map equality → IsIntegral`) found anywhere in Mathlib
- **Verdict: confirmed candidate** — the full iff is a genuine gap in Mathlib's minpoly API

---

### 01_24_Example — ℤ[√5] is Not Integrally Closed

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/01_24_Example` |
| **Declaration** | `zsqrtd5_not_integrallyClosed` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/01_24_Example.lean` |
| **Suggested Mathlib module** | `Mathlib.NumberTheory.Zsqrtd.Basic` |

**Lean statement:**
```lean
theorem zsqrtd5_not_integrallyClosed :
    ¬IsIntegrallyClosed (Zsqrtd 5)
```

**Why it's new:** Mathlib's `Mathlib.NumberTheory.Zsqrtd.Basic` has no result asserting
that `Zsqrtd 5` (i.e. `ℤ[√5]`) is not integrally closed. A search for
`IntegrallyClosed`, `isIntegrallyClosed`, or `not_isIntegrallyClosed` in all `Zsqrtd`
files returns no matches. The proof exhibits the explicit witness `φ = (1 + √5)/2 ∈
Frac(Zsqrtd 5)` which satisfies `X² - X - 1 = 0` over `Zsqrtd 5` but has no preimage
in `Zsqrtd 5` (since `2 * a = ⟨1, 1⟩` has no solution — parity contradiction on the
real part). This is a concrete, self-contained example of a non-integrally-closed ring
that would fit naturally alongside `GaussianInt` in the `Zsqrtd` namespace.

**Phase 2 deep research (2026-03-25):** Exhaustive search confirms:
- `Mathlib/NumberTheory/Zsqrtd/` contains 4 files: `Basic.lean`, `GaussianInt.lean`, `ToReal.lean`, `QuadraticReciprocity.lean` — none mention `IntegrallyClosed`
- No `¬IsIntegrallyClosed` results exist anywhere in Mathlib (not just for Zsqrtd)
- `Mathlib/Counterexamples/` has no counterexamples about integrally closed rings
- No `FractionRing` instances specific to `Zsqrtd` exist (uses generic `IsDomain` machinery via `Nonsquare`)
- `Zsqrtd 5` does not appear in Mathlib at all
- **Verdict: confirmed candidate** — this would be Mathlib's first concrete counterexample of a ring that is not integrally closed

---

## Rejected Items

| Item ID | Reason |
|---------|--------|
| `Chapter1/01_02_Definition` | Pure definition; `AbsoluteValue k ℝ` and `IsNonarchimedean` already exist in Mathlib |
| `Chapter1/01_03_Example` | `padicAbsoluteValue_isNonarchimedean` is a one-line delegation to `padicNorm.nonarchimedean`; no new content |
| `Chapter1/01_06_Definition` | Pure definition; `AbsoluteValue.IsEquiv` already exists in Mathlib |
| `Chapter1/01_07_Definition` | Pure definition; `padicValRat`, `padicNorm`, `Rat.AbsoluteValue.padic` already exist |
| `Chapter1/01_08_Theorem` | Direct delegation to `Rat.AbsoluteValue.equiv_real_or_padic`; one-line wrapper |
| `Chapter1/01_09_Theorem` | Direct delegation to `NumberField.prod_abs_eq_one`; one-line wrapper |
| `Chapter1/01_10_Definition` | Pure definition; `Valuation`, `ValuationRing`, `IsDiscreteValuationRing` already exist |
| `Chapter1/01_10a_Discussion` | Mostly recall (`AddValuation.map_inv`, `isUnit_iff_valuation_eq_one`); `valuation_trichotomy` is trivial glue over linear order |
| `Chapter1/01_11_Definition` | Pure definition; `ValuationRing` already exists in Mathlib |
| `Chapter1/01_11a_Discussion` | Mostly recall; `maximalIdeal_eq_span_uniformizer` is simple application of `irreducible_iff_uniformizer` |
| `Chapter1/01_12_Definition` | Pure definition; `IsLocalRing` already exists in Mathlib |
| `Chapter1/01_13_Definition` | Pure definition; `IsLocalRing.ResidueField` already exists in Mathlib |
| `Chapter1/01_13a_Discussion` | Pure recall of DVR valuation properties (`addVal`, `maximalIdeal`, `equivValuationSubring`, `isRankOneDiscrete`) |
| `Chapter1/01_14_Example` | `primeIdealZ_isPrime` and `IsLocalRing` for `ℤ_(p)` are trivial Mathlib wrappers; `inferInstance` or near-trivial |
| `Chapter1/01_15_Example` | `IsDiscreteValuationRing (PowerSeries k)` is `inferInstance`; no new content |
| `Chapter1/01_16_Theorem` | DVR ↔ local PID is definitionally true in Mathlib (`IsDiscreteValuationRing` is exactly a local PID that is not a field); no new theorem |
| `Chapter1/01_17_Definition` | Pure definition; `IsIntegral` already exists in Mathlib |
| `Chapter1/01_18_Proposition` | `IsIntegral.add` and `IsIntegral.mul` are one-line delegations to Mathlib |
| `Chapter1/01_19_Definition` | Pure definition; `integralClosure`, `IsIntegrallyClosed` already exist |
| `Chapter1/01_20_Proposition` | One-line delegation to `Algebra.IsIntegral.trans` |
| `Chapter1/01_21_Corollary` | One-line delegation to `integralClosure.isIntegralClosure` |
| `Chapter1/01_22_Proposition` | `IsIntegrallyClosed ℤ` is `inferInstance` via `Int.instIsIntegrallyClosed` |
| `Chapter1/01_23_Corollary` | One-line delegation to `GCDMonoid.toIsIntegrallyClosed`; UFDs integrally closed is already in Mathlib |
| `Chapter1/01_25_Proposition` | Three-line proof chaining `ValuationRing → IsBezout → GCDMonoid → IsIntegrallyClosed`; all steps are existing Mathlib instances |
| `Chapter1/01_26_Definition` | Pure definition; `NumberField`, `RingOfIntegers` already exist in Mathlib |
| `Chapter1/01_27_Remark` | `Module.Free` instance is `inferInstance`; rank result is one-line delegation to `NumberField.RingOfIntegers.rank` |
| `Chapter1/01_29_Example` | Concrete computation (`(1 + √7)/2 ∉ ℤ`); too specific for Mathlib's API |

---

## Mathlib Search Notes

Searches were performed in `.lake/packages/mathlib/Mathlib` (local source).

- `Mathlib.Algebra.Order.Ring.IsNonarchimedean`: has forward direction
  `apply_natCast_le_one_of_isNonarchimedean` but not the iff for `AbsoluteValue`
- `Mathlib.Analysis.Normed.Field.Ultra`: has
  `isUltrametricDist_iff_forall_norm_natCast_le_one` for `NormedField` but not
  for abstract `AbsoluteValue`
- `Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed`: has
  `isIntegrallyClosed_eq_field_fractions'` (⟹ direction only); no full iff
- No results found for: `AbsoluteValue` + `CharP`, `AbsoluteValue` + `Fintype`
  (confirming 01_05_Corollary results are absent from Mathlib)
- `Mathlib.NumberTheory.Zsqrtd.*`: no results for `IntegrallyClosed`, `isIntegrallyClosed`,
  or `not_isIntegrallyClosed` — confirming `zsqrtd5_not_integrallyClosed` is absent
