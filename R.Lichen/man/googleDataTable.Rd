\name{googleDataTable}
\Rdversion{1.1}
\alias{googleDataTable}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
googleDataTable
}
\description{
Creates an R list with parallel structure to a google data table, suitable for JSON serialization.
}
\usage{
googleDataTable(matrixWithColNames)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{matrixWithColNames}{
A matrix with column names.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
A list object that will create a google data table with column 
names and data values taken from the input matrix. All values encoded as strings.
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Ryan Bressler
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(matrixWithColNames)
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
			colvals[[length(colvals)+1]]=list(v=matrixWithColNames[rowcount,colcount])
		}
		
		dataList$rows[[length(dataList$rows)+1]]=list(c=colvals)
		
		
	}

	return(dataList)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ graph }

