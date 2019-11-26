setwd("/home/frankaylward/thaum/phylogeny/OGs/stochastic_mapping")

source("micropan_source.R")
library(ape)
library(phytools)

tree <- read.tree("parsed_nwk_tree.nwk")
umtree <- chronos(tree)
plot(umtree)

ogs <- read.table(file="og_sample.txt", sep="\t", header=T, check.names=F)
panmat <- as.panmat(ogs)
panmat[panmat>1] <- 1

to_remove <- colSums(panmat) == dim(panmat)[1]
panmat2 <- panmat[,!to_remove]

full_anc <- data.frame(matrix(ncol=dim(panmat2)[2], nrow=74, "NA"))
for(i in 1:dim(panmat2)[2]) {
  mtrees<-make.simmap(umtree, round(panmat2[,i]), model="ER", nsim=100)
  pd<-summary(mtrees,plot=FALSE)
  #plot(pd,fsize=0.6,ftype="i")
  presence <- pd$ace[,"1"]
  full_anc[,i] <- presence
}
row.names(full_anc) <- umtree$node.label  #c(76:149)
colnames(full_anc) <- colnames(panmat2)
