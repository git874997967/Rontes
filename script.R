#柱状图 

hist(airquality$Wind,xlab="wind",ylab="abf")
boxplot(airquality$Wind,xlab="abc",ylab="abc")
 
#查看不同月份   不同月份 是分类变量  风速是数值变量 
boxplot(Wind~Month,airquality,xlab="abc",ylab="cv")


##hist

boxplot(airquality$Wind,ylab="Speed(mph)")
# 分类变量和 数值变量的关系   第一个变量用函数表示 
boxplot(Wind~Month,airquality)
title(main="主标题 ")
plot(airquality$Wind,airquality$Temp)
# with 方法  
with(airquality, plot(Wind,Temp,main="在这里也可以添加标题 ",type="n",col="red"))

#subset 分步骤  进行画图  
with(subset(airquality,Month==9),points(Wind,Temp,col="red"))
with(subset(airquality,Month==5),points(Wind,Temp,col="blue"))
with(subset(airquality,Month %in% c(6,7,8)),points(Wind,Temp,col="green"))
 
#回归分析之前要进行 建模 添加回归线拟合数据 
#第一步  拟合模型 线性模型   
fit=lm(Temp~Wind,airquality)
# 用abline 划线  宽度2 lwd=2
abline(fit,lwd=2)
#添加颜色的含义   位置
legend("topright",pch=1,
       col=c("red","blue","green"),
       legend=c("Sep","May","Other"))