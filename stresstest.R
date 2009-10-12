setwd("~/Code/R.Lichen")
require(R.Lichen)






clusterSizes=c(100)
numinteractions=600
nodeList=1:sum(clusterSizes)

#create an adjacensy list of the form:
#     [,1] [,2] [,3]
#[1,] "edge1"   "interactor1"    "interactor2"
#[2,] "edge2"   "interactor3"    "interactor4"
#[3,] "edge3"   "interactor1"    "interactor3"
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

# create a vector of cluster positions of the form
# list(list(x=CLUSTER1X,y=CLUSTER1Y),
# list(x=CLUSTER2X,y=CLUSTER2Y),
#  ...)



height=700 
width=1000
clusterPosition = list(list(x=runif(1)*width,y=runif(1)*height))
for(ii in 2:length(collabels))
{
	clusterPosition[[ii]] = list(x=runif(1)*width,y=runif(1)*height)
}


adjList=cbind(1:nrow(adjList),adjList)

bionetwork(adjList,list(layout="radialTree", height=height, width=width,padding=80))
