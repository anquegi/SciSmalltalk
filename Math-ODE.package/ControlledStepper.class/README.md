Many of the above introduced steppers possess the possibility to use adaptive stepsize control. Adaptive step size integration works in principle as follows:

    The error of one step is calculated. This is usually done by performing two steps with different orders. The difference between these two steps is then used as a measure for the error. Stepper which can calculate the error are Error Stepper and they form a own class with an separate concept.
    This error is compared against some predefined error tolerances. Are the tolerance violated the step is reject and the stepsize is decreases. Otherwise the step is accepted and possibly the stepsize is increased.

The class of controlled steppers has its own concept in odeint - the Controlled Stepper concept. They are usually constructed from the underlying error steppers. An example is the controller for the explicit Runge-Kutta steppers. The Runge-Kutta steppers enter the controller as a template argument. Additionally one can pass the Runge-Kutta stepper to the contructor, but this step is not neccessary; the stepper is default-constructed if possible.

Different step size controlling mechanism exist. They all have in common that they somehow compare predefined error tolerance against the error and that they might reject or accept a step. If a step is rejected the step size is usually decreased and the step is made again. Then the procedure of checking the error tolerances and accepting or rejecting a step is made again and repeated until the step is accepted. The procedure is implemented in the integration functions.

A classical way to decide wether a step is rejected or accepted is

val = || | err_i | / ( epsilon-abs + epsilon-rel * ( a_x | x_i | + a_dxdt | | dxdt_i | )||

epsilon-abs and epsilon-rel are the absolute and the relative error tolerances, and || x || is a norm, typically ||x||=(Sum_i x_i^2)^(1/2) or the maximum norm. The step is rejected if val is greater then 1, otherwise it is accepted. For details of the used norms and error tolerance see the table below.

For the 'controlled_runge_kutta' stepper the new step size is then calculated via

val > 1 : dt_new = dt_current max( 0.9 pow( val , -1 / ( O_E - 1 ) ) , 0.2 )

val < 0.5 : dt_new = dt_current min( 0.9 pow( val , -1 / O_S ) , 5 )

else : dt_new = dt_current

Here, O_S and O_E are the order of the stepper and the error stepper. These formulas also contain some safety factors, avoiding that the step size is reduced or increased to much. e order of the stepper and the error stepper. These formulas also contain some safety factors, avoiding that the step size 