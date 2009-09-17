

bionetwork=function(adjlist,optionshash=list())
{
	#try(stopRpadServer(), silent = TRUE)
	try(HttpDaemon$stop(),silent = TRUE)
	require(R.rsp)
	require(rjson)
	#require(Rpad)
	

	rootPath <- system.file("rsp", package="R.Lichen")
	HttpDaemon$optionsJSON = toJSON(optionshash)
	HttpDaemon$adjlist=adjlist
	
	
	#dir.create("bionetworkoutput")
	#rspToHtml(file="bionetwork.rsp",path=rootPath,outFile="bionetworkoutput/bionetwork.html")
	#file.copy(paste(rootPath,"bionetwork.js",sep="/"),"bionetworkoutput/bionetwork.js")
	#file.copy(paste(rootPath,"bionetwork.swf",sep="/"),"bionetworkoutput/bionetwork.swf")

	#necesairy to use Rpad Httpd becuase the one in R.rsp addes wierd headers
	#Rpad(file = "bionetworkoutput/bionetwork.html", defaultfile = "", port = 8079)
	
    HttpDaemon$start(rootPath=rootPath, port=8074, default="bionetwork.rsp")
    
    browseURL("http://127.0.0.1:8074/")

	
}