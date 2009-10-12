setwd("~/Code/R.Lichen")
require(R.Lichen)






clusterSizes=c(3,5,8,13)
numinteractions=16
nodecount = sum(clusterSizes)
nodeList=1:nodecount

#create an adjacensy list of the form:
#     [,1] [,2]
#[1,]    "interactor1"    "interactor2"
#[2,]    "interactor3"    "interactor4"
#[3,]    "interactor1"    "interactor3"
#			...
adjList=matrix(sample(nodeList,2*numinteractions,replace=TRUE),numinteractions)

#		create a cluster membership matrix with column names of the form"
#     NodeID 	cluster 1	cluster 2	cluster 3
#[1,]      1	1           0           0         
#[2,]      2    0           1           0          ...
#[3,]      3    0           0           1         
#			....

clusterMat=matrix(0,sum(clusterSizes),length(clusterSizes)+1)
clusterMat[,1]=nodeList
starti=1
colj=2
collabels=c("NodeID")
for(clustersize in clusterSizes)
{
	clusterMat[starti:(starti+clustersize-1),colj]=1
	collabels=c(collabels,paste("cluster ",(colj-1)," nodes ",starti,":",(starti+clustersize-1),sep=""))
	numinteractions=clustersize
	adjList=rbind(adjList,matrix(sample(starti:(starti+clustersize-1),2*numinteractions,replace=TRUE),numinteractions))
	colj=colj+1
	starti=starti+clustersize
}

colnames(clusterMat)=collabels

shapes = c("CIRCLE","SQUARE","TRIANGLE_UP","DIAMOND")
layoutdata = cbind(nodeList,sample(shapes,nodecount,replace=TRUE))
layoutdata = cbind(layoutdata,round(runif(nodecount,.5,2),2))


rownames(layoutdata)=nodeList
colnames(layoutdata)=c("nodeId","shape","size")

height=400 
width=600



adjList=cbind(1:nrow(adjList),adjList)
colnames(adjList)=c("edge_id","interactor1","interactor2")
bionetwork(adjList,list(layout="extendedForceDirected", continuousUpdates=TRUE, nodeClusters=googleDataTable(clusterMat), height=height, width=width,padding=80,layout_data=googleDataTable(layoutdata)))
