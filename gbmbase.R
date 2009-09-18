setwd("~/Documents/code/R.Lichen")

require(graph)
load("gbmnetwork")

require(R.Lichen)

shapes = Object()
shapes$protein = "CIRCLE"
shapes$famly = "SQUARE"
shapes$complex = "TRIANGLE_UP"
shapes$lipid = "DIAMOND"

arrowtype = Object()
arrowtype$inhibits = "LINES"
arrowtype$leads_to = "TRIANGLE"
arrowtype$activates = "TRIANGLE"
arrowtype$contains = "NONE"
arrowtype$includes = "NONE"

edgecolor = Object()
edgecolor$inhibits = "0xffff0000"
edgecolor$leads_to = "0xff0000ff"
edgecolor$activates = "0xff00ff00"
edgecolor$contains = "0xff000000"
edgecolor$includes = "0xff000000"


nodelist = nodes(n)
layoutdata = cbind(nodelist,"")
rownames(layoutdata)=nodelist
colnames(layoutdata)=c("nodeId","shape")
for(node in nodelist)
{
	shape=shapes[[(nodeData(n,node,"Type"))[[node]]]]
	if(!is.null(shape))
		layoutdata[node,"shape"]=shape
	
	
}







adjList = matrix(unlist(strsplit(edgeNames(n),"~")),ncol=2,byrow=TRUE)
adjList = cbind(1:length(edgeNames(n)),adjList)
adjList = cbind(adjList,TRUE)
adjList = cbind(adjList,"")
adjList = cbind(adjList,"")
colnames(adjList) = c("edge_id","interactor1","interactor2","directed","color","type")
interactiontype = ""
for(i in 1:length(edgeNames(n)))
{
	interactiontype=as.character(unlist(edgeData(n,adjList[i,2],adjList[i,3],"interaction")))
	adjList[i,5:6] = c(edgecolor[[interactiontype]],arrowtype[[interactiontype]])
}

height=700 
width=1000

bionetwork(adjList,list( height=height, width=width,padding=80,layout_data=googleDataTable(layoutdata)))