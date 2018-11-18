# reinforced-concrete
Package to design the cross-section of Reinforced Concrete Structures. This includes a set of functions related to the problem of finding the equilibrium of a reinforced concrete cross-section when submitted to some loading (N, M_x, M_y), typically involving optimization of nonlinear functions. This codes were first developed during the Reinforced Concrete Class at ITA in 2014 and 2015 (called "EDI-38: Concreto Estrutural I").

This method of finding the equilibrium of the cross section involves the optimization of the deformations that corresponds to the loading imposed. To find them, we start with some initial "guess" (initial conditions) for deformation and employ Newton-Raphson optimization to arrive at the correct solution, within some tolerance.
