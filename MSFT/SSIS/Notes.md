# Tips

### Hide an object on the Header / Footer
Add the following code under the Visibility > Hidden > Expression
```
=iif(Globals!PageNumber=Globals!TotalPages,false,true)
```
