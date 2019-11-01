# Tips from the Python Documentation
[Docs](https://docs.python.org/3.7/tutorial/introduction.html)
```python
#In interactive mode, the last printed expression is assigned to the variable _
>>> 5
5
>>> _ * 10
50
>>> 

#If you don’t want characters prefaced by \ to be interpreted as special characters, you can use raw strings by adding an r before the first quote:
>>> print(r'C:\some\name')  # note the r before the quote
C:\some\name


# \ helps supress the lines in multi-line comments
>>> print("""\
line 1
line 2\
""")
line 1
line 2
>>> 

#Use another character instead of new line when printing
#Useful for builing a comma separated quoted string
>>> for i in range(5):
	print(i, end="','")


```
