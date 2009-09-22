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
arrowtype$inhibits = "TRIANGLE"
arrowtype$leads_to = "TRIANGLE"
arrowtype$activates = "TRIANGLE"
arrowtype$contains = "TRIANGLE"
arrowtype$includes = "TRIANGLE"

edgecolor = Object()
edgecolor$inhibits = "0x66ff0000"
edgecolor$leads_to = "0x660000ff"
edgecolor$activates = "0x6600ff00"
edgecolor$contains = "0x66000000"
edgecolor$includes = "0x66000000"

leg=list(list(color="0x6600ff00", shape="TRIANGLE_RIGHT", size =0.5, label= "Activates"),
         list(color="0x66ff0000", shape="TRIANGLE_RIGHT", size =0.5, label= "Inhibits"),
		 list(color="0x660000ff", shape="TRIANGLE_RIGHT", size =0.5, label= "Leads to"),	 
		 list(color="0x66000000", shape="TRIANGLE_RIGHT", size =0.5, label= "Contains"),
		 list(color="0xff0055cc", shape="CIRCLE", size =0.75, label= "Protein"),
		 list(color="0xff0055cc", shape="SQUARE", size =0.75, label= "Protein Family"),
		 list(color="0xff0055cc", shape="TRIANGLE_UP", size =0.75, label= "Protein Complex"),
		 list(color="0xff0055cc", shape="DIAMOND", size =0.75, label= "Small Molecule")
			)


nodelist = nodes(n)
layoutdata = cbind(nodelist,"")
layoutdata = cbind(layoutdata,".8")


rownames(layoutdata)=nodelist
colnames(layoutdata)=c("nodeId","shape","size")
entrez=nodeData(n,nodes(n),"EntrezGeneID")

for(node in nodelist)
{
	shape=shapes[[(nodeData(n,node,"Type"))[[node]]]]
	if(!is.null(shape))
		layoutdata[node,"shape"]=shape
	if(nodeData(n,node,"Type")[[1]]=="process")
		layoutdata[node,"size"]=.01
	if(nodeData(n,node,"Type")[[1]]=="family"||nodeData(n,node,"Type")[[1]]=="complex")
	{
		linklist="start"
		for(target in edges(n)[[node]])
		{
			if(edgeData(n,node,target,"edgeType")=="contains")
			linklist=paste(linklist,nodeData(n,target,"EntrezGeneID"),sep=",")
		}
		linklist = sub("start,","",linklist)
		linklist = paste("/page/DossierView/display/gene_id/",linklist,sep="")
		entrez[[node]]=linklist
	}
	if(nodeData(n,node,"Type")[[1]]=="protein")
	{
		if(is.na(nodeData(n,target,"EntrezGeneID")))
		{
			entrez[[node]]=paste("/page/Search/display/?search=",node,sep="")
		}
		else
		{
			entrez[[node]]=paste("/page/Overview/display/gene_id/",nodeData(n,node,"EntrezGeneID"),sep="")
		}
	}
	if(nodeData(n,node,"Type")[[1]]=="lipid")
	{
		entrez[[node]]=paste("/page/Search/display/?search=",node,sep="")
	}
	
	
	
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
layoutdata[,1] = gsub("_"," ",layoutdata[,1])
#layoutdata = gsub("TRIANGLE UP","TRIANGLE_UP",layoutdata)
jsEnt=toJSON(entrez)
jsEnt=gsub("NA_character_","\"\"",jsEnt)
jsEnt=gsub("TRIANGLE UP","TRIANGLE_UP",jsEnt)

height=800
width=840


bionetwork(adjList,list(center="SPRY2",radial_labels=TRUE,node_tooltips=TRUE,legend=TRUE,legend_values=leg, layout_radialTree_startRadiusFraction=".05", layout="radialTree", height=height, width=width,padding=0,layout_data=googleDataTable(layoutdata)))