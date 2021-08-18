SSRS related tips

--If parameter is null the predicate is true, else check for condition
AND (@Region_Id is null or [Region_Id] = @Region_Id)

