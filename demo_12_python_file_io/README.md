# File I/O: Reading and Writing Files

File I/O is the term for interacting with the file system on your computer. 
It is the processes surrounding the ```I```nput and ```O```utput of ```File```s. 

## What Kinds of Files Are There?

For small projects, you might use a spreadsheet program or word processing software.
For anything larger than a few megabytes, however, 
these file formats are cumbersome. 
In contrast, text files are a very efficient storage medium:
they have very little overhead. 

Consider the following exercise.
Open your favorite word processor, such as Microsoft Word, 
and open a blank document and immediately save it with an appropriate extension, 
such as ```empty.docx```.
Then open a spreadsheet program and save a blank spreadsheet with a name like
```empty.xlsx``` in the same folder.
Now save a blank file in a text editor such as Notepad and call it ```empty.txt```. 
Now play a game that you might call "file storage golf."
Which one is the winner? The one with the smallest size of an empty file. 

Now, for round two, try it with the simplest possible nonempty document:
put one character on the first line. 
Ten out of ten times the text file comes out ahead. 
Why? Other file formats often need to store information about
the look of the document in a header, at the top of the file, 
and a footer, at the bottom of the file. 
In contrast, text files only store the contents that you see, 
without any formatting. 

This makes text files, such as csv files, the leading choice for 
storing and processing data. 
A text file is basically a collection of strings, 
which python can handle efficiently. 
This makes python a good choice for processing a large volume
of data stored in text files. 

Another type of file is a database, which we will cover in Chapter 17. 
Databases provide a very efficient way to not only store data
but also to join data into new combinations. 
First, we will start with the basic techniques of file handling. 



### Specifying Which File You Want

First, you have to set the directory to the folder
in which this file is located. 
The ```os``` module interacts with the operating system
to get and set the current working directory.


```python 
>>> import os
>>> os.getcwd()
'/path/to/my/current/folder'
```

Use the function ```chdir``` to change directories. 

```python
>>> os.chdir('/path/to/my/new/folder')
>>> os.getcwd()
'/path/to/my/new/folder'
``` 

In many versions, you have to use double backslashes instead of 
forward-slashes, since those are special characters.


```python
>>> os.chdir('C:\\path\\to\\my\\new\\folder')
>>> os.getcwd()
'C:\\path\\to\\my\\new\\folder'
``` 

If the location ```my\\new\\folder``` contains the file 
```file_example.txt```, you can read the contents of this file as follows.

```python 
file = open('file_example.txt', 'r')
contents = file.read()
file.close()
print(contents)
``` 

This code block makes a connection to the file ```file_example.txt``` 
and reads those contents in one string. 
It closes the connection and prints those contents to screen. 

```python 
First line of text.
Second line of text.
Third line of text.
``` 

Instead of using the ```os``` module to set the directory, 
you can open the file with the *absolute path* and work in another location. 
To do this, you specify the path the way you would 
to navigate in a UNIX environment.
Some examples include:


```python 
file_1 = open('data/data1.txt', 'r')
file_2 = open('../data2.txt', 'r')
file_3 = open('../../../data/data3.txt', 'r')
``` 
In the first case, the file ```data1.txt``` is one folder down, 
within the folder ```data```. 
In the second case, the file ```data2.txt``` is one folder up: 
the folder containing the current folder. 
In the third case, to access the file ```data3.txt```, you have to 
move three folder up and then move into another folder called ```data```, 
which contains the file ```data3.txt```. 




### Reading files

You can use the ```with``` command to interact with a file. 

Examples:

```python
with open('file_to_read.txt', 'r') as open_file:
  all_text = open_file.read()
```
The argument ```'r'``` specifies that you want to ```r```ead from the file. 
The above code block reads the entire contents of the file into one object ```all_text```. 
You can also read one or more lines at a time with the ```readline()``` method for files.

```python
with open('file_to_read.txt', 'r') as open_file:
	line = open_file.readline()
	while line:
  	print(line)
  	line = open_file.readline()
```

You can also think of the file as an object and assign the file to a variable name.
This is how it is done in a popular book on computing:

```python
inputFile = open('file_to_read.txt', 'r')
firstLine = inputFile.readline()
secondLine = inputFile.readline()
thirdLine = inputFile.readline()
```

Whatever style you choose, make sure that you produce something that is readable and is easily understood by a future user (who could be you).


### Writing to files

Similarly, there are two styles that achieve the same outcome.
One way is considered good programming practice by many, since it makes clear that the writing is happening in the indented code.
It also automatically closes the file when the indenting ends.

```python
with open('file_to_save.txt', 'w') as open_file:
  open_file.write('A string to write')
```
Some people will complain if you do it the next way but it gets the job done.
You might find this more clear about each operation but it also requires that you keep track of the currently open files (and be sure to close them!).

```python
open_file = open('file_to_save.txt', 'w')
open_file.write('A string to write')
open_file.close()
```
The second approach, however, lends itself more easily to printing output to file that takes place in several places throughout a more complex script.

There exist many ways to read and write files
and the best method to use depends on the context. 
In some cases, the data are organized into a standard 
format so that modules are available to simplify the process. 




### The ```csv``` Module

This allows you to read and write tabular data in csv format.





```python
import csv
with open('my_new_csv_file.csv', 'w') as csvfile:
    my_writer_object = csv.writer(csvfile, delimiter=',',
                            quotechar='"', quoting=csv.QUOTE_MINIMAL)
    my_writer_object.writerow([1,2,3,4,7])
    my_writer_object.writerow([21,22,33,34,37])
```

To read the rows from this file just created, 
```python
with open('my_new_csv_file.csv', 'r') as csvfile:
     my_reader_object = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in my_reader_object:
         print(row)
         print(', '.join(row))
```
This uses a loop along the rows of the file.


Here is an example stolen right from the python documentation
(it's one of the silliest examples I've found on the internet). 

```python
import csv
with open('eggs.csv', 'w') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    spamwriter.writerow(['Spam'] * 5 + ['Baked Beans'])
    spamwriter.writerow(['Spam', 'Lovely Spam', 'Wonderful Spam'])
```

Note that you can enter whatever you want as the delimiter.


Read the content as above...
```python
import csv
with open('eggs.csv', 'r') as csvfile:
     spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in spamreader:
         print ', '.join(row)
```
...and with the quotes and delimiters as specified, 
it extracts the separate elements from each line. 




### An aside about online help

Sometimes computing demos have strange naming conventions
but this tactic is often used to avoid any confusion about the notation.
For example, you would never expect that the word "Spam"
or "Lovely Spam" had any computational significance,
so it wouldn't be confused with generic notation.
You often see coding examples with names of objects such
"foo", "bar" and "baz" in explanations involving a generic object.

I often use the notation ```my_object```, ```my_file``` and ```my_regression_model``` for a similar reason. 
You can call these objects whatever you want and would normally choose a name for the object that makes sense to people using the application. 



## Opening a File

First, let's create a simple file. 
Create a folder called ```file_examples```. 
Now create a file in a text editor with the following contents
and save it as ```file_example.txt```.

```python 
First line of text.
Second line of text.
Third line of text.
``` 

Now open Python to read this file. 




### The ```with``` Statement

The above method ```file_1 = open('data/data1.txt', 'r')``` works, 
most of the time, but when an error occurs, the program will not execute
the ```file.close()``` command to release the file from memory. 
If your program throws an error between the ```open``` and ```close```
statements, this file connection will remain in memory, 
creating a drag on performance. 

To avoid this problem, use the ```with``` statement. 

```python 
with open('file_example.txt', 'r') as file:
    contents = file.read()

print(contents)
``` 

This has the format of any other kind of indented code block, 
in which the relevant statements are indented beyond the ```with``` keyword. 
With this approach, if an error occurs, the block terminates and
the file connection will automatically be released from memory.


## Techniques for Reading Files

Once you have made a connection to a file, 
there are a number of ways to read the contents. 

### The ```read``` Technique

With the ```read``` technique, 
you read the entire contents of the file into a single string. 

We used this method above with 

```python 
with open('file_example.txt', 'r') as file:
    contents = file.read()

print(contents)
``` 

Clearly, for very large files, this can consume a lot of memory. 
It is often better to read the contents in smaller chunks. 
If an integer is passed to ```read```, 
it will read that specified number of characters. 

```python 
with open('file_example.txt', 'r') as example_file:
    first_ten_chars = example_file.read(10)
    the_rest = example_file.read()

print("The first 10 characters:", first_ten_chars)
print("The rest of the file:", the_rest)
``` 


### The ```readlines``` Technique

Instead of reading by the character, 
which may not be a convenient unit to work with, 
since you might not even know how many characters you need at a time, 
you can get the contents of the file organized 
into separate lines with the ```readlines``` function.

```python 
with open('file_example.txt', 'r') as example_file:
    lines = example_file.readlines()

print(lines)
``` 
This prints the following output. 

```python 
['First line of text.\n', 'Second line of text.\n', 'Third line of text.\n']
``` 
It gives a list of strings, each one containing a newline (```\n```) escape sequence. 

Now consider the file ```planets.txt``` that contains the following text. 

```python 
Mercury
Venus
Earth
Mars
``` 
This code block reads the file, 
prints the contents in a list and then loops through that list 
in reverse order using the built-in function ```reversed```. 

```python 
>>> with open('planets.txt', 'r') as planets_file:
...     planets = planets_file.readlines()
...
>>> planets
['Mercury\n', 'Venus\n', 'Earth\n', 'Mars\n']
>>> for planet in reversed(planets):
...     print(planet.strip())
...
Mars
Earth
Venus
Mercury
``` 

You can perform other operations on this list, 
such as sorting the lines first. 


```python 
>>> with open('planets.txt', 'r') as planets_file:
...     planets = planets_file.readlines()
...
>>> planets
['Mercury\n', 'Venus\n', 'Earth\n', 'Mars\n']
>>> for planet in sorted(planets):
...     print(planet.strip())
...
Earth
Mars
Mercury
Venus

``` 


### The ```for line in file``` Technique

Often, it is useful to process the contents of a file
one line at a time. The ```for line in file``` technique
lets you read a file with the functionality of a ```for``` loop
and the efficiency of working with the contents one line at a time. 

```python 
>>> with open('planets.txt', 'r') as data_file:
...     for line in data_file:
...         print(len(line))
...
8
6
6
5
``` 
This allows you to perform arbitrary calculations using each line in sequence. 
You can combine any other commands, potentially stripping away whitespace first. 

```python 
>>> with open('planets.txt', 'r') as data_file:
...     for line in data_file:
...         print(len(line.strip()))
...
7
5
5
4
``` 

### The ```readline``` Technique

Sometimes you want to perform different operations 
depending on the characteristics of the file. 
You could use a series of ```if``` and ```elif``` statements. 
Instead, you can instruct the python interpreter to 
read a single line of the file, without following a pattern, 
using the ```readline``` technique. 

For example, consider the following dataset, contained in
the file ```hopedale.txt```. 

```python 
Coloured fox fur production, HOPEDALE, Labrador, 1834-1842
#Source: C. Elton (1942) "Voles, Mice and Lemmings", Oxford Univ. Press
#Table 17, p.265--266
      22   
      29   
       2   
      16   
      12   
      35   
       8   
      83   
     166   
``` 

Notice that the first line is a description:
it is a record of the number of fur pelts harvested 
in a region of Canada over a period of several years during the 1800's. 
The next two are preceeded by a ```#``` character
and the data begin on the fourth line.
The following code block reads in the data
and skips over the description in the header. 
The following script calculates the total number of fur pelts. 

```python 
with open('hopedale.txt', 'r') as hopedale_file:

    # Read and skip the description line.
    hopedale_file.readline()

    # Keep reading and skipping comment lines until we read the first piece
    # of data.
    data = hopedale_file.readline().strip()
    while data.startswith('#'):
        data = hopedale_file.readline().strip()
        # Do nothing because these lines do not have data.

    # Now we have the first piece of data.  
    # Accumulate the total number of pelts.
    # Convert the string to an integer for the first value in the sum.
    total_pelts = int(data)

    # Read the rest of the data.
    for data in hopedale_file:
        total_pelts = total_pelts + int(data.strip())

print("Total number of pelts:", total_pelts)
``` 

This script produces the following output. 

```python 
Total number of pelts: 373
``` 

We could perform any other calculations with the lines of data, as follows.

```python 
with open('hopedale.txt', 'r') as hopedale_file:

    # Read and skip the description line.
    hopedale_file.readline()

    # Keep reading and skipping comment lines until we read the first piece
    # of data.
    data = hopedale_file.readline().rstrip()
    while data.startswith('#'):
        data = hopedale_file.readline().rstrip()

    # Now we have the first piece of data.
    print(data)

    # Read the rest of the data.
    for data in hopedale_file:
        print(data.rstrip())

``` 

This produces the following output. 

```python 
      22
      29
       2
      16
      12
      35
       8
      83
     166
``` 
Notice the numbers are aligned
because we stripped the whitespace only on the right side, 
using the ```rstrip()``` function. 

## Files Over the Internet

The above examples assume the file is located on our computer system. 
You can read file located on any computer that is available on the Internet.

The ```urllib``` module has tools for reading files with a given URL.
Note that the file can be encoded in a number of ways. 
This example shows how to read a file encoded in UTF-8. 
This uses a function called ```decode``` to decode the file content 
in the form of bytes to obtain legible characters using UTF-8 encoding. 


```python 
import urllib.request
url = 'https://robjhyndman.com/tsdldata/ecology1/hopedale.dat'
with urllib.request.urlopen(url) as webpage:
    for line in webpage:
        line = line.strip()
        line = line.decode('utf-8')
        print(line)

``` 



## Writing Files

The ```with``` statement can also be used for writing files. 


```python 
with open('topics.txt', 'w') as output_file:
    output_file.write('Computer Science')
``` 
In the above example, the file ```topics.txt``` need not exist:
this file will be created if it does not exist
and it will be overwritten if it does exist. 
The distinction from reading files is shown by the second argument. 
The ```'w'``` denotes *writing*, while, in the earlier examples, 
the argument ```'r'``` indicated that the existing file
would be open for *reading*. 

If the file already exists and you want to write additional content, 
you can pass the argument ```'a'``` to *append*. 

```python 
with open('topics.txt', 'a') as output_file:
    output_file.write('Software Engineering')

``` 

After running this, look at the contents of the new file:

```python
Computer ScienceSoftware Engineering
```

Note that a new line was not automatically added;
you have to include it manually using ```\n```. 


The next example is more complex: it both reads from and writes to a file.
It also uses the ```typing.TextIO``` type annotation for the file. 
The acronym "IO" is short for "Input/Output"

This script defines a function that reads two numbers from an ```input_file```
and writes those numbers, with their sum, in ```output_file```. 

```python 
from typing import TextIO
from io import StringIO

def sum_number_pairs(input_file: TextIO, output_file: TextIO) -> None:
    """Read the data from input_file, which contains two floats per line
    separated by a space. output_file for writing and, for each line in
    input_file, write a line to output_file that contains the two floats from
    the corresponding line of input_file plus a space and the sum of the two
    floats.
    """

    for number_pair in input_file:
        number_pair = number_pair.strip()
        operands = number_pair.split()
        total = float(operands[0]) + float(operands[1])
        new_line = '{0} {1}\n'.format(number_pair, total)
        output_file.write(new_line)

if __name__ == '__main__':
    with open('number_pairs.txt', 'r') as input_file, \
            open('number_pair_sums.txt', 'w') as output_file:
        sum_number_pairs(input_file, output_file)

``` 

Notice that the files are already ```open``` in the main program. 
This way, the open files are passed to the function 
```sum_number_pairs``` and are ready to read and write. 


If the ```input_file``` called ```number_pairs.txt``` contains this content,


```python 
1.3 3.4
2 4.2
-1 1
``` 


then, after running ```sum_number_pairs```,
the ```output_file``` called ```number_pair_sums.txt``` will contain the following. 

```python 
1.3 3.4 4.7
2 4.2 6.2
-1 1 0.0

``` 

