# 1 Absolute values and discrete valuations

## 1.1 Introduction

At its core, number theory starts with the ring $\mathbb{Z}$. By the fundamental theorem of arithmetic, every element of $\mathbb{Z}$ can be written uniquely as a product of primes (up to multiplication by a unit $\pm 1$), so it is natural to focus on the prime elements of $\mathbb{Z}$. If $p$ is a prime, the ideal $(p) \colonequals p\mathbb{Z}$ is a maximal ideal ($\mathbb{Z}$ has Krull dimension one), and the residue field $\mathbb{Z}/p\mathbb{Z}$ is the finite field $\mathbb{F}_p$ with $p$ elements. The fraction field of $\mathbb{Z}$ is the field $\mathbb{Q}$ of rational numbers.

The field $\mathbb{Q}$ and the finite fields $\mathbb{F}_p$ together make up the prime fields: every field $k$ contains exactly one of them, according to its characteristic: $k$ has characteristic zero if and only if it contains $\mathbb{Q}$, and $k$ has characteristic $p$ if and only if $k$ contains $\mathbb{F}_p$.

One can also consider finite extensions of $\mathbb{Q}$, such as the field $\mathbb{Q}(i) \colonequals \mathbb{Q}[x]/(x^2+1)$. These are called *number fields*, and each can be constructed as the quotient of the polynomial ring $\mathbb{Q}[x]$ by one of its maximal ideals; the ring $\mathbb{Q}[x]$ is a principal ideal domain and its maximal ideals can all be written as $(f)$ for some monic irreducible $f \in \mathbb{Z}[x]$.

Number fields are one of two types of *global fields*; the others are *global function fields*. Let $\mathbb{F}_q$ denote the field with $q$ elements, where $q$ is any prime power. The polynomial ring $\mathbb{F}_q[t]$ has much in common with the integer ring $\mathbb{Z}$. Like $\mathbb{Z}$, it is a principal ideal domain of dimension one, and the residue fields $\mathbb{F}_q[t]/(f)$ one obtains by taking the quotient by a maximal ideal $(f)$, where $f \in \mathbb{F}_q[t]$ is any irreducible polynomial, are finite fields $\mathbb{F}_{q^d}$, where $d$ is the degree of $f$. In contrast to the situation with $\mathbb{Z}$, the residue fields of $\mathbb{F}_q[t]$ all have the same characteristic as its fraction field $\mathbb{F}_q(t)$, which plays a role analogous to $\mathbb{Q}$. Global function fields are finite extensions of $\mathbb{F}_q(t)$.

Associated to each global field $k$ is an infinite collection of *local fields* corresponding to the completions of $k$ with respect to its absolute values; when $k = \mathbb{Q}$, these completions are the field of real numbers $\mathbb{R}$ and the $p$-adic fields $\mathbb{Q}_p$ (as you will prove on Problem Set 1).

The ring $\mathbb{Z}$ is a principal ideal domain (PID), as is $\mathbb{F}_q[t]$, and in such fields every nonzero prime ideal is maximal and thus has an associated *residue field*. For both $\mathbb{Z}$ and $\mathbb{F}_q[t]$ these residue fields are finite, but the characteristics of the residue fields of $\mathbb{Z}$ are all different (and distinct from the characteristic of its fraction field), while those of $\mathbb{F}_q[t]$ are all the same.

