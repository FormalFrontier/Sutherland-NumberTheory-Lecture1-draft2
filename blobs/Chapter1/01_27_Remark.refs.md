# References for 01_27_Remark

## Mathlib Coverage

**Status:** partial

The remark discusses 𝒪_K as the maximal order (free ℤ-module of rank [K:ℚ]). The finiteness/freeness of 𝒪_K as a ℤ-module is in Mathlib. The 'order' concept (sub-ℤ-algebra that is a free ℤ-module of rank n) is not a standalone Mathlib type.

### Relevant Declarations

- `NumberField.RingOfIntegers.isIntegrallyClosed` (Mathlib.NumberTheory.NumberField.Basic)
  𝓞 K is integrally closed in K.

## Gaps / Original Work Needed

- Formalization of the concept of an 'order' in a finite-dimensional ℚ-algebra (sub-ℤ-algebra that is a free ℤ-module of rank [K:ℚ])
- Proof that 𝒪_K is a maximal order

## External Sources

- **Neukirch, Algebraic Number Theory, Chapter I §2**
  Detailed treatment of orders in number fields.

- **Cohen, A Course in Computational Algebraic Number Theory, Chapter 2**
  Computational perspective on orders.
