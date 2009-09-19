setwd("~/Documents/code/R.Lichen")

require(graph)
load("gbmnetwork")

require(R.Lichen)

shapes = Object()
shapes$protein = "CIRCLE"
shapes$family = "SQUARE"
shapes$complex = "TRIANGLE_UP"
shapes$lipid = "DIAMOND"

arrowtype = Object()
arrowtype$inhibits = "LINES"
arrowtype$leads_to = "TRIANGLE"
arrowtype$activates = "TRIANGLE"
arrowtype$contains = "NONE"
arrowtype$includes = "NONE"

edgecolor = Object()
edgecolor$inhibits = "0x66ff0000"
edgecolor$leads_to = "0x660000ff"
edgecolor$activates = "0x6600ff00"
edgecolor$contains = "0x66000000"
edgecolor$includes = "0x66000000"


nodelist = nodes(n)
layoutdata = cbind(nodelist,"")
layoutdata = cbind(layoutdata,".8")
rownames(layoutdata)=nodelist
colnames(layoutdata)=c("nodeId","shape","size")
for(node in nodelist)
{
	shape=shapes[[(nodeData(n,node,"Type"))[[node]]]]
	if(!is.null(shape))
		layoutdata[node,"shape"]=shape
	if(nodeData(n,node,"Type")[[1]]=="process")
		layoutdata[node,"size"]=.01
	
	
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
adjList = gsub("_"," ",adjList)
layoutdata = gsub("_"," ",layoutdata)

height=800
width=933

bionetwork(adjList,list(center="FOXO",radial_labels=TRUE, layout_radialTree_startRadiusFraction=".05", layout="radialTree", height=height, width=width,padding=0,layout_data=googleDataTable(layoutdata)))