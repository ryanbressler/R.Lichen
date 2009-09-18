googleDataTable = function(matrixWithColNames)
{
	ncols=dim(matrixWithColNames)[2]
	nrows=dim(matrixWithColNames)[1]
	
	
	
	dataList = list(cols=list(),rows=list())
	
	for (colcount in 1:ncols)
	{
		dataList$cols[[length(dataList$cols)+1]]=list(id=colcount-1, label=colnames(matrixWithColNames)[colcount], type="string")
	}
	
	for (rowcount in 1:nrows)
	{
		colvals=list()
		for (colcount in 1:ncols)
		{
			colvals[[length(colvals)+1]]=list(v=matrixWithColNames[[rowcount,colcount]])
		}
		
		dataList$rows[[length(dataList$rows)+1]]=list(c=colvals)
		
		
	}

	return(dataList)
}