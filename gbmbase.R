setwd("~/Documents/code/R.Lichen")

require(graph)
load("gbmnetwork")


require(R.Lichen)



shapes = Object()
shapes$protein = "CIRCLE"
shapes$famly = "SQUARE"
shapes$complex = "TRIANGLE_UP"
shapes$lipid = "DIAMOND"

nodelist = nodes(n)
layoutdata = cbind(nodelist,"")
rownames(layoutdata)=nodelist
colnames(layoutdata)=c("nodeId","shape")
for(node in nodelist)
{
	shape=shapes[[(nodeData(n,node,"Type"))[[node]]]]
	print(shape)
	if(!is.null(shape))
		layoutdata[node,"shape"]=shape
	
}







adjList = matrix(unlist(strsplit(edgeNames(n),"~")),ncol=2,byrow=TRUE)
adjList = cbind(adjList,TRUE)
colnames(adjList) = c("interactor1","interactor2","directed")

height=700 
width=1000

bionetwork(adjList,list( center="RTK", height=height, width=width,padding=80,layout_data=googleDataTable(layoutdata)))