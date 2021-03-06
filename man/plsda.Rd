\name{plsda}
\encoding{UTF-8}
\alias{plsda}

\title{Partial Least Squares Discriminant Analysis (PLS-DA).}

\description{Function to perform standard Partial Least Squares regression
to classify samples.
}

\usage{
plsda(X,
Y,
ncomp = 2,
scale = TRUE,
mode = c("regression", "canonical", "invariant", "classic"),
tol = 1e-06,
max.iter = 100,
near.zero.var = FALSE,
logratio="none",  # one of "none", "CLR"
multilevel=NULL,
all.outputs = TRUE)
}

\arguments{
  \item{X}{numeric matrix of predictors. \code{NA}s are allowed.}
  \item{Y}{a factor or a class vector for the discrete outcome.}
  \item{ncomp}{the number of components to include in the model. Default to 2.}
\item{scale}{boleean. If scale = TRUE, each block is standardized
to zero means and unit variances (default: TRUE)}
\item{mode}{character string. What type of algorithm to use, (partially) matching
one of \code{"regression"}, \code{"canonical"}, \code{"invariant"} or \code{"classic"}.
See Details.}
\item{tol}{Convergence stopping value.}
\item{max.iter}{integer, the maximum number of iterations.}
\item{near.zero.var}{boolean, see the internal \code{\link{nearZeroVar}} function (should be set to TRUE in particular for data with many zero values). Setting this argument to FALSE (when appropriate) will speed up the computations. Default value is FALSE}
\item{logratio}{one of ('none','CLR') specifies the log ratio transformation to deal with compositional values that may arise from specific normalisation in sequencing dadta. Default to 'none'}
\item{multilevel}{sample information for multilevel decomposition for repeated measurements. A numeric matrix or data frame indicating the repeated measures on each individual, i.e. the individuals ID. See examples in \code{?splsda}.}
\item{all.outputs}{boolean. Computation can be faster when some specific (and non-essential) outputs are not calculated. Default = \code{TRUE}.}

}

\details{
\code{plsda} function fit PLS models with \eqn{1,...,}\code{ncomp} components
to the factor or class vector \code{Y}. The appropriate indicator 
matrix is created.

logratio transform and multilevel analysis are performed sequentially as internal pre-processing step, through \code{\link{logratio.transfo}} and \code{\link{withinVariation}} respectively.

Logratio can only be applied if the data do not contain any 0 value (for count data, we thus advise the normalise raw data with a 1 offset).

More details about the PLS modes in \code{?pls}.

}

\value{
\code{plsda} returns an object of class \code{"plsda"}, a list 
that contains the following components:

  \item{X}{the centered and standardized original predictor matrix.}
  \item{Y}{the centered and standardized indicator response vector or matrix.}
  \item{ind.mat}{the indicator matrix.}
  \item{ncomp}{the number of components included in the model.}
  \item{variates}{list containing the \code{X} and \code{Y} variates.}
  \item{loadings}{list containing the estimated loadings for the variates.}
  \item{names}{list containing the names to be used for individuals and variables.}
  \item{nzv}{list containing the zero- or near-zero predictors information.}
   \item{tol}{the tolerance used in the iterative algorithm, used for subsequent S3 methods}
  \item{max.iter}{the maximum number of iterations, used for subsequent S3 methods}
\item{iter}{Number of iterations of the algorthm for each component}
  \item{explained_variance}{amount of variance explained per component (note that contrary to PCA, this amount may not decrease as the aim of the method is not to maximise the variance, but the covariance between X and the dummy matrix Y).}
\item{mat.c}{matrix of coefficients from the regression of X / residual matrices X on the X-variates, to be used internally by \code{predict}.}
\item{defl.matrix}{residual matrices X for each dimension.}

}

\references{
On PLSDA:
Barker M and Rayens W (2003). Partial least squares for discrimination. \emph{Journal of Chemometrics} \bold{17}(3), 166-173.
Perez-Enciso, M. and Tenenhaus, M. (2003). Prediction of clinical outcome with microarray data: 
a partial least squares discriminant analysis (PLS-DA) approach. \emph{Human Genetics} 
\bold{112}, 581-592.
Nguyen, D. V. and Rocke, D. M. (2002). Tumor classification by partial
least squares using microarray gene expression data. \emph{Bioinformatics}
\bold{18}, 39-50.
On log ratio transformation:
Filzmoser, P., Hron, K., Reimann, C.: Principal component analysis for compositional data with outliers. Environmetrics 20(6), 621-632 (2009)
Lê Cao K.-A., Costello ME,  Lakis VA, Bartolo, F,Chua XY, Brazeilles R, Rondeau P. MixMC: Multivariate insights into Microbial Communities. PLoS ONE, 11(8): e0160169 (2016).
On multilevel decomposition:
Westerhuis, J.A., van Velzen, E.J., Hoefsloot, H.C., Smilde, A.K.: Multivariate paired data analysis: multilevel plsda versus oplsda. Metabolomics 6(1), 119-128 (2010)
Liquet, B., Lê Cao K.-A., Hocini, H., Thiebaut, R.: A novel approach for biomarker selection and the integration of repeated measures experiments from two assays. BMC bioinformatics 13(1), 325 (2012)
}

\author{Ignacio González, Kim-Anh Lê Cao.}

\seealso{\code{\link{splsda}}, \code{\link{summary}}, 
\code{\link{plotIndiv}}, \code{\link{plotVar}}, 
\code{\link{predict}}, \code{\link{perf}}, \code{\link{mint.block.plsda}}, \code{\link{block.plsda}} and http://mixOmics.org for more details.}

\examples{
## First example
data(breast.tumors)
X <- breast.tumors$gene.exp
Y <- breast.tumors$sample$treatment

plsda.breast <- plsda(X, Y, ncomp = 2)
plotIndiv(plsda.breast, ind.names = TRUE, ellipse = TRUE, legend = TRUE)

\dontrun{
## Second example
data(liver.toxicity)
X <- liver.toxicity$gene
Y <- liver.toxicity$treatment[, 4]

plsda.liver <- plsda(X, Y, ncomp = 2)
plotIndiv(plsda.liver, ind.names = Y, ellipse = TRUE, legend =TRUE)

}
}

\keyword{regression}
\keyword{multivariate}
