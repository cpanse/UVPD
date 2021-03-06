% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/uvpd.R
\name{analyze}
\alias{analyze}
\alias{summary.uvpd}
\alias{uvpd}
\alias{analyse}
\title{Perfom analyses run}
\usage{
analyze(rawfile, fragments, mZoffset = 1.007, itol = 0.001,
  eps.mZ = 0.05, eps.rt = 0.5)
}
\arguments{
\item{rawfile}{filepath to a Thermo Fisher rawfile}

\item{mZoffset}{}

\item{itol}{fragment ion tolerance; default is 1mDa.}

\item{eps.mZ}{pre-cursor mass tolerance in Da; default is set to 50mDa.}

\item{eps.rt}{retention time window; default is 0.5 minutes.}
}
\value{
returns a \code{data.frame} object
}
\description{
Perfom analyses run
}
\details{
INPUT:
\itemize{
\item in-silico fragment ion spectra of a given set of SMILES 
\item ThermoFisher raw file
}

STEP1: 
 \itemize{
 \item dermines APEX(MS1) of each molecule mass return rt for each given mass; 
}

STEP2: 
\itemize{
\item extract MS2 at a given rt and precursor window
}

STEP3: 
\itemize{
\item compute match between in-silico and MS2 fragment specs 
}

OUTPUT: 
\itemize{
\item a \code{data.frame} object having the column names
\code{c('mZ', 'type', 'SMILES', 'formula', 'intensity', 'rawfile',
  'scanTypeFilter', 'SMILES0', 'formula0', 'mass', 'n'}.
}

STATISTICS:
  see examples
}
\examples{
library(uvpd)

# load in-silico fragments
load(file.path(system.file(package = 'uvpd'), "/extdata/fragments.RData"))

# load Thermo Fisher rawfiles
rawfiles <- scan(file.path(system.file(package = 'uvpd'),
  "/extdata/rawfiles.txt"), what = character())
  
# filter 
rawfiles <- rawfiles[grepl("Castell|(KWR|stds)|DBPs", rawfiles)]
rawfiles <- rawfiles[!grepl("AcX|blank|Blank", rawfiles)]

# DBPs neg
# Castell pos
# KWR std. pos and neg

\dontrun{
S1 <- analyze(rawfiles[20], fragments.treeDepth1)

S2 <- lapply(rawfiles[c(15:20)], analyze, fragments=fragments.treeDepth1)
}

\dontrun{


rawfile24 <- file.path(Sys.getenv('HOME'), "Downloads/CastellonStds_pos_HCD_20_35_60.raw")
rawfile29 <- file.path(Sys.getenv('HOME'), "Downloads/CastellonStds_pos_UVPD_50_300.raw")

rawfile24 <- rawfiles[24]
rawfile29 <- rawfiles[29]

S24 <- analyze(rawfile24, fragments = fragments.treeDepth1)
S29 <- analyze(rawfile29, fragments = fragments.treeDepth1)

S24.log <- aggregate(intensity ~ ., data=S24,  FUN=function(x){log(x, 10)})
S24.log$intensity.norm <- (S24.log$intensity - mean(S24.log$intensity ))/ sd(S24.log$intensity )

S29.log <- aggregate(intensity ~ ., data=S29,  FUN=function(x){log(x, 10)})
S29.log$intensity.norm <- (S29.log$intensity - mean(S29.log$intensity ))/ sd(S29.log$intensity )

S <- rbind(S24, S29)
S.log <- rbind(S24.log, S29.log)

boxplot(intensity.norm ~ rawfile, data=S.log )
# STATISTICS:

# merge profile data
SS.log <- aggregate(intensity ~ mZ + type + SMILES + formula + scan + nfragments + nMS2 + sumMS2intensities + rawfile + scanTypeFilter + SMILES0 + formula0 + mass + nScans, data = S.log, FUN=sum)

# sum intensities
SSS.log<-aggregate(intensity ~ rawfile + formula0 + scanTypeFilter + scan + nfragments + nMS2 + sumMS2intensities, data=SS.log, FUN=sum)

library(lattice)

histogram(~intensity/sumMS2intensities | scanTypeFilter, data=SSS.log, type='count')
histogram(~intensity/nfragments | scanTypeFilter, data=SSS, type='count')
}
}
\author{
Christian Panse <cp@fgcz.ethz.ch>, 2019
}
