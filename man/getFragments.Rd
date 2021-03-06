% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/uvpd.R
\name{getFragments}
\alias{getFragments}
\title{get all fragments of a SMILES code}
\usage{
getFragments(smiles = "CC(C)(C)C(O)C(OC1=CC=C(Cl)C=C1)N1C=NC=N1", ...)
}
\arguments{
\item{smiles}{}
}
\value{
a \code{data.frame} containing the SMILES and MH1P charged fragments.
}
\description{
get all fragments of a SMILES code
}
\examples{
df <- getFragments(treeDepth = 1)
plot(table(df$MH1P))
}
\references{
\itemize{
\item \url{https://cran.r-project.org/package=rcdk}
\item \url{https://github.com/ipb-halle/MetFragR}
}
}
\seealso{
\code{exec/make-data.R}
}
\author{
AB,CP 2019
}
