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

entrezcv=c()
otheridscv=c()

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
			if(edgeData(n,node,target,"edgeType")=="contains" && ! is.na(nodeData(n,target,"EntrezGeneID")))
			{
			 linklist=paste(linklist,nodeData(n,target,"EntrezGeneID"),sep=",")
			 entrezcv=c(entrezcv,nodeData(n,target,"EntrezGeneID"))
			}
		}
		linklist = sub("start,","",linklist)
		if(linklist!="start")
		{
			linklist = paste("/page/DossierView/display/gene_id/",linklist,sep="")
			entrez[[node]]=linklist
		}
	}
	if(nodeData(n,node,"Type")[[1]]=="protein")
	{
		if(is.na(nodeData(n,target,"EntrezGeneID")))
		{
			entrez[[node]]=paste("/page/Search/display/?search=",node,sep="")
			otheridscv=c(otheridscv,node)
		}
		else
		{
			entrez[[node]]=paste("/page/Overview/display/gene_id/",nodeData(n,node,"EntrezGeneID"),sep="")
			entrezcv=c(entrezcv,nodeData(n,node,"EntrezGeneID"))
		}
	}
	if(nodeData(n,node,"Type")[[1]]=="lipid")
	{
		#entrez[[node]]=paste("/page/Search/display/?search=",node,sep="")
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

adjList = gsub("G1 S PROGRESSION","G1/S PROGRESSION",adjList)
layoutdata[,1] = gsub("G1 S PROGRESSION","G1/S PROGRESSION",layoutdata[,1])

adjList = gsub("G2 M ARREST","G2/M ARREST",adjList)
layoutdata[,1] = gsub("G2 M ARREST","G2/M ARREST",layoutdata[,1])

#hand curated links
entrez$`EGFR-family`= "/page/DossierView/display/gene_id/1956,2064,2065"
entrez$`CCND-CDK4-complex`="/page/DossierView/display/gene_id/595,894,1019"
entrez$PIK3R2= "/page/Overview/display/gene_id/5296"
entrez$AKT= "/page/DossierView/display/gene_id/207,208,10000"
entrez$AKT2= "/page/Overview/display/gene_id/208"
entrez$RAF= "/page/DossierView/display/gene_id/369,673,5894"
entrez$RAF1= "/page/Overview/display/gene_id/5894"
entrez$ATM= "/page/Overview/display/gene_id/472"
entrez$PIK3C2B= "/page/Overview/display/gene_id/5287"
entrez$`PI3K-class2`= "/page/DossierView/display/gene_id/5287,5286,5288"
entrez$RTK= "/page/DossierView/display/gene_id/3480,5156,5159,1956,2064,2065,2260,2263,4233"
entrez$GRB2= "/page/Overview/display/gene_id/2885"
entrez$MDM2= "/page/Overview/display/gene_id/4193"
entrez$PIK3R1= "/page/Overview/display/gene_id/5295"
entrez$PIK3CB= "/page/Overview/display/gene_id/5291"
entrez$EP300= "/page/Overview/display/gene_id/2033"
entrez$TP53= "/page/Overview/display/gene_id/7157"
entrez$FOXO= "/page/DossierView/display/gene_id/2308,2309,4303"
entrez$PKC= "/page/DossierView/display/gene_id/5590,5588,5583,5582,5580,5584,5579,5578"
entrez$INK4= "/page/DossierView/display/gene_id/1029,1031,1030"
entrez$CDKN2B= "/page/Overview/display/gene_id/1030"
entrez$FGFR= "/page/DossierView/display/gene_id/2260,2263"
entrez$`CCND-CDK6-complex`= "/page/DossierView/display/gene_id/595,894,1021"
entrez$CDKN1B= "/page/Overview/display/gene_id/1027"
entrez$CENTG1= "/page/Overview/display/gene_id/116986"
entrez$PIK3CD= "/page/Overview/display/gene_id/5293"
entrez$BRCA2= "/page/Overview/display/gene_id/675"
entrez$PDGFR= "/page/DossierView/display/gene_id/5156,5159"
entrez$RAS= "/page/DossierView/display/gene_id/4893,3845,3265"
entrez$FGFR1= "/page/Overview/display/gene_id/2260"
entrez$HRAS= "/page/Overview/display/gene_id/3265"
entrez$PIK3CG= "/page/Overview/display/gene_id/5294"
entrez$SRC= "/page/Overview/display/gene_id/6714"
entrez$PTEN= "/page/Overview/display/gene_id/5728"
entrez$PDPK1= "/page/Overview/display/gene_id/5170"
entrez$CDK2= "/page/Overview/display/gene_id/1017"
entrez$FOXO3= "/page/Overview/display/gene_id/2309"
entrez$E2F1= "/page/Overview/display/gene_id/1869"
entrez$NF1= "/page/Overview/display/gene_id/4763"
entrez$CDKN2C= "/page/Overview/display/gene_id/1031"
entrez$AKT3= "/page/Overview/display/gene_id/10000"
entrez$PIK3C2G= "/page/Overview/display/gene_id/5288"
entrez$PRKCQ= "/page/Overview/display/gene_id/5588"
entrez$PRKCZ= "/page/Overview/display/gene_id/5590"
entrez$KRAS= "/page/Overview/display/gene_id/3845"
entrez$PRKCG= "/page/Overview/display/gene_id/5582"
jsEnt=toJSON(entrez)
jsEnt=gsub("NA_character_","\"\"",jsEnt)
#jsEnt=gsub("TRIANGLE UP","TRIANGLE_UP",jsEnt)

height=800
width=840


bionetwork(adjList,list(center="SPRY2",radial_labels=TRUE,node_tooltips=TRUE,legend=TRUE,legend_values=leg, layout_radialTree_startRadiusFraction=".05", layout="radialTree", height=height, width=width,padding=0,layout_data=googleDataTable(layoutdata)))