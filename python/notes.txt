#Question: What is the difference between lists, tuples, dictionaries etc?

#Read on the placeholders in strings in Python
https://pyformat.info/

##Example
sentence = "%s is my name"
sentence%('Rama')

##Another way
'%s %s' % ('one', 'two')
'{} {}'.format('Three', 'Four')

#Lists
mylist = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
##Select
mylist
##Insert
mylist.append('NewDay')
##Update
mylist[7] = "January"
##Delete
del mylist[7]

##Length of List
len(mylist)

##Adding Lists
mylist2 = ["January","February","March"]
mylist + mylist2

##Multiplying Lists
mylist2 * 2

##Max and Min from List
numlist = [1,2,3,4,5]
max(numlist)
min(numlist)

#Dictionaries
students = {"Babu":10,"Coumar":11,"Dravid":12}
##Select
students
students["Babu"]
##Insert
students["NewStudent"] = 13
##Update
students["Babu"] = 9
##Delete
del(students["Coumar"])
##Other operations
len(students)

#Conditional Statements
if (age < 13):
    print("You are young.")
elif (age >= 13 and age < 18):
    print("You are a Teenager.")
else:
   print("You are an Adult.")

#Loops
list1 = ["Apples", "Oranges","Cherries"]
tup1 = (1,2,3)
for item in list1:
    print(item)
for item in tup1:
    print(item)

##Skipping in range
for i in range(1,11,2):
    print(i)

#While Loop
c = 0
while c < 5:
    print(c)
    c = c + 1
    
# While - Break, Continue and Pass
c = 0
while c < 5:
    c = c + 1
    if c == 3:
        break #Break out of the loop
    print(c)

c = 0
while c < 5:
    c = c + 1
    if c == 3:
        continue #Skip below statements
    print(c)

c = 0
while c < 5:
    c = c + 1
    if c == 3:
        pass #Just a null statement
    print(c)

 
