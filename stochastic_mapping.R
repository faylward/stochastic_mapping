setwd("/home/frankaylward/thaum/phylogeny/OGs/stochastic_mapping")

source("micropan_source.R")
library(ape)
library(phytools)
#source("make.simmap.R")

tree <- read.tree("parsed_nwk_tree.nwk")
umtree <- chronos(tree)
plot(umtree)

ogs <- read.table(file="thaumarch.proteinortho", sep="\t", header=T, check.names=F)
panmat <- as.panmat(ogs)
#panmat[panmat>1] <- 1

to_remove <- colSums(panmat) == dim(panmat)[1]
panmat2 <- panmat[,!to_remove]
panmat2 <- panmat2[,1:500]

i <- 120
mtrees<-make.simmap(umtree, round(panmat2[,i]), model="ER", nsim=10)
pd <- summary(mtrees, plot=FALSE)

full_anc <- data.frame(matrix(ncol=dim(panmat2)[2], nrow=74, "NA"))
for(i in 1:dim(panmat2)[2]) {
  print(i)
  mtrees<-fastAnc(umtree, round(panmat2[,i]))
  #mtrees<-make.simmap(umtree, round(panmat2[,i]), model="ER", nsim=10)
  #pd<-summary(mtrees,plot=FALSE)
  #plot(pd,fsize=0.6,ftype="i")
  #if(length(colnames(pd$ace)) > 2) {
  # presence <- as.numeric(pd$ace)
  #}
  #else {
  #  presence <- pd$ace[,"1"]  
  #}
  #full_anc[,i] <- presence
  full_anc[,i] <- as.numeric(mtrees)
}
row.names(full_anc) <- umtree$node.label  #c(76:149)
colnames(full_anc) <- colnames(panmat2)
write.table(data.frame(round(rowSums(full_anc))), "data", quote=F, sep="\t")


r <- round(full_anc)
sum(r["Node_7",] - r["Node_8",])
