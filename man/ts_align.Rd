% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ts_window.R
\name{ts_align}
\alias{ts_align}
\title{Aligning Time Series}
\usage{
ts_align(x, with)
}
\arguments{
\item{x}{a ts boxable time series object}

\item{with}{a ts boxable time series object}
}
\description{
Aligning Time Series
}
\examples{
ts_align(mdeaths, fdeaths)
#### does not work yet ts_align(AirPassengers, fdeaths), need to implement extend = TRUE in ts_window
}
