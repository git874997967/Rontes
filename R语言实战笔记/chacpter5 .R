x=c(1,2,3,4,5,6,7,8)
 mean(x)
 sd(x)
 n=length(x)
meanx=sum(x)/n 
meanx
# css
css=sum((x-meanx)^2)
sdx=sqrt(css/(n-1))
sdx
#scale method
  newx=scale(x)
newx
z=pretty(c(-10,10),100)
y=dnorm(z)
plot(z,y,xlab="AS",ylab = "BB",yaxis="i",type="l")
z
y
# set the random number reproducible use the set.seed and runif togather
set.seed(1234)
runif(5)
runif(3)
#generate multi param normal destribution
library(MASS)
options(digits=3)
set.seed(1234)
mean=c(230.7,146.7,3.6)
sigma=matrix(c(15360.8,6721.2,-47.1,6721.2,4700.9,-16.5,-47.1,-16.5,0.3),nrow=3,ncol=3)
mydata=mvrnorm(500,mean,sigma)
mydata=as.data.frame(mydata)
names(mydata)=c("y","x1","x2")
dim(mydata)
head(mydata,n=10)

