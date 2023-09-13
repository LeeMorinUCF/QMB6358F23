


# The sum() function works with numbers.
sum(1:5)

# It throws an error with a character argument.
sum('5')
# Error in sum("5") : invalid 'type' (character) of argument


# Good documentation helps the user avoid errors.
my_sum <- function(x) {
  
  # My function to calculate sum.
  
  # Calculates sum of the numbers in the vector x.
  # Note to user: Elements of x must be numbers, 
  # or else this function will FAIL!
  
  return(sum(x))
  
}

# Sometimes the potential errors are more complicated and 
# difficult for your users to predict. 
# In some cases, it is worth including some logic to 
# determine whether the arguments are valid.

# There are several ways of handling errors. 
# One is to catch them in advance and throw an error yourself
# using the stop() function.
my_sum <- function(x) {
  
  if (class(x) %in% c('numeric', 'integer', 'logical')) {
    return(sum(x))
  } else {
    stop('Error in my_sum(). Elements in x must be numbers.')
  }
  
}

my_sum(1:5)

my_sum('5')


# If you are using an existing function, 
# potentially one that is complicated enough that you do not understand
# how it works, you can use the try() function to handle errors 
# without halting the program.



# Handling errors.
my_value <- try(y <- my_sum(x = 1:5))

# If it works, it assigns the output to the variable my_sum.

# If not, it returns a 'try-error' object to indicate the error.


# You might use this by first testing whether the quantity 
# throws an error.
if (class(try(my_value <- my_sum(x = 1:5))) != 'try-error') {
  
  print('Calculation of my_sum was successful.')
} else {
  print('Error in my_sum.')
}

if (class(try(my_value <- my_sum(x = '5'))) != 'try-error') {
  
  print('Calculation of my_sum was successful.')
} else {
  print('Error in my_sum.')
}
# Notice that the program continued, even though it threw an error message.


# If you want to use the assigned value in a calculation, 
# or make an adjustment in the event of an error, 
# one way is to modify the value in the event of an error.
if (class(try(my_value <- my_sum(x = '5'))) == 'try-error') {
  
  my_value <- 0
} 
print(my_value)



# Another way is to initialize the value with a default
# and overwrite it if the function call is successful.
my_value <- NA
try(my_value <- my_sum(x = 1:5))
print(my_value)

my_value <- NA
try(my_value <- my_sum(x = '5'))
print(my_value)

# Finally, you can use some logic to determine whether 
# the default value remains and overwrite it with
# a valid value if necessary.
my_value <- NA
try(my_value <- my_sum(x = '5'))
if (is.na(my_value)) {
  my_value <- 0
}
print(my_value)


# Notice that the variable assigned in the try() expression
# will not exist if it is designed to be created at that line.
try(my_new_value <- my_sum(x = '5'))

print(my_new_value)
# Error in print(my_new_value) : object 'my_new_value' not found

# When writing a function, you should take care that
# all variables that may be used later will exist
# in any state, error or not.
# This is the purpose for using the stop() function in the first place, 
# so when you circumvent that functionality, you might cause problems downstream.

