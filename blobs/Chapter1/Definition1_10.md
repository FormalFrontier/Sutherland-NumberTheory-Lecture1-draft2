**Definition 1.10.** A *valuation* on a field $k$ is a group homomorphism $k^\times \to \mathbb{R}$ such that for all $x, y \in k$ we have

$$v(x + y) \geq \min\!\bigl(v(x), v(y)\bigr).$$

We may extend $v$ to a map $k \to \mathbb{R} \cup \{\infty\}$ by defining $v(0) \colonequals \infty$. For any $0 < c < 1$, defining $|x|_v \colonequals c^{v(x)}$ yields a nonarchimedean absolute value. The image of $v$ in $\mathbb{R}$ is the *value group* of $v$. We say that $v$ is a *discrete valuation* if its value group is equal to $\mathbb{Z}$ (every discrete subgroup of $\mathbb{R}$ is isomorphic to $\mathbb{Z}$, so we can always rescale a valuation with a discrete value group so that this holds). Given a field $k$ with valuation $v$, the set

$$A \colonequals \{x \in k : v(x) \geq 0\},$$

is the *valuation ring* of $k$ (with respect to $v$). A *discrete valuation ring* (DVR) is an integral domain that is the valuation ring of its fraction field with respect to a discrete valuation; such a ring $A$ cannot be a field, since $v(\operatorname{Frac} A) = \mathbb{Z} \neq \mathbb{Z}_{\geq 0} = v(A)$.

