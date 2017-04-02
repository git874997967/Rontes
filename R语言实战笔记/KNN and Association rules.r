#kNN algo
library(class)
sam_iris=sample(2, nrow(iris),replace = TRUE, prob=c(0.85,0.15))
train_iris=iris[sam_iris==1,]
test_iris=iris[sam_iris==2,]
target=train_iris[,5]
####???
knnModel=knn(train_iris,test_iris,cl=train_iris$Species,k=13)
airquality=na.omit(airquality)
sam_air=sample(2,nrow(airquality),replace = TRUE,prob=c(0.85,0.15))
train_air=airquality[sam_air==1,]
test_air=airquality[sam_air==2,]
knn_air=knn(train_air,test_air,cl=train_air$Month,k=15)
table(knn_air,test_air$Month)


### association rules
#基本思想 将每笔交易变成 0 1 表示  所有的交易表示成稀疏矩阵   在内存中操作矩阵
library(arules)
library(arulesViz)

Groceries
summary(Groceries)
#inspect display associations and transactions in readable form
#  显示每一笔交易  不能再数据框上使用  在transaction 上使用 
inspect(Groceries[1:3,])
# support 查看每笔交易的比例

itemFrequency(Groceries[,1:10])
hist(itemFrequency(Groceries))
 
#itemFrequencyPlot   create a barplot of a item frequencies support
itemFrequencyPlot(Groceries,topN=100,type="relative")
m2=apriori(Groceries)
m2
summary(m2)
m3
summary(m3)
m3=apriori(Groceries,parameter = list(support=0.007,confidence=0.25,minlen=2))
inspect(m3)
?sort
inspect(sort(m3,by="lift")[1:5,])
p <- inspectDT(m3)
p
htmlwidgets::saveWidget(p, "arules.html", selfcontained = FALSE)
browseURL("arules.html")
