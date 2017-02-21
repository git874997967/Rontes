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
#string methods
paste("x",1:3,seq="M")
paste("today is ",date())
paste("x",1:4,seq=FALSE)

options(digit=2)#  数字全部用两位小数表示
Student=c("J S","A W","B M","D J","J M","C C","R Y","G K","J E","M R")
Math=c(502,600,412,358,495,512,410,625,573,522)
Science=c(95,99,80,82,75,85,80,95,89,86)
English=c(25,22,18,15,20,28,15,30,27,18)
roster=data.frame(Student,Math,Science,English,stringsAsFactors = FALSE)
roster

z=scale(roster[,2:4])
score=apply(z,1,mean)
roster=cbind(roster,score)
y=quantile(score,c(.8,.6,.4,.2))
roster=within(roster,{
  roster$grade[score>=y[1]]="A"
  roster$grade[score<y[1]&score>=y[2]]="B"
  roster$grade[score<y[2]&score>=y[3]]="C"
  roster$grade[score<y[3]&score>=y[4]]="D"
  roster$grade[score<y[4]]="F"
})
name=strsplit((roster$Student)," ")
lastName=sapply(name,"[",2)
firstName=sapply(name,"[",1)
roster=cbind(firstName,lastName,roster[,-1])# 有了详细的姓名 不用student  列了 
roster=roster[order(firstName,lastName),]

roster




