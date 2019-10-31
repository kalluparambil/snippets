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

```

