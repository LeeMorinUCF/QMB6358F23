# Numerical Methods in R and Python: Part II


This is the second part of a series of demonstrations on numerical methods.
Last week, we considered the first two of three types of computing problems:

1. Solving a *system of linear equations* for a vector of unknown parameters. 
1. Finding the *root of a non-linear function*, i.e., a parameter input that returns a value of zero from that function. 
1. Solving an *optimization problem*: finding a parameter input that achieves the maximum or minimum value of a particular objective function. 

Today we will investigate the third, which is not so different from the first two problems, 
since the optimization problem is essentially the problem of finding roots of first-order conditions. 
Conversely, one can solve for roots by minimizing the square of the value of the function, 
which should have a minimum value of zero.

First we will revisit Newton's Method for solving roots of equations.


#### Newton's Method

As we discussed last week, Newton's method uses calculus to get a measurement 
of the slope at a given point on the function. 
It chooses the next candidate point by solving for the root of the tangent line at the current point. 
The solution of this linear equation is represented by the following recurrence relation. 

<img src="Images/newtons-method-formula.png" width="500">

Graphically, the first step looks as follows. 

<img src="Images/newtons-method-1st-iteration.png" width="500">

The iterations continue until the desired accuracy level is achieved. 

<img src="Images/newtons-method-iterations.png" width="500">

In light of this, now consider the problem of optimization.


## Optimization

### The problem

Solving an *optimization problem* involves finding a parameter input that achieves the maximum or minimum value of a particular objective function. 
The problem is similar in nature to the root-finding problem, except that the objective is to search for a root of the derivative of the function. 
An optimum will be located where the function is flat, that is, where the slope of the function is equal to zero. 

### The solution

Now consider the Newton-Raphson method for optimization.  
The idea behind this algorithm is the same as that for finding roots:
calculate a second-order approximation to the function at the current point
and then solve this approximation for its optimum. 
The optimum of the approximation is used as the next step toward the optimum of the function. 
The recurrence relation for the Newton-Raphson method is shown below for both the single-variable and multi-variable optimization problems. 

<img src="Images/Newtons_Method_Table.jpg" width="500">

Graphically, the algorithm proceeds as shown in the following two figures. 

<img src="Images/Optimization_Newtons_Method.png" width="500">

<img src="Images/Optimization_Newtons_Method_2.png" width="500">

### Examples

In ```R```, when solving a single-variable optimization problem, 
the ```optimize``` function.

```
f <- function (x, a) (x - a)^2
xmin <- optimize(f, c(0, 1), tol = 0.0001, a = 1/3)

xmin
$minimum
[1] 0.3333333

$objective
[1] 0
```
COnsider the following example of a multivariate function,
calculated with the BFGS algorithm, a variant of Newton's method. 

```
# The Rosenbrock "Banana" function is a good example.
f_banana <- function(x) {
  x1 <- x[1]
  x2 <- x[2]
  100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}
# Supply the calculation of the gradient to improve optimization.
# Gradient means a vector of first derivatives.
gr_banana <- function(x) { ## Gradient of 'fr'
  x1 <- x[1]
  x2 <- x[2]
  c(-400 * x1 * (x2 - x1 * x1) - 2 * (1 - x1), # Dx_1
    200 *      (x2 - x1 * x1))# Dx_2
}

# Optimize the function itself.
optim(c(-1.2,1), f_banana)

# Optimize with vector of derivatives (the BFGS algorithm is a quasi-Newton method).
soln_banana <- optim(c(-1.2,1), f_banana, gr_banana, method = "BFGS")
```

As mentioned above, in the linear regression model, the objective is to find the value of the coefficients that minimize the sum of squared errors. 
Similarly, in the logistic regression model, the objective is to find the value of the coefficients that maximize the likelihood of the sample. 
This solution differs for the logistic regression model in that it is no longer possible to reduce the problem to a system of linear equations: it is inherently a nonlinear problem. 
However, the solution is not as different as one might imagine, since the intermediate steps are very similar as the algorithm approaches the solution by iteration. 
In fact, in each step of the multivariate optimization with the Newton-Raphson method, the step is calculated by solving a linear system of equations at each step. 


