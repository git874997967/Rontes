# random forest
# avoid the problem of overfitting 
library(randomForest)
s=sample(2,nrow(iris),replace=TRUE,prob=c(0.85,0.15))
train=iris[s==1,]
test=iris[s==2,]
rfm=randomForest(Species~., data=train,do.trace=TRUE,ntree=146)
predict5=predict(rfm,test)
summary(predict5)
table(test[,5],predict5)
importance(rfm)
mean(test[,5]==predict5)
getTree(rfm,500,labelVar = TRUE)
plot(rfm) 
