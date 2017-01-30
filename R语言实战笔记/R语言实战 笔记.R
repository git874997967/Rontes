#r 语言实战中的代码笔记 
install.packages(gclus)
library(cluster)
library(gclus)
age=c(1,3,5,2,11,9,3,9,12,3)
weight=c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
plot(age,weight,xlab="婴儿的年龄",ylab="婴儿的体重",title(main="婴儿体重和 月份关系 "))
fit=lm(weight~age)
abline(fit,lwd=2)
# cor 方法  用于表现两个变量之间是否具有强关系
#getwd()方法 查看当前你工作的目录 
options(digits=3)
x=runif(20)
summary(x)
hist(x)
savehistory()
save.image()
q()
load()

