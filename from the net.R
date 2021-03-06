library(ggplot2)
library(tree)
library(party)
library(rpart)
library(randomForest)
library(rjson)
library("XML")
library(methods)
#https://www.brilliance.com/diamond-search?{%22priceMin%22:181,%22priceMax%22:6688103,%22priceMapMin%22:0,%22priceMapMax%22:99,%22caratMin%22:%220.15%20ct.%22,%22caratMax%22:%2229.36%20ct.%22,%22caratMapMin%22:0,%22caratMapMax%22:384,%22cutMin%22:0,%22cutMax%22:2,%22colorMin%22:0,%22colorMax%22:9,%22clarityMin%22:0,%22clarityMax%22:9,%22polishMin%22:0,%22polishMax%22:3,%22symmetryMin%22:0,%22symmetryMax%22:3,%22depthMin%22:0,%22depthMax%22:98.7,%22tableMin%22:0,%22tableMax%22:90,%22fluorMin%22:0,%22fluorMax%22:3,%22shapeList%22:[],%22certificateList%22:[0],%22sort%22:%22price%22,%22sort_order%22:%22desc%22,%22pager%22:100}
result=xmlParse(file="C:/Users/yzm/Desktop/1.xml")
result
# set.seed(1234)
# data=data.frame(y = 1:100+rnorm(100,0,5), x = 1:100,y.binomial = c(rbinom(20,1,0.2),rbinom(50,1,0.5),rbinom(30,1,0.7)))
# summary(data)
# fit=lm(data)
# step(fit)
# summary(fit)
# pre1=predict(fit,data)
# plot(data$y,type="l")
# points(pre1,type="l",col=2)
# 
# glm1=glm(y.binomial~x,family = "binomial",data=data)
# tmax=tree(y.binomial~x,data)
# plot(tmax)
# text(tmax,all=TRUE)
# pre2=predict(glm1,data,type = "response")
# pre3=predict(tmax,data)
# plot(pre3,type="l")
# points(pre2,type="l",col=2)
## method 1   multi linear regression
 
diamond=data.frame(diamonds)[sort(data.frame(diamonds)[,7]),]
lm2=lm(price~carat+depth+table+x+y+z+cut+color,data=diamond)
steplm2=step(lm2)
summary(steplm2)
price.predict=predict(steplm2,diamond)
matplot(diamond$price,type="l")
points(price.predict,type="l",col=2)
#  decission tree
tmax2=tree(price~.,data=diamond)
plot(tmax2)
text(tmax2,all=TRUE)
set.seed(1234)
tcv=cv.tree(tmax2)
plot(tcv)
tmax3=prune.tree(tmax2,k=2e+10)
plot(tmax3)
text(tmax3,all=TRUE)
pre4=predict(tmax2,diamond)

# glm method
glm2=glm(price~.,data=diamond)
glm3=step(glm2,diamond)
pre5=predict(glm3,diamond,type = "response")
matplot(diamond$price,type="l")
points(pre5,type="l",col=2)
matplot(diamond$price,type="l")
points(pre4,type="l",col=3)
#################################

# myFormula=price~carat+depth+table+x+y+z+cut+color+clarity
# diamond_ctree=ctree(myFormula,data=head(diamond,20))
# table(predict(diamond_ctree),head(diamond$price,20))
# print(diamond_ctree)
# plot(diamond_ctree,type="simple")
# rpart_tree=rpart(myFormula,data=diamond,control = rpart.control(minsplit = 10))
# 
# plot(rpart_tree)
# text(rpart_tree,all=TRUE)

##  random forest
 rf1=randomForest(price~., data=head(diamond,15000),importance=TRUE,proximity=TRUE)
 pre6=predict(rf1,diamond)
 plot(head(diamond$price,15000),type="l")
 points(pre6,type="l",col=3)
 
# table=table(pre6,diamond$price)
# sum(diag(table)/sum(table))
# model.forest.all <-randomForest(price ~ ., data =  head(diamond,5000),importance=TRUE,proximity=TRUE)
# importance(model.forest.all)
# varImpPlot(model.forest.all)
rf2 <- randomForest(price ~ ., data=head(diamond,100), ntree=100, proximity=TRUE)





