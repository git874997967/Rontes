# principal components analysis
head(mtcars)
library(psych)
head(USArrests)
c=cor(USArrests)
e=eigen(c)
e
# pca only work with numical items!!!
# provide the unrotated principal component analysis
pc=princomp(mtcars,cor=TRUE,scores=TRUE)
summary(pc)
# with different scale  will choice different model to analysis
pcc=prcomp(mtcars,cor=TRUE,scale=FALSE)
summary(pcc)
pc1=princomp(iris[c(-5)],cor=TRUE,scores=TRUE)
pc2=princomp(USArrests,cor=TRUE,scores=TRUE)
summary(pc2)
summary(pc1)
plot(pc2,type="l")
plot(pc1,type="l")
principal(pc)
pc$weights
fit=principal(mtcars,nfactors = 5, rotate="varimax")
fit
#select cumulative proportion should higher than 85%
summary(pc)
loadings(pc)
plot(pc,type="l",col=2)
pc$socres
# see the trends of each components
biplot(pc)
attributes(pc)
pc$loadings

fit=factanal(mtcars,3,rotation = "varimax")
load=fit$loadings[,1:2]
plot(fit,type="n")
text(load,labels=names(mtcars),cex=.7)
