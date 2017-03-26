library(rpart)
library(rpart.plot)
library(tree)
library(evtree)
d=iris
# 构建数据集 一定要学会 
sample_date <- sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
train=iris[sample_date==1,]
test=iris[sample_date==2,]
head(test)
sam=sample(2,nrow(iris),replace=TRUE,prob=c(0.7,
                                            0.3))
s=sample(150,50)
s
dim(test)
par(mfrow=c(1,1))
#with rpart
 dtm=rpart(Species~., data=train,method="class")
plot(dtm)
text(dtm,all=TRUE) 
rpart.plot(dtm,type=4,extra=101)
# type=class is important
tree_predict=predict(dtm,test,type="class")
table(tree_predict)
table(test$Species,tree_predict)
mean(tree_predict==test[,5])
#with tree  alittle different with rpart tree 
dtm2=tree(Species~.,data=train,method="class")
plot(dtm2)
text(dtm2,all=TRUE)

# type class is important
predict2=predict(dtm2,test,type="class")
table(test$Species,predict2)
mean(predict2==test[,5])
# with evtree

dtm3=evtree(Species~.,data=train,method="class")
plot(dtm3)
predict3=predict(dtm3,test,method="class")
table(test$Species,predict3)
mean(predict3==test[,5]) 
sam=sample(2,nrow(diamond),replace = TRUE,prob=c(0.7,0.3))
d_train=diamond[sam==1,]
d_test=diamond[sam==2,]
d_dtm=rpart(price~.,data=d_train)
rpart.plot(d_dtm)
d_pre=predict(d_dtm,d_test)
table(d_pre)
table(d_test$price)
