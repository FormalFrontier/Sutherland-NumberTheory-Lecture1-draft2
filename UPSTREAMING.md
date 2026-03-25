# Upstreaming Analysis — Stage 3.6

Triage of all 28 `proof_polished` items from Chapter 1 for upstreaming to Mathlib.

**Summary:** 3 items are candidates; 25 are rejected.

---

## Candidates

### Lemma1_4 — Nonarchimedean Absolute Value iff Bounded on ℕ

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/Lemma1_4` |
| **Declaration** | `sutherland_lemma1_4` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/Lemma1_4.lean` |
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

### Corollary1_5 — Absolute Values in Positive Characteristic

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/Corollary1_5` |
| **Declarations** | `sutherland_corollary1_5_posChar`, `sutherland_corollary1_5_finite` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/Corollary1_5.lean` |
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

### Proposition1_28 — Integrality iff Minimal Polynomial over A

| Field | Value |
|-------|-------|
| **Item ID** | `Chapter1/Proposition1_28` |
| **Declaration** | `sutherland_prop1_28` |
| **File** | `SutherlandNumberTheoryLecture1/Chapter1/Proposition1_28.lean` |
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

## Rejected Items

| Item ID | Reason |
|---------|--------|
| `Chapter1/Definition1_2` | Pure definition; `AbsoluteValue k ℝ` and `IsNonarchimedean` already exist in Mathlib |
| `Chapter1/Example1_3` | `padicAbsoluteValue_isNonarchimedean` is a one-line delegation to `padicNorm.nonarchimedean`; no new content |
| `Chapter1/Definition1_6` | Pure definition; `AbsoluteValue.IsEquiv` already exists in Mathlib |
| `Chapter1/Definition1_7` | Pure definition; `padicValRat`, `padicNorm`, `Rat.AbsoluteValue.padic` already exist |
| `Chapter1/Theorem1_8` | Direct delegation to `Rat.AbsoluteValue.equiv_real_or_padic`; one-line wrapper |
| `Chapter1/Theorem1_9` | Direct delegation to `NumberField.prod_abs_eq_one`; one-line wrapper |
| `Chapter1/Definition1_10` | Pure definition; `Valuation`, `ValuationRing`, `IsDiscreteValuationRing` already exist |
| `Chapter1/Definition1_11` | Pure definition; `ValuationRing` already exists in Mathlib |
| `Chapter1/Definition1_12` | Pure definition; `IsLocalRing` already exists in Mathlib |
| `Chapter1/Definition1_13` | Pure definition; `IsLocalRing.ResidueField` already exists in Mathlib |
| `Chapter1/Example1_14` | `primeIdealZ_isPrime` and `IsLocalRing` for `ℤ_(p)` are trivial Mathlib wrappers; `inferInstance` or near-trivial |
| `Chapter1/Example1_15` | `IsDiscreteValuationRing (PowerSeries k)` is `inferInstance`; no new content |
| `Chapter1/Theorem1_16` | DVR ↔ local PID is definitionally true in Mathlib (`IsDiscreteValuationRing` is exactly a local PID that is not a field); no new theorem |
| `Chapter1/Definition1_17` | Pure definition; `IsIntegral` already exists in Mathlib |
| `Chapter1/Proposition1_18` | `IsIntegral.add` and `IsIntegral.mul` are one-line delegations to Mathlib |
| `Chapter1/Definition1_19` | Pure definition; `integralClosure`, `IsIntegrallyClosed` already exist |
| `Chapter1/Proposition1_20` | One-line delegation to `Algebra.IsIntegral.trans` |
| `Chapter1/Corollary1_21` | One-line delegation to `integralClosure.isIntegralClosure` |
| `Chapter1/Proposition1_22` | `IsIntegrallyClosed ℤ` is `inferInstance` via `Int.instIsIntegrallyClosed` |
| `Chapter1/Corollary1_23` | One-line delegation to `GCDMonoid.toIsIntegrallyClosed`; UFDs integrally closed is already in Mathlib |
| `Chapter1/Proposition1_25` | Three-line proof chaining `ValuationRing → IsBezout → GCDMonoid → IsIntegrallyClosed`; all steps are existing Mathlib instances |
| `Chapter1/Definition1_26` | Pure definition; `NumberField`, `RingOfIntegers` already exist in Mathlib |
| `Chapter1/Remark1_27` | `Module.Free` instance is `inferInstance`; rank result is one-line delegation to `NumberField.RingOfIntegers.rank` |
| `Chapter1/Example1_24` | Concrete computations (`(1+√5)/2` is integral; `ℤ[√5]` not integrally closed); too specific for Mathlib's API |
| `Chapter1/Example1_29` | Concrete computation (`(1 + √7)/2 ∉ ℤ`); too specific for Mathlib's API |

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
  (confirming Corollary1_5 results are absent from Mathlib)
