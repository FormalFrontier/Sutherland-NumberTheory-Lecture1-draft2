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
| **Phase 2 verdict** | **upstream** — confirmed new, bridges a real API gap |

**Lean statement:**
```lean
theorem sutherland_lemma1_4 {k : Type*} [Field k] (f : AbsoluteValue k ℝ) :
    IsNonarchimedean (⇑f) ↔ ∀ n : ℕ, f n ≤ 1
```

**Phase 2 deep research:**

*Forward direction (already in Mathlib):*
- `IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean` in
  `Mathlib.Algebra.Order.Ring.IsNonarchimedean` — works for any function satisfying
  `ZeroHomClass`, `NonnegHomClass`, `OneHomClass`, not just `AbsoluteValue`.

*Backward direction — existing infrastructure:*
- `AbsoluteValue.toNormedField` in `Mathlib.Analysis.Normed.Field.Basic` (line 359):
  constructs a `NormedField` from any real `AbsoluteValue` on a field.
- `IsUltrametricDist.isUltrametricDist_of_forall_norm_natCast_le_one` in
  `Mathlib.Analysis.Normed.Field.Ultra` (line 103): proves that if `‖(n : R)‖ ≤ 1`
  for all `n : ℕ` then `IsUltrametricDist R` holds.
- `IsUltrametricDist.isNonarchimedean_norm` connects `IsUltrametricDist` back to
  `IsNonarchimedean`.

*The gap:* No theorem in Mathlib assembles these three pieces into an iff for abstract
`AbsoluteValue`. Our proof does exactly this (3 lines for the backward direction).
The `NormedField` iff (`isUltrametricDist_iff_forall_norm_natCast_le_one`) exists but
requires the user to already have a `NormedField` instance. Our version takes a bare
`AbsoluteValue k ℝ` and handles the `letI : NormedField k := f.toNormedField` step,
which is the natural API for users working at the `AbsoluteValue` level.

*Suggested Mathlib name:* `AbsoluteValue.isNonarchimedean_iff_natCast_le_one`

---

### 01_05_Corollary — Absolute Values in Positive Characteristic

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/01_05_Corollary` |
| **Declarations** | `sutherland_corollary1_5_posChar`, `sutherland_corollary1_5_finite` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/01_05_Corollary.lean` |
| **Suggested Mathlib module** | `Mathlib.Algebra.Order.AbsoluteValue.Nonarchimedean` (new file) or `Mathlib.Analysis.Normed.Field.Ultra` |
| **Phase 2 verdict** | **upstream** — confirmed new, fills a clear gap |

**Lean statements:**
```lean
theorem sutherland_corollary1_5_posChar {k : Type*} [Field k] [CharP k p] (hp : 0 < p)
    (f : AbsoluteValue k ℝ) :
    IsNonarchimedean (⇑f)

theorem sutherland_corollary1_5_finite {k : Type*} [Field k] [Finite k] [DecidableEq k]
    (f : AbsoluteValue k ℝ) :
    f = AbsoluteValue.trivial
```

**Phase 2 deep research:**

*Positive characteristic result:*
- **No file in Mathlib contains both `AbsoluteValue` and `CharP`.** Zero matches.
- The proof uses `add_pow_char` from `Mathlib.Algebra.CharP.Lemmas` (Frobenius /
  "freshman's dream") to show `f(n)^p = f(n)`, then deduces `f(n) ≤ 1` by contradiction.
- `CharP.char_prime_of_ne_zero` provides primality of the characteristic.
- All ingredients exist in Mathlib but nobody has assembled them for `AbsoluteValue`.

*Finite field result:*
- **No file in Mathlib contains both `AbsoluteValue` and `Fintype`/`Finite`.** Zero matches.
- The proof uses `FiniteField.pow_card_sub_one_eq_one` from
  `Mathlib.FieldTheory.Finite.Basic` to get `f(x)^(q-1) = 1`, then
  `pow_eq_one_iff_of_nonneg` to conclude `f(x) = 1`.
- `AbsoluteValue.trivial` is defined in `Mathlib.Algebra.Order.AbsoluteValue.Basic`
  (line 298) with `trivial_apply` simp lemma.
- Related: `isEquiv_trivial_iff_eq_trivial` in `Mathlib.Analysis.AbsoluteValue.Equivalence`
  characterizes equivalence to the trivial absolute value.

*Both theorems are self-contained (~20 lines each), use only standard Mathlib API, and
state results that are standard in every algebraic number theory textbook.*

*Suggested Mathlib names:*
- `AbsoluteValue.isNonarchimedean_of_charP`
- `AbsoluteValue.eq_trivial_of_finite`

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

### Phase 1 (triage)

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

### Phase 2 — 01_04_Lemma and 01_05_Corollary deep research

**Key Mathlib files examined:**

| File | Key contents | Relevance |
|------|-------------|-----------|
| `Mathlib.Algebra.Order.Ring.IsNonarchimedean` | `apply_natCast_le_one_of_isNonarchimedean` (fwd direction) | 01_04 forward direction |
| `Mathlib.Analysis.Normed.Field.Basic` (line 359) | `AbsoluteValue.toNormedField` — constructs `NormedField` from `AbsoluteValue k ℝ` | 01_04 backward direction (bridge) |
| `Mathlib.Analysis.Normed.Field.Ultra` (line 103) | `isUltrametricDist_of_forall_norm_natCast_le_one` — `NormedDivisionRing` iff | 01_04 backward direction (core) |
| `Mathlib.Analysis.Normed.Field.Ultra` (line 140) | `isUltrametricDist_iff_forall_norm_natCast_le_one` — full iff for `NormedDivisionRing` | 01_04 (NormedField-level iff exists) |
| `Mathlib.Algebra.CharP.Lemmas` | `add_pow_char`, `add_pow_char_pow` — Frobenius | 01_05 posChar proof |
| `Mathlib.Algebra.CharP.Basic` | `CharP.char_prime_of_ne_zero` | 01_05 posChar proof |
| `Mathlib.FieldTheory.Finite.Basic` | `FiniteField.pow_card_sub_one_eq_one`, `pow_card` | 01_05 finite proof |
| `Mathlib.Algebra.Order.AbsoluteValue.Basic` (line 298) | `AbsoluteValue.trivial`, `trivial_apply` | 01_05 finite proof |
| `Mathlib.Analysis.AbsoluteValue.Equivalence` (line 97) | `isEquiv_trivial_iff_eq_trivial` | 01_05 related |

**Confirmed gaps:**
- `grep -r "AbsoluteValue" | grep "CharP"` → 0 matches across all of Mathlib
- `grep -r "AbsoluteValue" | grep "Fintype\|Finite"` → 0 matches for theorems (only type params)
- No iff for `IsNonarchimedean` on abstract `AbsoluteValue` (only on `NormedDivisionRing`)
- All three pieces for the backward direction exist independently but are not composed
