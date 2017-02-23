library(ggplot2)
library(car)
library(rpart)
library(maptree)
library(randomForest)
head(diamonds)
diamond=data.frame(diamonds)
# sample_data <- sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
# 
# sample_data
# 
# tra_data <- iris[sample_data==1,]
# 
# test_data <- iris[sample_data==2,]

lm1=lm(price~carat+depth+table+x+y+z+cut+color+clarity,data=diamond,na.rm=TRUE)
lm2=lm(price~., data=diamond[-c(2,3,4)])
summary(lm2)
summary(lm1)
steplm1=step(lm1)
steplm2=step(lm2)
summary(steplm1)
summary(steplm2)
par(mfrow=c(2,2))
plot(steplm1)
dfp1=predict(steplm1,interval="prediction")
dfp2=predict(steplm2,interval="prediction")
 
# big memory required
#mdf=merge(diamond$price,dfp)
mdf1=merge(head(diamond$price,1000),head(dfp1,1000))
mdf2=merge(head(diamond$price,1000),head(dfp2,1000))
id=(1:1000000)
mdf1=cbind(mdf1,id)
mdf2=cbind(mdf2,id)
matplot(id,mdf1[1:4],type="l",lwd=1,col=c(1:6,8:9),xlab="x",ylab="y")
matplot(id,mdf2[1:4],type="l",lwd=1,col=c(1:6,8:9),xlab="x",ylab="y")
# legend("bottomleft",inset=.05, c("price","fit","lwr","upr"),lwd=1,col=c(1:6.8,8:9))
cor.test(as.data.frame(diamond))
###
#regression trrr model
tm1=rpart(price~.,data=diamond)
draw.tree(tm1)
rsq.rpart(tm1)
plotcp(tm1)
tm2=prune(tm1,cp=0.1)
tm2
draw.tree(tm2)
#random forest
m =ncol(diamond)
for (i in 1:(m-1)){
  rf1 <- randomForest(price~.,head(diamond,1000),mtry=i,importance=TRUE,
                             proximity=TRUE)
  mse <- mean(rf1$mse)
  print(mse)
}
fm1 <- randomForest(price~.,data=diamond,mtry=6,ntree=300)
plot(fm1) 
