# Learning some pandas
Ref: [YouTube link](https://www.youtube.com/watch?v=vmEHCJofslg&list=PLjxQEUdbCjs5--D5N99XjU1WzKcr0n2u2&index=9&t=830s)

## Opening csv, excel or tsv files
```python
import pandas as pd
df_csv = pd.read_csv('pokemon_data.csv')

#Read Excel file
df_excel = pd.read_excel('pokemon_data.xlsx')#Read TSV file

#Read TSV file
df_tsv = pd.read_csv('pokemon_data.txt', delimiter='\t')
```

## Reading data
```python
#Check everything
print(df)

#Check the top 5 rows
print(df.head(5))

#Check the bottom 5 rows
print(df.tail(5))

#Check column names
print(df.columns)

#Get Top 5 Names
print(df['Name'].head(5))

#Get Top 15 Names
print(df['Name'][0:15])

#Read multiple columns
print(df[['#', 'Name', 'Type 1', 'Type 2', 'HP']].head(5))

#Check the for specified Location Row or Range of Rows and Columns
print(df.iloc[0])
print(df.iloc[2:5])

#Check a specific Row and Column intersection Cell
print(df.iloc[0,2])

#Read each row by looping through it
for idx, r in df.iterrows():
    print(idx, r['Name'])

#Same could be accomplished with the code below
#advantage is that we can limit by column names and row filtered by index
print(df[['#', 'Name', 'Type 1', 'Type 2', 'HP']].iloc[1:5])

#Filter by a Column where clause
print(df.loc[df['Type 1'] == 'Grass'])

#Get some stats from the data set
df.describe()

#Sorting by Column Name
df.sort_values('Name')
#Descending
df.sort_values('Name', ascending=False)

#Sorting by multiple Column Name
df.sort_values(['Name', 'Type 1'])
#Ascending and Descending
df.sort_values(['Name', 'Type 1'], ascending=[1,0])
```

## Manipulating data
```python
#Add a calculated column - Alternate way 1
#df['Total'] = df['HP'] + df['Attack'] + df['Defense']+ df['Sp. Atk'] + df['Sp. Def']+ df['Speed']

#Remove a column
df = df.drop(columns=['Total'])
df.head(5)

#Add a calculated column - Alternate way 2
df['Total'] = df.iloc[:, 4:10].sum(axis=1)

#Rearranging the columns
#Get Names of the columns as a list
cols = list(df.columns.values)
#cols - convert cols[-1] to list
df = df[cols[0:4] + [cols[-1]] + cols[4:12]]
```

## Writing to file
```python
#Saving (with not index column)
df.to_csv('modified.csv', index=False)
df.to_excel('modified.xlsx', index=False)
df.to_csv('modified.txt', index=False, sep='\t')
```

## Filtering Data
```python
df.loc[df['Type 1'] == 'Grass']

#TIP: Parenthesis needed for multiple Condition check
df.loc[(df['Type 1'] == 'Grass') & (df['Type 2'] == 'Poison')]

#Column contains Mega
df.loc[df['Name'].str.contains('Mega')]

#Column does not contain Mega
df.loc[~df['Name'].str.contains('Mega')]
```

## Using RegEx in Filters
```python
import re
#Find Type 1 which is fire or grass, ignore case
df.loc[df['Type 1'].str.contains('fire|grass', regex=True, flags=re.I)]
#Names starting with pi
df.loc[df['Name'].str.contains('^pi[a-z]*', regex=True, flags=re.I)]
```

## Conditional changes
```python
#Change Type 1 from Fire to Flamer
df.loc[df['Type 1'] == 'Fire', 'Type 1'] = 'Flamer'

#Change multiple columns based on condition
df.loc[df['Total'] > 500, ['Generation','Legendary'] ]= [2,True]
```
## Aggregate Statistics
```python
#Applying Group by
df.groupby('Type 1').count().sort_values('Name', ascending=False)

#Getting count via Group by on a column
df.groupby('Type 1').count()['Name']
```

## Working with large amounts of data
```python
#Not covered properly in the video
```
