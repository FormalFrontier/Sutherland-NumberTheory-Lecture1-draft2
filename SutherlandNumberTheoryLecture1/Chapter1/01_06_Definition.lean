import Mathlib.Analysis.AbsoluteValue.Equivalence

/-!
## Definition 1.6 — Equivalence of Absolute Values

**Definition 1.6.** Two absolute values `|·|` and `|·|'` on the same field `k` are
*equivalent* if there exists `α ∈ ℝ_{>0}` such that `|x|' = |x|^α` for all `x ∈ k`.

### Mathlib correspondence

Mathlib's `AbsoluteValue.IsEquiv v w` uses an equivalent characterization via
order-preservation: `∀ x y, v x ≤ v y ↔ w x ≤ w y`. The bridge between the two
is `AbsoluteValue.isEquiv_iff_exists_rpow_eq`.

We prove `AbsoluteValue.AreEquivalent f g ↔ f.IsEquiv g` below.
-/

open AbsoluteValue in
/-- **Definition 1.6.** Two absolute values on `k` are *equivalent* if one is a positive
real power of the other: `∃ α > 0, ∀ x, g x = (f x) ^ α`. -/
def AbsoluteValue.AreEquivalent {k : Type*} [Field k]
    (f g : AbsoluteValue k ℝ) : Prop :=
  ∃ α : ℝ, 0 < α ∧ ∀ x : k, g x = (f x) ^ α

namespace AbsoluteValue

variable {k : Type*} [Field k] {f g : AbsoluteValue k ℝ}

/-- The book's power-law equivalence (Definition 1.6) is equivalent to Mathlib's
order-preserving equivalence (`IsEquiv`). -/
theorem areEquivalent_iff_isEquiv : f.AreEquivalent g ↔ f.IsEquiv g := by
  constructor
  · rintro ⟨α, hα, hfg⟩
    rw [isEquiv_iff_exists_rpow_eq]
    exact ⟨α, hα, funext fun x => (hfg x).symm⟩
  · intro h
    rw [isEquiv_iff_exists_rpow_eq] at h
    obtain ⟨c, hc, hcfg⟩ := h
    exact ⟨c, hc, fun x => (congr_fun hcfg x).symm⟩

end AbsoluteValue
