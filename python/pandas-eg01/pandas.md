# Learning some pandas
Ref: []()

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

```
