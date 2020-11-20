################################################################################################################
#                                                                                                               
# R script to illustrate an example of DISPERSE database in practice: calculating
# functional diversity metrics and mean-traits based on dispersal traits
#                                                                                                               
# Sarremejane, R., Cid, N., Stubbington, R. et al. 
# DISPERSE, a trait database to assess the dispersal potential of European aquatic 
# macroinvertebrates. Sci Data 7, 386 (2020). 
# https://doi.org/10.1038/s41597-020-00732-7
#
# Taxonomic matrix: Jeliazkov et al. (2020) Scientific Data volume 7, Article number: 6
# R Functions to estimate functional diversity: Múrria et al. (2020) Global Ecology and Biogeography 29 (10), 1729-1742 
#                                                                                                               
# Code written by Cayetano Gutiérrez-Cánovas                                              
# emails for queries: romain.sarremejane@gmail.com, ncid@ub.edu, cayeguti@um.es                                                                             
#                                                                                                               
################################################################################################################

# Setting working directory
setwd("your_folder")

# Loading packages
library(ade4)
library(vegan)
library(plyr)
library(FD)
library(MuMIn)
library(adegraphics)

# Additional functions
source("0_FD_functions.R")
source("0_quality_funct_space_fromdist.R")

traits<-read.csv("R_Disperse.csv",row.names="Genus",header=TRUE,sep=",")
taxa<-read.table("Bonada2007W_AJ.txt",row.names="Sites",header=TRUE,sep="\t")

# Arranging matrix
tax_info<-traits[,c(1:3)] # saving taxonomic info
traits<-traits[,-c(1:3)] # selecting just trait columns

# Trait subset for taxa
trait_sub<-traits[intersect(colnames(taxa),rownames(traits)),]

# Checking if all taxa considered in "taxa" matrix are present in the trait matrix
# FALSE means we have no problems. Otherwise we need to check taxon names
any(rownames(trait_sub)==colnames(taxa))==F 

# Checking matrix dimensions
dim(trait_sub)
dim(taxa)
dim(traits)

#### list the number of categories per trait 
cat<-c(7,2,3,4,4,8,5,4,3)

#### list trait names
names(cat)<-c("Max size","life cycle duration","Reproduction cycles","Dispersal","life span","wing length", "wing type", "fecundity", "drift")
cat

#Transform the fuzzy coded trait data into % affinity

trait.fuzz<-prep.fuzzy.var (traits, cat)
ktab1 <- ktab.list.df(list(trait.fuzz))

# calculate gower ditance
tr.dist <- dist.ktab(ktab1, type = "F")

# Estimating the optimum number of dimensions
qual_fs <- quality_funct_space_fromdist(tr.dist, nbdim=15) 
qual_fs$meanSD # results suggest 9D

# Disperse space (PCoA)
tr.pco <- dudi.pco(tr.dist, scan = F, nf = 10)

# Explained variance by each axis
round(tr.pco$eig[1:9]/sum(tr.pco$eig),2)

# Cumulative fariance explained by all disperse space axes (9 axes) 9D, 72.3%
cumsum(tr.pco$eig)[9]/sum(tr.pco$eig) 

# Spearman rank correlations between original trait categories 
# and functional space axes
cor.res<-round(cor(traits,tr.pco$li[,1:9], method="spearman", use="pairwise.complete.obs"),2)
cor.res
write.table(cor.res, "pco_cor_res.txt", sep="\t")

# Calculating Functional Diversity components based on dispersal traits

# taxonomic richness
specnumber(taxa) -> tax.ric
summary(tax.ric) # we should adjust number of dimensions in FRic to avoid many NAs

fric_3d(taxa,tr.pco$li,m=4,prec="QJ") -> FRic # Functional richness
fdisp_k_sub(tr.dist, taxa,tax_sub=colnames(taxa), m=9)$FDis -> FDis # Functional dispersion
feve_k(tr.pco$li,taxa,m=9) -> FEve # Functional Evenness

# Mean dispersal traits for each community

# Abundance-weighted
functcomp(trait_sub, as.matrix(taxa)) -> mean.traits.ab

# Unweighted
functcomp(trait_sub, as.matrix(decostand(taxa,"pa"))) -> mean.traits.pa
