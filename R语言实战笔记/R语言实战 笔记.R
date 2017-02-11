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
hist(airquality$Wind)
# 从本地加载脚本文件   加上路径也可以
 
#sink()方法  会将文件重定向到一个文件  通常是写覆盖的   append=TRUE 会 变成追加 
#sink stack  可能会 出现full 情况
###  调试了半个小时  将总结的坑公布如下 
# 1 setwd  真心要用反斜杠/
# 2 sink 里面的文件 不知有何作用
# 3  环境还是有些不稳定 容易报错  例如
# ????同时保存两种格式的文件  第一种 并无法保存   最后的文件格式被保存
# append 方法 也不会在文件中追加而是直接写覆盖  虽然已经设置了append=TRUE

sink("abc.txt",append=FALSE,split=TRUE)

pdf("mygraphs.pdf")
jpeg("mygraphs.jpg")
source("test.R",encoding="UTF-8")
sink()
dev.off()
source("test.R")
View(mtcars)
#with(mpg~wt,data = mtcars)
#画图是先横坐标 x   再 中坐标 y   画反了的话 回归分析线出不来
with(mtcars,plot(wt,mpg,xlab = "车身重量",ylab = "汽车油耗",title(main="回归分析")))
fit=lm(mpg~wt,data=mtcars)
abline(fit,lwd=2)
summary(fit)
x=summary(fit)
help.start()
install.packages(vcd)
help(package=vcd)
#小练习
library(vcd)
help(Arthritis)
Arthritis
View(Arthritis)
example(Arthritis)
# 创建数据集合

# 变量分为 逻辑行 数值型  字符型 复数型 原生型
# 向量是一维数组 








 