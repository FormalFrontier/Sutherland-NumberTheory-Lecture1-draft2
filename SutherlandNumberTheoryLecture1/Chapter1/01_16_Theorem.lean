import SutherlandNumberTheoryLecture1.Chapter1.«01_10_Definition»
import Mathlib.RingTheory.DiscreteValuationRing.TFAE
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.DedekindDomain.Basic
import Mathlib.RingTheory.Noetherian.Basic
import Mathlib.RingTheory.PrincipalIdealDomain
import Mathlib.Algebra.Polynomial.Reverse

/-!
## Theorem 1.16 — Equivalent Characterizations of DVRs

**Theorem 1.16.** For an integral domain `A`, the following are equivalent:
1. `A` is a DVR.
2. `A` is a noetherian valuation ring that is not a field.
3. `A` is a local PID that is not a field.
4. `A` is an integrally closed noetherian local ring of Krull dimension 1.
5. `A` is a regular noetherian local ring of dimension 1.
6. `A` is a noetherian local ring whose maximal ideal is nonzero and principal.
7. `A` is a maximal noetherian local ring of dimension 1.

Multiple directions are proved in Mathlib; the full 7-way equivalence uses
`IsDiscreteValuationRing.TFAE` as a stepping stone.

Condition 5 ("regular noetherian local ring of dimension one") is formalized as
`finrank (ResidueField A) (CotangentSpace A) = 1`, i.e., `dim_k(𝔪/𝔪²) = 1`. For a
noetherian local domain, regularity means `dim_k(𝔪/𝔪²) = Krull dim(A)`, and the condition
`finrank = 1` encodes both regularity and dimension one simultaneously.

Condition 7 ("maximal noetherian ring of dimension one" in the PDF) is formalized using the
property that there are no intermediate subalgebras between `A` and `Frac(A)`. The book's
"maximal" refers to the property that `A` admits no proper overrings in its fraction field.
-/

open IsLocalRing Module

section MaximalSubalgebra

variable {A : Type*} [CommRing A] [IsDomain A]

/-- In a DVR, there are no intermediate subalgebras between `A` and `Frac(A)`:
any subalgebra is either `⊥` (the image of `A`) or `⊤` (all of `Frac(A)`).

The proof uses that a DVR is a local PID: if `S` contains an element `x ∉ A`,
then `x = a/b` where `v(a) < v(b)`, and from `x` we can recover `π⁻¹` (the inverse
of the uniformizer) inside `S`, which generates all of `Frac(A)`. -/
theorem dvr_subalgebra_eq_bot_or_top [IsDiscreteValuationRing A]
    (S : Subalgebra A (FractionRing A)) : S = ⊥ ∨ S = ⊤ := by
  set K := FractionRing A
  obtain ⟨ϖ, hϖ⟩ := IsDiscreteValuationRing.exists_irreducible (R := A)
  -- Suffices to show: S ≠ ⊥ → S = ⊤
  suffices h : S ≠ ⊥ → S = ⊤ from (eq_or_ne S ⊥).elim Or.inl (fun hne => Or.inr (h hne))
  intro hne
  -- Get x ∈ S with x ∉ range(algebraMap)
  have ⟨x, hxS, hxbot⟩ := SetLike.exists_of_lt (bot_lt_iff_ne_bot.mpr hne)
  rw [Algebra.mem_bot] at hxbot
  -- By valuation ring property, x⁻¹ is an integer
  obtain ⟨a, ha⟩ := (ValuationRing.isInteger_or_isInteger A x).resolve_left
    (fun ⟨c, hc⟩ => hxbot ⟨c, hc⟩)
  -- a ≠ 0 (otherwise x⁻¹ = 0, x = 0, contradiction)
  have ha0 : a ≠ 0 := by
    intro h; rw [h, map_zero] at ha
    exact hxbot ⟨0, by rw [map_zero]; exact (inv_eq_zero.mp ha.symm).symm⟩
  -- Factor a = u * ϖ^n
  obtain ⟨n, u, rfl⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible ha0 hϖ
  -- n ≥ 1 since a is not a unit (otherwise x ∈ range algebraMap)
  have hn : 0 < n := by
    rcases n with _ | n
    · simp only [pow_zero, mul_one] at ha
      exact absurd ⟨↑u⁻¹, by rw [map_units_inv, ha, inv_inv]⟩ hxbot
    · exact Nat.succ_pos n
  -- Key: show (algebraMap ϖ)⁻¹ ∈ S
  have hϖ_ne : algebraMap A K ϖ ≠ 0 :=
    IsFractionRing.to_map_eq_zero_iff.not.mpr hϖ.ne_zero
  have hϖ_inv : (algebraMap A K ϖ)⁻¹ ∈ S := by
    -- Unify K = FractionRing A in ha
    have ha' : algebraMap A K (↑u * ϖ ^ n) = x⁻¹ := ha
    have hu_ne : algebraMap A K (↑u : A) ≠ 0 :=
      IsFractionRing.to_map_eq_zero_iff.not.mpr (Units.ne_zero u)
    -- x = (algebraMap(u * ϖ^n))⁻¹, so algebraMap(u) * x = ((algebraMap ϖ)⁻¹)^n
    have h1 : algebraMap A K ↑u * x = ((algebraMap A K ϖ)⁻¹) ^ n := by
      have hx : x = (algebraMap A K (↑u * ϖ ^ n))⁻¹ := by
        rw [ha', inv_inv]
      rw [hx, map_mul, map_pow, mul_inv_rev, mul_comm ((algebraMap A K ϖ) ^ n)⁻¹,
        ← mul_assoc, mul_inv_cancel₀ hu_ne, one_mul, inv_pow]
    -- So ((algebraMap ϖ)⁻¹)^n ∈ S
    have h2 : ((algebraMap A K ϖ)⁻¹) ^ n ∈ S := h1 ▸ S.mul_mem (S.algebraMap_mem ↑u) hxS
    -- Multiply by (algebraMap ϖ)^(n-1) to get (algebraMap ϖ)⁻¹
    obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, (Nat.succ_pred_eq_of_pos hn).symm⟩
    have h3 : algebraMap A K ϖ ^ m * ((algebraMap A K ϖ)⁻¹) ^ (m + 1) = (algebraMap A K ϖ)⁻¹ := by
      rw [pow_succ, ← mul_assoc, ← mul_pow, mul_inv_cancel₀ hϖ_ne, one_pow, one_mul]
    exact h3 ▸ S.mul_mem (S.pow_mem (S.algebraMap_mem ϖ) _) h2
  -- Now show S = ⊤: every element of K is in S
  rw [eq_top_iff]
  intro y _
  -- Write y = algebraMap(a') / algebraMap(b')
  obtain ⟨a', b', hb', hy⟩ := IsFractionRing.div_surjective A y
  rw [← hy]
  have hb'0 : b' ≠ 0 := nonZeroDivisors.ne_zero hb'
  -- Factor b' = v * ϖ^k
  obtain ⟨k, v, rfl⟩ := IsDiscreteValuationRing.eq_unit_mul_pow_irreducible hb'0 hϖ
  -- (algebraMap b')⁻¹ = algebraMap(v⁻¹) * (algebraMap ϖ)⁻ᵏ ∈ S
  have h_inv_b : (algebraMap A K (↑v * ϖ ^ k))⁻¹ ∈ S := by
    rw [map_mul, map_pow, mul_inv_rev, ← inv_pow]
    refine S.mul_mem (S.pow_mem hϖ_inv k) ?_
    rw [← map_units_inv]
    exact S.algebraMap_mem _
  rw [div_eq_mul_inv]
  exact S.mul_mem (S.algebraMap_mem a') h_inv_b

/-- If `x ∈ A[x⁻¹]` in a fraction field and `x ≠ 0`, then `x` is integral over `A`.

The key idea: `x ∈ A[x⁻¹]` means `x = p(x⁻¹)` for some polynomial `p`. Setting
`q = 1 - X * p`, we get `q(x⁻¹) = 0` and `q` has trailing coefficient 1. The
reverse polynomial `reverse(q)` is therefore monic, and `reverse(q)(x) = 0` by
the `eval₂_reverse_eq_zero_iff` lemma. -/
theorem isIntegral_of_mem_adjoin_inv [Field K] [Algebra A K] [IsFractionRing A K]
    {x : K} (hx : x ≠ 0) (hmem : x ∈ Algebra.adjoin A {x⁻¹}) : IsIntegral A x := by
  rw [Algebra.adjoin_singleton_eq_range_aeval] at hmem
  obtain ⟨p, hp⟩ := hmem
  -- hp : aeval x⁻¹ p = x
  -- Define q = 1 - X * p. Then q(x⁻¹) = 1 - x⁻¹ * x = 0.
  set q := (1 : Polynomial A) - Polynomial.X * p with hq_def
  have hp' : Polynomial.aeval x⁻¹ p = x := hp
  have hq_root : Polynomial.aeval x⁻¹ q = 0 := by
    simp only [q, map_sub, map_one, map_mul, Polynomial.aeval_X, hp', inv_mul_cancel₀ hx,
      sub_self]
  -- reverse(q) has x as a root (by eval₂_reverse_eq_zero_iff)
  letI : Invertible x⁻¹ := invertibleOfNonzero (inv_ne_zero hx)
  have hx_root : Polynomial.aeval x (Polynomial.reverse q) = 0 := by
    have h := (Polynomial.eval₂_reverse_eq_zero_iff (algebraMap A K) x⁻¹ q).mpr
    simp only [invOf_eq_inv, inv_inv] at h
    exact h hq_root
  -- reverse(q) is monic: its leading coefficient = trailingCoeff q = q.coeff 0 = 1
  have hq_monic : (Polynomial.reverse q).Monic := by
    rw [Polynomial.Monic, Polynomial.reverse_leadingCoeff, Polynomial.trailingCoeff]
    have hcoeff0 : q.coeff 0 = 1 := by
      simp [q, Polynomial.coeff_sub, Polynomial.coeff_one_zero]
    have hntd : q.natTrailingDegree = 0 :=
      Nat.eq_zero_of_le_zero (Polynomial.natTrailingDegree_le_of_ne_zero (hcoeff0 ▸ one_ne_zero))
    rw [hntd, hcoeff0]
  exact ⟨Polynomial.reverse q, hq_monic, hx_root⟩

/-- A noetherian local domain that is not a field and admits no intermediate subalgebras
between itself and its fraction field is a DVR.

The key insight is that maximality forces integrally closed: if `x ∈ Frac(A)` is
integral over `A` but `x ∉ A`, then `A[x]` is an intermediate subalgebra. By
maximality `A[x] = Frac(A)`, but since `x` is integral, `A[x]` is a finitely
generated `A`-module, forcing `A` to be a field — contradiction.

Then we show `A` is a valuation ring: for any `x ∈ Frac(A)`, either `x ∈ A` or
`x⁻¹ ∈ A`. If neither, then `A[x] = A[x⁻¹] = Frac(A)`, so `x ∈ A[x⁻¹]`, making
`x` integral. Since `A` is integrally closed, `x ∈ A` — contradiction.

A noetherian local valuation ring that is not a field is a DVR by Mathlib's TFAE. -/
theorem maximal_noetherian_local_is_dvr [IsNoetherianRing A] [IsLocalRing A]
    (hF : ¬IsField A)
    (hmax : ∀ S : Subalgebra A (FractionRing A), S = ⊥ ∨ S = ⊤) :
    IsDiscreteValuationRing A := by
  set K := FractionRing A
  -- Step 1: A is integrally closed
  have hIC : IsIntegrallyClosed A := by
    rw [isIntegrallyClosed_iff K]
    intro x hx
    have hS := hmax (Algebra.adjoin A {x})
    cases hS with
    | inl hbot =>
      have hx_mem : x ∈ Algebra.adjoin A {x} := Algebra.subset_adjoin rfl
      rw [hbot] at hx_mem
      exact hx_mem
    | inr htop =>
      exfalso; apply hF
      -- x integral → A[x] f.g. as A-module → Frac(A) f.g. → A is a field
      have hfg := hx.fg_adjoin_singleton
      rw [htop] at hfg
      haveI : Module.Finite A K := ⟨by simpa using hfg⟩
      exact isField_of_isIntegral_of_isField (IsFractionRing.injective A K)
        (Field.toIsField K)
  haveI := hIC
  -- Step 2: Show ValuationRing A
  have hVR : ValuationRing A := by
    rw [ValuationRing.iff_isInteger_or_isInteger A K]
    intro x
    -- Either A[x] = ⊥ (x ∈ A) or A[x] = ⊤
    cases hmax (Algebra.adjoin A {x}) with
    | inl hbot =>
      left
      have : x ∈ Algebra.adjoin A {x} := Algebra.subset_adjoin rfl
      rw [hbot, Algebra.mem_bot] at this
      exact this
    | inr htop =>
      -- A[x] = ⊤; either A[x⁻¹] = ⊥ or A[x⁻¹] = ⊤
      cases hmax (Algebra.adjoin A {x⁻¹}) with
      | inl hbot =>
        right
        have : x⁻¹ ∈ Algebra.adjoin A {x⁻¹} := Algebra.subset_adjoin rfl
        rw [hbot, Algebra.mem_bot] at this
        exact this
      | inr htop' =>
        -- Both A[x] = ⊤ and A[x⁻¹] = ⊤ → x ∈ A (so give Left)
        left
        have hx_mem : x ∈ Algebra.adjoin A ({x⁻¹} : Set K) := htop' ▸ Algebra.mem_top
        by_cases hx0 : x = 0
        · exact ⟨0, by simp [hx0]⟩
        · -- x ≠ 0 and x ∈ A[x⁻¹] → x is integral → x ∈ A
          exact (isIntegrallyClosed_iff K).mp hIC (isIntegral_of_mem_adjoin_inv hx0 hx_mem)
  -- Step 3: Apply Mathlib's DVR TFAE: ValuationRing → DVR
  exact ((IsDiscreteValuationRing.TFAE (R := A) hF).out 1 0).mp hVR

end MaximalSubalgebra

/-- **Theorem 1.16** (Sutherland). Equivalent characterizations of DVRs.

For an integral domain `A`, the following are equivalent:
0. `A` is a DVR
1. `A` is a noetherian valuation ring that is not a field
2. `A` is a local PID that is not a field
3. `A` is an integrally closed noetherian local ring of dimension one
4. `A` is a regular noetherian local ring of dimension one (`dim_k(𝔪/𝔪²) = 1`)
5. `A` is a noetherian local ring whose maximal ideal is nonzero and principal
6. `A` is a maximal noetherian local ring of dimension one (no intermediate subalgebras
   between `A` and `Frac(A)`) -/
theorem sutherland_theorem1_16 (A : Type*) [CommRing A] [IsDomain A] :
    List.TFAE [
      IsDiscreteValuationRing A,
      IsNoetherianRing A ∧ ValuationRing A ∧ ¬IsField A,
      IsLocalRing A ∧ IsPrincipalIdealRing A ∧ ¬IsField A,
      IsIntegrallyClosed A ∧ IsNoetherianRing A ∧ IsLocalRing A ∧
        ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime,
      IsNoetherianRing A ∧ IsLocalRing A ∧
        ∃ m : Ideal A, m.IsMaximal ∧ finrank (A ⧸ m) m.Cotangent = 1,
      IsNoetherianRing A ∧ IsLocalRing A ∧
        ∃ m : Ideal A, m.IsMaximal ∧ m ≠ ⊥ ∧ m.IsPrincipal,
      IsNoetherianRing A ∧ IsLocalRing A ∧ ¬IsField A ∧
        ∀ S : Subalgebra A (FractionRing A), S = ⊥ ∨ S = ⊤
    ] := by
  -- 1 → 2
  tfae_have 1 → 2
  | h => ⟨inferInstance, inferInstance, h.not_isField⟩
  -- 2 → 1
  tfae_have 2 → 1
  | ⟨hN, hV, hF⟩ => by
    haveI := hN; haveI := hV
    haveI : IsLocalRing A := inferInstance
    have hF' : ¬IsField A := hF
    exact ((IsDiscreteValuationRing.TFAE A hF').out 1 0).mp hV
  -- 1 → 3
  tfae_have 1 → 3
  | h => ⟨inferInstance, inferInstance, h.not_isField⟩
  -- 3 → 1
  tfae_have 3 → 1
  | ⟨hL, hP, hF⟩ => by
    haveI := hL; haveI := hP
    exact { not_a_field' := isField_iff_maximalIdeal_eq.not.mp hF }
  -- 1 → 4
  tfae_have 1 → 4
  | h => by
    haveI := h
    refine ⟨inferInstance, inferInstance, inferInstance, ?_⟩
    have hF := h.not_isField
    have h_tfae := IsDiscreteValuationRing.TFAE A hF
    have h03 : IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime :=
      (h_tfae.out 0 3).mp h
    exact h03.2
  -- 4 → 1
  tfae_have 4 → 1
  | ⟨hIC, hN, hL, huniq⟩ => by
    haveI := hIC; haveI := hN; haveI := hL
    have ⟨P, ⟨hPbot, hPprime⟩, _⟩ := huniq
    have hF : ¬IsField A := fun hF =>
      hPbot (le_bot_iff.mp ((le_maximalIdeal hPprime.ne_top).trans
        (isField_iff_maximalIdeal_eq.mp hF).le))
    exact ((IsDiscreteValuationRing.TFAE A hF).out 3 0).mp
      (show IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime from ⟨hIC, huniq⟩)
  -- 1 → 5
  tfae_have 1 → 5
  | h => by
    haveI := h
    exact ⟨inferInstance, inferInstance, maximalIdeal A, maximalIdeal.isMaximal A,
      finrank_CotangentSpace_eq_one A⟩
  -- 5 → 1
  tfae_have 5 → 1
  | ⟨hN, hL, m, hmax, hfin⟩ => by
    haveI := hN; haveI := hL
    have hm : m = maximalIdeal A := eq_maximalIdeal hmax
    subst hm
    exact finrank_CotangentSpace_eq_one_iff.mp hfin
  -- 1 → 6
  tfae_have 1 → 6
  | h => by
    haveI := h
    have hF := h.not_isField
    refine ⟨inferInstance, inferInstance, maximalIdeal A, maximalIdeal.isMaximal A,
      IsDiscreteValuationRing.not_a_field A, ?_⟩
    exact ((IsDiscreteValuationRing.TFAE A hF).out 0 4).mp h
  -- 6 → 1
  tfae_have 6 → 1
  | ⟨hN, hL, m, hmax, hne, hprinc⟩ => by
    haveI := hN; haveI := hL
    have hm_eq : m = maximalIdeal A := eq_maximalIdeal hmax
    subst hm_eq
    have hF : ¬IsField A := isField_iff_maximalIdeal_eq.not.mpr hne
    exact ((IsDiscreteValuationRing.TFAE A hF).out 4 0).mp hprinc
  -- 1 → 7
  tfae_have 1 → 7
  | h => by
    haveI := h
    have hF := h.not_isField
    refine ⟨inferInstance, inferInstance, hF, ?_⟩
    exact dvr_subalgebra_eq_bot_or_top
  -- 7 → 1
  tfae_have 7 → 1
  | ⟨hN, hL, hF, hmax⟩ => by
    haveI := hN; haveI := hL
    exact maximal_noetherian_local_is_dvr hF hmax
  tfae_finish
