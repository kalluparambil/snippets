# My Python Learning Cheat Sheet
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
