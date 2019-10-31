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

## Checking data
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

```

