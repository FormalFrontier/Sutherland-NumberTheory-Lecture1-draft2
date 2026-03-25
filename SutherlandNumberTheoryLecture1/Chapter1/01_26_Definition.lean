import Mathlib.Tactic.Recall
import Mathlib.NumberTheory.NumberField.Basic

/-!
## Definition 1.26 — Number Fields and Rings of Integers

**Definition 1.26.** A *number field* `K` is a finite extension of `ℚ`.
The *ring of integers* `𝒪_K` is the integral closure of `ℤ` in `K`.

### Mathlib correspondence

- `NumberField K` — the class asserting `[K : ℚ] < ∞` (with `CharZero K`)
- `NumberField.RingOfIntegers K` (also written `𝓞 K`) — defined as `integralClosure ℤ K`
-/

/-- **Definition 1.26.** A *number field* is a field that is a finite extension of `ℚ`. -/
recall NumberField (K : Type*) [Field K] : Prop

/-- **Definition 1.26.** The *ring of integers* `𝓞 K` is the integral closure of `ℤ` in `K`. -/
recall NumberField.RingOfIntegers (K : Type*) [Field K] : Type _
