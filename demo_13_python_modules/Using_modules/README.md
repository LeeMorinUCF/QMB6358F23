# Chapter 6: A Modular Approach to Program Organization

You can often solve problems by using programs 
and functions designed by others, rather than solving these 
problems on your own. 
A great advantage of Python is that there exists a large community 
of programmers who contribute their own functions.
The typical unit for a set of functions and programs is a *module*. 


## Importing Modules

To gain access to the functions in a module, you *import* it.

```python 
import math
```
The ```math``` module contains a set of mathematical operations. 

A module has type ```module```.
```python 
>>> type(math)
<class 'module'>
``` 
You can access the help for all the functions in a module just as you
would for a single function, with the ```help``` function. 

```python 
>>> help(math)
Help on module math:

NAME
    math

MODULE REFERENCE
    https://docs.python.org/3.6/library/math

    The following documentation is automatically generated from the Python
    source files.  It may be incomplete, incorrect or include features that
    are considered implementation detail and may vary between Python
    implementations.  When in doubt, consult the module reference at the
    location listed above.

DESCRIPTION
    This module is always available.  It provides access to the
    mathematical functions defined by the C standard.

FUNCTIONS
    acos(...)
        acos(x)
        Return the arc cosine (measured in radians) of x.

    acosh(...)
        acosh(x)
        Return the inverse hyperbolic cosine of x.

[Lots of other functions not shown here.]

``` 

Many common functions--many functions that you might expect would come 
standard with Python--are not available unless you import them
in a module,

```python 
>>> sqrt(9)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'sqrt' is not defined

``` 
After the ```import math``` statement, these functions are available
using the prefix ```math```. 

```python 
>>> math.sqrt(9)
3.0

``` 
Even the number ```pi``` requires the ```math``` module, 
along with other constants. 

```python 
>>> import math
>>> math.pi
3.141592653589793
>>> radius = 5
>>> print('area is', math.pi * radius ** 2)
area is 78.53981633974483

``` 

You *could* overwrite these values, since they are variables 
like any other, but that is a bad idea, since users would not expect this. 


```python 
>>> import math
>>> math.pi = 3 # DON'T do this!
>>> radius = 5
>>> print('area is', math.pi * radius ** 2)
area is 75

``` 
You don't need to import the entire module. 
You could import only the particular functions and constants that you need. 
When you use the ```from``` keyword, it pulls certain elements
by name. 

```python 
>>> from math import sqrt, pi
>>> sqrt(9)
3.0
>>> radius = 5
>>> print('circumference is', 2 * pi * radius)
circumference is 31.41592653589793

``` 
Now these can be referenced as they are named. 
Since they have different names, there are no functions under the
usual name that would be assigned if the entire module were imported. 

```python 
>>> from math import sqrt, pi
>>> math.sqrt(9)
Traceback (most recent call last):
  File "<pyshell#12>", line 1, in <module>
    math.sqrt(9)
NameError: name 'math' is not defined
>>> sqrt(9)
3.0
``` 


A good practice is to select only the functions you need. 
Otherwise, if you select all the functions (using the *wildcard* ```*```)
many functions will be imported into the namespace, 
which could cause conflicts with other variables
that may already have the same names. 


```python 
>>> from math import *
>>> print(sqrt(8))
2.8284271247461903

``` 


#### Module ```__builtins__```

Many functions are built into Python. 
These are collected within the ```__builtins__``` module. 
You might recognize some of the functions that we have used already. 

```python 
>>> dir(__builtins__)
['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException',
'BlockingIOError', 'BrokenPipeError', 'BufferError', 'BytesWarning',
'ChildProcessError', 'ConnectionAbortedError', 'ConnectionError',
'ConnectionRefusedError', 'ConnectionResetError', 'DeprecationWarning',
'EOFError', 'Ellipsis', 'EnvironmentError', 'Exception', 'False',
'FileExistsError', 'FileNotFoundError', 'FloatingPointError', 'FutureWarning',
'GeneratorExit', 'IOError', 'ImportError', 'ImportWarning', 'IndentationError',
'IndexError', 'InterruptedError', 'IsADirectoryError', 'KeyError',
'KeyboardInterrupt', 'LookupError', 'MemoryError', 'ModuleNotFoundError',
'NameError', 'None', 'NotADirectoryError', 'NotImplemented',
'NotImplementedError', 'OSError', 'OverflowError', 'PendingDeprecationWarning',
'PermissionError', 'ProcessLookupError', 'RecursionError', 'ReferenceError',
'ResourceWarning', 'RuntimeError', 'RuntimeWarning', 'StopAsyncIteration',
'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError', 'SystemExit',
'TabError', 'TimeoutError', 'True', 'TypeError', 'UnboundLocalError',
'UnicodeDecodeError', 'UnicodeEncodeError', 'UnicodeError',
'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning', 'ValueError',
'Warning', 'ZeroDivisionError', '_', '__build_class__', '__debug__', '__doc__',
'__import__', '__loader__', '__name__', '__package__', '__spec__', 'abs', 'all',
'any', 'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'callable', 'chr',
'classmethod', 'compile', 'complex', 'copyright', 'credits', 'delattr', 'dict',
'dir', 'divmod', 'enumerate', 'eval', 'exec', 'exit', 'filter', 'float',
'format', 'frozenset', 'getattr', 'globals', 'hasattr', 'hash', 'help', 'hex',
'id', 'input', 'int', 'isinstance', 'issubclass', 'iter', 'len', 'license',
'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object', 'oct',
'open', 'ord', 'pow', 'print', 'property', 'quit', 'range', 'repr', 'reversed',
'round', 'set', 'setattr', 'slice', 'sorted', 'staticmethod', 'str', 'sum',
'super', 'tuple', 'type', 'vars', 'zip']

``` 

You should avoid naming any variable using the names of functions in 
the ```__builtins__``` module. 



## Application: Interacting with the Operating System with ```os```

When you run a program in the terminal window, python assumes that any
interaction with files will occur in the directory in which you are running the program.
That is, the default *working directory* is the location in which you run your python script. 
For many applications, such as working with data, you need your program to specify
the working directory from which the data can be located. 
The ```os``` module helps with this function. 
You write

```python
import os
```
typically, at the top of your script, along with the ```import```s of other modules.

First, you can find out where you are working right now with ```os.getcwd()```.
This function *get*s your *c*urrent *w*orking *d*irectory. 

```python
# Find out the current directory.
>>> os.getcwd()
'C:\\Users\\user_name\\path\\to\\other\\files'
```

Typically, in a GUI such as Anaconda, this will point at your default user location
but it may also be set to the place where you were last working.
*Ch*ange it to another *dir*ectory with ```os.chdir```

```python
# Change to a new directory.
>>> os.chdir('C:\\Users\\user_name\\path\\to\\folder\\I\\want')
```
This operation happens silently, if it worked. 

```python
>>> os.chdir('C:\\Users\\user_name\\path\\to\\folder\\I\\want')
```
If you want to verify the directory you just changed to, 
use the ```os.getcwd``` function again.

```python
>>> os.getcwd()
'C:\\Users\\user_name\\path\\to\\folder\\I\\want'
```
Hopefully, you get the folder you want. 
If the directory name is spelled wrong, it will not be changed 
and python will throw an error. 

```python
>>> os.chdir('C:\\Users\\user_name\\folder\\spelled\\incorrectly')
[WinError 3] The system cannot find the path specified: 'C:\\Users\\user_name\\folder\\spelled\\incorrectly'
>>> os.getcwd()
'C:\\Users\\user_name\\path\\to\\other\\files'
```

Notice, in the paths above, the double backslash ```\\```.
The first is the escape sequence for the second backslash
to be written in the string containing the path.
You have to change this yourself if you copy the path from
the address bar in a program such as Windows Explorer, 
because those paths will have forward slashes instead. 


```python
>>> os.chdir('C:\Users\user_name\folder\with\single\baskslashes')
"C:\Users\user_name\folder\with\single\baskslashes"
    ^
SyntaxError: (unicode error) 'unicodeescape' codec can't decode bytes in position 2-3: truncated \UXXXXXXXX escape
>>> os.getcwd()
'C:\\Users\\user_name\\path\\to\\other\\files'
```

In the case above, Python confuses the characters ```\U```
for an escape sequence, much like ```\t``` represents a tab,
```\n``` represents a new line
and ```\'``` represents a single quote. 
The double backslash ```"\\"``` represents a single backslash
```"\"``` to avoid this confusion. 

