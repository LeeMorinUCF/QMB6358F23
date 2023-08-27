
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Examples of Numerical Methods in R
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business
# University of Central Florida
#
# August 11, 2020
#
################################################################################
#
# This program provides introductory examples of numerical methods
# for optimization.
#
#
#
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load library of functions.
# source('MyRcode1.R')

# Load packages.
# library(name_of_R_package_goes_here)


# Set working directory.
# wd_path <- '/path/to/your/folder'
# Not required, since this program does not interact with other files.
# setwd(wd_path)




################################################################################
# Optimization
################################################################################

#--------------------------------------------------
# Single variable equations
#--------------------------------------------------

f <- function (x, a) (x - a)^2
xmin <- optimize(f, c(0, 1), tol = 0.0001, a = 1/3)
xmin


# You can make your function print out a progress report to see the iterations.
# Get the function to print to see where the function is evaluated:
# optimize(function(x) x^2*(print(x)-1), lower = 0, upper = 10)
# f2 <- function(x) x^2*(print(x)-1)
f2 <- function(x) {
  print(x)
  x^2*(x-1)
  }
optimize(f2, lower = 0, upper = 10)



# Now try a problem that is numerically challenging.
# "wrong" solution with unlucky interval and piecewise constant f():
f  <- function(x) ifelse(x > -1, ifelse(x < 4, exp(-1/abs(x - 1)), 10), 10)
fp <- function(x) { print(x); f(x) }

# Plot it to see what is going on.
plot(f, -2,5, ylim = 0:1, col = 'red', lwd = 2)
plot(f, xlim = c(-2,5), ylim = c(0,10), col = 'red', lwd = 2)
optimize(fp, c(-4, 20))   # doesn't see the minimum
optimize(fp, c(-7, 20))   # ok
# If you know the solution is in a particular range,
# the algorithm will work better:
optimize(fp, c(0, 2))
optimize(fp, c(0.9, 1.2))
# In some spots, it won't find the solution.
optimize(fp, c(5, 12))



#--------------------------------------------------
# Multiple variable equations
#--------------------------------------------------

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


# There are many algorithms to perform the solution.
# In practice, you might try several, to make sure
# that your "solution" is in fact an optimum.
# Compare with other algorithms:
# This calculates the Hessian (second derivatives):
optimHess(soln_banana$par, f_banana, gr_banana)
# It is calculated with the hessian = TRUE argument.
optim(c(-1.2,1), f_banana, NULL, method = "BFGS", hessian = TRUE)


## These do not converge in the default number of steps
optim(c(-1.2,1), f_banana, gr_banana, method = "CG")
optim(c(-1.2,1), f_banana, gr_banana, method = "CG", control = list(type = 2))
optim(c(-1.2,1), f_banana, gr_banana, method = "L-BFGS-B")
# But most of them are close.


#--------------------------------------------------
# Multivariate optimization with constraints
#--------------------------------------------------

# Consider another function.
f_bound <- function(x) {
  p <- length(x); sum(c(1, rep(4, p-1)) * (x - c(1, x[-p])^2)^2)
}

# 25-dimensional box constrained
optim(rep(3, 25), f_bound, NULL, method = "L-BFGS-B",
      lower = rep(2, 25), upper = rep(4, 25)) # par[24] is *not* at boundary


# One more challenging function.
# "wild" function , global minimum at about -15.81515

f_wild <- function (x) {
  10*sin(0.3*x)*sin(1.3*x^2) + 0.00001*x^4 + 0.2*x+80
}
plot(f_wild, -50, 50, n = 1000, main = "optim() minimising 'wild function'")

soln_wild <- optim(50, f_wild, method = "SANN",
             control = list(maxit = 20000, temp = 20, parscale = 20))
soln_wild

# Now improve locally {typically only by a small bit}:
soln_wild_2 <- optim(soln_wild$par, f_wild, method = "BFGS")


# Plot the optimum over the plot of the function.
points(soln_wild_2$par,  soln_wild_2$value,  pch = 8, col = "red", cex = 2)



################################################################################
# End
################################################################################


