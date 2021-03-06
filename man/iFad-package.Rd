\name{iFad-package}
\alias{iFad-package}
\alias{iFad}
\docType{package}
\title{An integrative factor analysis model for drug-pathway association inference}
\description{This package implements a bayesian sparse factor model for the 
joint analysis of paired datasets, one is the gene expression dataset and 
the other is the drug sensitivity profiles, measured across the same panel 
of samples, e.g., cell lines. Prior knowledge about gene-pathway associations 
can be easily incorporated in the model to aid the inference 
of drug-pathway associations.}
\details{
\tabular{ll}{
Package: \tab iFad\cr
Type: \tab Package\cr
Version: \tab 3.0\cr
Date: \tab 2014-03-25\cr
License: \tab GPL (version 2 or later) \cr
LazyLoad: \tab yes\cr
}

install.packages("iFad")
}

\author{
Haisu Ma
Maintainer: Haisu Ma <haisu.ma.pku.2008@gmail.com>
}
\examples{

library(Rlab)
library(MASS)
library(coda)
library(ROCR)

#Simulate datasets

data_simulation(K=10,G1=30,G2=30,J=15,eta0=c(0.2,0.2),
eta1=c(0.2,0.2),density=c(0.1,0.1),alpha_tau=1,
beta_tau=0.01,SNR=0,file_name="demo_data.RData")


#Gibbs sampling

data(matrixY1)
data(matrixY2)
data(matrixL1)
data(matrixL2)


gibbs_sampling(matrixY1, matrixY2, matrixL1, matrixL2, 
eta0=c(0.2,0.2), eta1=c(0.2,0.2), alpha_tau = 1, 
beta_tau = 0.01, tau_sig = 1, max_iter = 5, 
thin = 1, file_name="Demo_Gibbs_result.RData")


#Traceplot
data(tau_g_chain)
mcmc_trace_plot(tau_g_chain,plot_file_name="Demo_traceplot.pdf", 
index=1:10)

#ROC plot
data(matrixZ1)
data(matrixZ2)
data(matrixZ_chain)
ROC_plot(matrixZ1, matrixZ2, matrixZ_chain, plot_name="ROC_plot.pdf", 
result_file_name="ROC_result.RData", burn=1)

#RMSE plot
data(Y1_mean)
data(Y2_mean)
data(matrixY1)
data(matrixY2)
data(matrixZ_chain)
data(matrixW1)
data(matrixW2)
data(matrixW_chain)
data(matrixX)
data(matrixX_chain)
Ymean_compare(Y1_mean,Y2_mean,matrixY1, matrixY2, matrixZ_chain, 
matrixW1, matrixW2, matrixW_chain, matrixX, matrixX_chain, 
result_file_name="RMSE_demo.RData", plot_name="RMSE_plot.pdf")

}
