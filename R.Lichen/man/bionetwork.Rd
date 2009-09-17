\name{bionetwork}
\Rdversion{1.1}
\alias{bionetwork}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
bionetwork
}
\description{
Displays an html page containing a Lichen network vis.
}
\usage{
bionetwork(mydata, myoptions)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mydata}{
TODO
}
  \item{myoptions}{
TODO
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
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
bionetwork(matrix(ceiling(runif(200,0,30)),100),list(layout="radialTree", edge_router="bundled", height=800, width=1000))
## The function is currently defined as
function(mydata,myoptions)
{
	
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{graph}

