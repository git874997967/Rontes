#  相关性的监测
library(GGally)
library(pcaPP)
library(corrplot)
d=iris
dd=mtcars
head(d)
plot(d)
dd=iris[,c(-5)]
plot(dd)
# default pearson 
cor(dd)
symnum(cor(dd,method="kendall"))
#method	
#a character string indicating which correlation coefficient\
#(or covariance) is to be computed. One of "pearson" (default),
#"kendall", or "spearman": can be abbreviated.
cor(dd,method="kendall")
cor(dd,method="spearman")
cor.test(d$Sepal.Length,d$Sepal.Width)
plotcov(cor(dd,method="kendall") )
corrplot(cor(dd),type="lower")
set.seed(20022012)
diamonds_samp <- d[sample(1:length(d$Species),150),]
ggpairs(diamonds_samp )
diag(2.1, nr = 3, nc = 5)
 m <- matrix(c(1,1,2,1),2,2)
 layout(m, widths=c(2, 1),
         heights=c(1, 2))
 layout.show(2)