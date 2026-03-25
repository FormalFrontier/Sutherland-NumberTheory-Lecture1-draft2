It is easy to verify that every valuation ring $A$ is in fact a ring, and even an integral domain (if $x$ and $y$ are nonzero then $v(xy) = v(x) + v(y) \neq \infty$, so $xy \neq 0$), with $k$ as its fraction field. Notice that for any $x \in k^\times$ we have $v(1/x) = v(1) - v(x) = -v(x)$, so at least one of $x$ and $1/x$ has nonnegative valuation and lies in $A$. It follows that $x \in A$ is invertible (in $A$) if and only if $v(x) = 0$, hence the unit group of $A$ is

$$A^\times = \{x \in k : v(x) = 0\}.$$

We can partition the nonzero elements of $k$ according to the sign of their valuation. Elements with valuation zero are units in $A$, elements with positive valuation are non-units in $A$, and elements with negative valuation do not lie in $A$, but their multiplicative inverses are non-units in $A$. This leads to a more general notion of a valuation ring.

