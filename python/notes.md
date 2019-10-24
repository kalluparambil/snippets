# My Python Learning Cheat Sheet
[Udemy Course Reference](https://www.udemy.com/share/101r1iAEcZeVpSTHw=/)
## Questions: 
1. What is the difference between lists, tuples, dictionaries etc?
2. 

## Placeholders in Strings
[More info on placeholders here on this site](https://pyformat.info/)

*Example*

```python
sentence = "%s is my name"
sentence%('Rama')
```

*Another way*

```python
'%s %s' % ('one', 'two')

'{} {}'.format('Three', 'Four')
```

## Lists
```python
mylist = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
```
Operation | Example |
--- | --- | 
Select | `mylist`
Insert | `mylist.append('NewDay')`
Update | `mylist[7] = "January"`
Delete | `del mylist[7]`
Length | `del len(mylist)`
Adding Lists | `mylist2 = ["January","February","March"]` <br /> `mylist + mylist2`
Multiplying Lists | `numlist = [1,2,3,4,5]` <br /> `max(numlist)` <br /> `min(numlist)`



## Dictionaries
```python
students = {"Babu":10,"Coumar":11,"Dravid":12}
```
Operation | Example |
--- | --- | 
Select | `students` <br /> `students["Babu"]`
Insert | `students["NewStudent"] = 13`
Update | `students["Babu"] = 9`
Delete | `del(students["Coumar"])`
Length | `len(students)`


## Conditional Statements
```python
if (age < 13):
    print("You are young.")
elif (age >= 13 and age < 18):
    print("You are a Teenager.")
else:
   print("You are an Adult.")
```

## Loops
```python
list1 = ["Apples", "Oranges","Cherries"]
tup1 = (1,2,3)
for item in list1:
    print(item)
for item in tup1:
    print(item)
```

### Skipping in range
```python
for i in range(1,11,2):
    print(i)
```

## While Loop
```python
c = 0
while c < 5:
    print(c)
    c = c + 1
```
    
### While - Break, Continue and Pass
```python
#Break
c = 0
while c < 5:
    c = c + 1
    if c == 3:
        break #Break out of the loop
    print(c)
```

```python

#Continue
c = 0
while c < 5:
    c = c + 1
    if c == 3:
        continue #Skip below statements
    print(c)
```

```python
#Pass
c = 0
while c < 5:
    c = c + 1
    if c == 3:
        pass #Just a null statement
    print(c)

``` 
## Try and Except
```python
try:
    if name > 3:
        print('Greater')
except:
        print('Exception - since name is not defined')
```

## Functions
```python
## Functions
#Define a Function
def Add(num1, num2):
    return(num1 + num2)

#Store the returned value
sum = Add(3, 4)

#Check
print(sum)
```
## Built-in Functions
```python
#Some examples
abs(-13)
bool(1 < 5)
bool(None)
dir("hello")

sent = "hello"
help(sent.upper)

#Dynamically execute code
sent = 'print("Hello")'
eval(sent)
eval("5*3")

#Dynamically execute multi-line Code
exec(sent)

#Convert Number to Str, Float or Int
a = 1
str('a')
float('a')
int('a')
```

## Class
```python
#Defining a class, initializing and then getting
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def getName(self):
        print('Your name is ' + self.name)
    def getAge(self):
        print('Your age is ' + self.age)

#Pass the Age as String
p1 = Person("Uma", "13")
p1.getAge()
p1.getName()
```
## Inheritance
```python
#Defining the Parent
class Parent:
	def __init__(self):
		print('This is the parent class.')
	def parentFunc(self):
		print('This is the parent function.')

#Defining the Child
class Child(Parent):
	def __init__(self):
		print('This is the child class.')
	def childFunc(self):
		print('This is the child function.')

#Instantiate the Child
c1 = Child()
#Call child function
c1.childFunc()
#Call parent function
c1.parentFunc()
This is the parent function.
```
## Reading File Contents
```python
myFile = open("File1.txt")
text = myFile.read()
print(text)

#
position = myFile.tell()
print(position)

#Move the cursor or pointer to the beginning of the file
position = myFile.seek(0,0)
print(position)
text = myFile.read()
print(text)

#
myFile.close()
```
## Writing File Contents
```python
myFile = open("File2.txt","w+")
text = myFile.read()
print(text)
#
myFile.write("First Line of file.\n")
myFile.seek(0,0)
text = myFile.read()
print(text)
#
myFile.write("Second Line of file.\n")
myFile.seek(0,0)
text = myFile.read()
print(text)
#
myFile.close()
```

## Appending to File Contents
```python
myFile = open("File2.txt","a+")
text = myFile.read()
print(text)
#
myFile.write("Third Line of file.\n")
myFile.seek(0,0)
text = myFile.read()
print(text)
#
myFile.write("Forth Line of file.\n")
myFile.seek(0,0)
text = myFile.read()
print(text)
#
myFile.close()
```
