library(rpart)
library(rpart.plot)
d=iris
# 构建数据集 一定要学会 
sample_date <- sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
train=iris[sample_date==1,]
test=iris[sample_date==2,]
head(test)
sam=sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
s=sample(150,50)
dim(test)
par(mfrow=c(1,1))
 dtm=rpart(Species~., data=train,method="class")
plot(dtm)
text(dtm) 
rpart.plot(dtm,type=4,extra=101)
tree_predict=predict(dtm,test,type="class")
table(tree_predict)
table(test$Species)

sam=sample(2,nrow(diamond),replace = TRUE,prob=c(0.7,0.3))
d_train=diamond[sam==1,]
d_test=diamond[sam==2,]
d_dtm=rpart(price~.,data=d_train)
rpart.plot(d_dtm)
d_pre=predict(d_dtm,d_test)

table(d_pre)
table(d_test$price)
