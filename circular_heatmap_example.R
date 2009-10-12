setwd("~/Code/R.Lichen")
require(R.Lichen)






numinteractions=8
nodecount = 8
nodeList=1:nodecount

#create an adjacensy list of the form:
#     [,1] [,2]
#[1,]    "interactor1"    "interactor2"
#[2,]    "interactor3"    "interactor4"
#[3,]    "interactor1"    "interactor3"
#			...
adjList=matrix(sample(nodeList,2*numinteractions,replace=TRUE),numinteractions)



height=400 
width=600



adjList=cbind(1:nrow(adjList),adjList)
colnames(adjList)=c("edge_id","interactor1","interactor2")




timeseriesdata = cbind(nodeList,round(runif(nodecount,0,1),2))
timeseriesdata = cbind(timeseriesdata,round(runif(nodecount,0,1),2))
timeseriesdata = cbind(timeseriesdata,round(runif(nodecount,0,1),2))
timeseriesdata = cbind(timeseriesdata,round(runif(nodecount,0,1),2))
timeseriesdata = cbind(timeseriesdata,round(runif(nodecount,0,1),2))
timeseriesdata = cbind(timeseriesdata,round(runif(nodecount,0,1),2))


rownames(timeseriesdata)=nodeList
colnames(timeseriesdata)=c("nodeId","t_0h","t_1h","t_2h","t_3h","t_4h","t_5h")

bionetwork(adjList,list(layout="ForceDirected", node_renderer="CircularHeatmap",CircularHeatmap_maxval=1, CircularHeatmap_minval=0, continuousUpdates=TRUE, height=height, width=width,padding=80,node_data=googleDataTable(timeseriesdata)))
