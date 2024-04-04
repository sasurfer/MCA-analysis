#Perform MCA analysis on data
library("FactoMineR")
library("factoextra")
library(ggplot2)
library(ggpubr)#for ggpar
library(corrplot)
library(FactoInvestigate)#for Investigate
df <- read.csv("./input.csv", row.names = 1)
head(df,4)

#apply mca
res.mca <- MCA(df, ncp=11,axes=c(1,2),graph = FALSE)
summary(res.mca)

#Extract and show the eigenvalues/variances retained by each dimension (scree plot)
eig.val <- get_eigenvalue(res.mca)
eig.val

fviz_screeplot(res.mca,ncp=11,addlabels=TRUE,barfill='lightgray',linecolor='red',ylim=c(0,40))

Dimensions <- 1:10
Eigenvalues <- eig.val[,1]
data <- data.frame(Dimensions,Eigenvalues)
ggplot(data,aes(x=Dimensions,y=Eigenvalues),xlab='Dimensions',ylab='Eigenvalue',lab) +
  geom_line(color="black") +
  geom_point(size=3,color='lightgray')+
  theme(axis.text.x = element_text(face="bold", color="#993333", 
                                     size=10))+
  theme(axis.text.y = element_text(face="bold", color="#993333", 
                                   size=10))+
  theme(axis.line.x=element_line(color="black"))+
  theme(axis.line.y=element_line(color="black"))+
  scale_x_continuous(breaks=seq(1,10))+
  theme_bw()

#biplot individuals and qualitative variables
a<-fviz_mca_biplot(res.mca,
                repel = TRUE,
                ggtheme = theme_minimal())
ggpar(a,main='')

a<-fviz_mca_biplot(res.mca,
                   repel = TRUE,axes=c(1,3),
                   ggtheme = theme_minimal())
ggpar(a,main='')
#Extract the results for individuals
#ind <- get_mca_ind(res.mca)
#ind
a<-fviz_mca_ind(res.mca, col.ind = "cos2",
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
               repel = TRUE)
ggpar(a,main='')
a<-fviz_mca_ind(res.mca, col.ind = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE,axes=c(1,3))
ggpar(a,main='')

# Plot of variables
a<-fviz_mca_var(res.mca, choice="mca.cor",repel = TRUE,axes=c(1,2))
ggpar(a,main='')
a<-fviz_mca_var(res.mca,  choice='mca.cor',repel = TRUE,axes=c(1,3))
ggpar(a,main='')
# Contribution to the first dimension
a<-fviz_contrib(res.mca, "var", axes = 1,fill='lightgray')
ggpar(a,main='Contribution of variables to dimension 1')
# Contribution to the second dimension
b<-fviz_contrib(res.mca, "var", axes = 2,fill='lightgray')
ggpar(b,main='Contribution of variables to dimension 2')
# Contribution to the third dimension
c<-fviz_contrib(res.mca, "var", axes = 3,fill='lightgray')
ggpar(c,main='Contribution of variables to dimension 3')

c<-fviz_contrib(res.mca, "var", axes = 1:3,fill='lightgray')
ggpar(c,main='Contribution of variables to the first 3 dimensions')

#Another way to express contribution to PC that is correlations with that axis
res.desc <- dimdesc(res.mca, axes = c(1,2,3), proba = 0.05)
# Description of dimension 1
res.desc[1]
res.desc[2]
res.desc[3]


d<-fviz_mca_var(res.mca, repel = TRUE,
              col.var = "black")
ggpar(d,main='')
d<-fviz_famd_var(res.mca, repel = TRUE,
              col.var = "black",axes=c(1,3))
ggpar(d,main='')
#color by contribution
e<-fviz_mca_var(res.mca, col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
              repel = TRUE,axes=c(1,2))
ggpar(e,main='Variables color by contribution')
e<-fviz_mca_var(res.mca, col.var = "contrib", 
                 gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                 repel = TRUE,axes=c(1,3))
ggpar(e,main='Variables color by contribution')
e<-fviz_mca_var(res.mca, col.var = "contrib", 
                 gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                 repel = TRUE,axes=c(2,3))
ggpar(e,main='Variables color by contribution')


# Color by cos2 values: quality on the factor map
e<-fviz_mca_var(res.mca, col.var = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
              repel = TRUE,axes=c(1,2))
ggpar(e,main='Variables color by cos2')
e<-fviz_mca_var(res.mca, col.var = "cos2",
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
              repel = TRUE,axes=c(1,3))
ggpar(e,main='Variables color by cos2')
e<-fviz_mca_var(res.mca, col.var = "cos2",
                 gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
                 repel = TRUE,axes=c(2,3))
ggpar(e,main='Quantitative variables color by cos2')


#corrplot cos2 on all dimensions
var <- get_mca_var(res.mca)
var
corrplot(var$cos2,is.corr=FALSE)
#corrplot contribution on all dimensions
corrplot(var$contrib,is.corr=FALSE)

#3d plot
mca3d <- MCA(df, ncp=3,axes=c(1,2),graph = FALSE)
summary(mca3d)
mca3d.ind<-get_mca_ind(mca3d)
ind=as.data.frame(mca3d.ind$coord)
ind
mycolors <- ~c('cluster1','cluster1','cluster2','cluster3','cluster1','cluster2','cluster2','cluster2','cluster1','cluster2','cluster1')
fig2 <- plot_ly(ind, x = ind$`Dim 1`, y = ind$`Dim 2`, z = ind$`Dim 3`, text=rownames(ind),
                mode='markers+text',type='scatter3d' ,color = mycolors, 
                colors=c('black','blue','green','red'),symbol=mycolors,
                symbols=c('cross','diamond','square','circle')
                ) 
fig2
#color by cos2
cos2tot<-rowSums(mca3d.ind$cos2)
individuals<-mca3d.ind$cos2
individuals<-as.data.frame(individuals)
individuals$costot <- as.vector(cos2tot)
individuals
fig3 <- plot_ly(individuals, x = individuals$`Dim 1`, y = individuals$`Dim 2`, z = individuals$`Dim 3`, text=rownames(individuals),
                mode='markers+text',type='scatter3d' ,color = ~costot, 
                colors=c('black','blue','green','red'),symbol=mycolors,
                symbols=c('cross','diamond','square','circle')
) 
fig3

Investigate(res.mca,file='MCAInvestigationResults.Rmd',document='pdf_document')
