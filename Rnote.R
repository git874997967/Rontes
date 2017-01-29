head(airquality)
X=c(1,9,2,8,3,9,4,5,7,6)
# 求平均数
mean(X)
#中位数 
median(X)
#方差
var(X)
#标准差
sd(X)
#有效显示各项指标
summary(X)


#数值型变量   柱状图 喝相图
hist(airquality$Wind)
boxplot(airquality$Wind)
# 相图   数值喝分类变量的关系   x  表示分类  y 表示  数据  

#  x 自变量  y 因变量  
# 数值信息要放在y轴
boxplot(Wind~Month,airquality)
 
plot(airquality$Wind,airquality$Temp)
plot(airquality$Temp,airquality$Wind)
#定制化图片  type=n
with(airquality,plot(Wind,Temp, xlab = "Wind",ylab = "Temp",title(main ="abc"),type='n'))
#按照月份来画点
with(subset(airquality,Month==9),points(Wind,Temp,col="red"))
with(subset(airquality,Month %in% c(7,6,5)),points(Wind,Temp,col="blue"))
with(subset(airquality,Month==3),points(Wind,Temp,col="yellow"))

with(subset(airquality,Month==2),points(Wind,Temp,col="pink"))
#回归线是统计图的一部分 要在原图上进行添加   不能凭空画出
#lm  line model 线模型 legend   图例  通常放在 右上角   
fit=lm(Temp~Wind,airquality)
abline(fit,lwd=2)
legend("topright",pch=2,col=c("red","blue","black"),
       legend=c("Sep","May","Other"))

#全局变量的一些知识    一次设置  在第二次 改变之前都会是按照这样的设置进行画图 
par("bg")
par("col")
par("mar")#  top  bott   rig   left
par("mfrow")
par(mfrow=c(1,2))
hist(airquality$Wind)
hist(airquality$Temp)
with(airquality,hist(Wind))
with(airquality,hist(Temp))





#lattice  绘图系统  

library(lattice)
xyplot(Temp~Ozone,data=airquality)
airquality$Month=factor(airquality$Month)
q=xyplot(Temp~Ozone | Month,data=airquality,layout=c(5,1))
print(q)
#种子点的意义在于  设置随机数的时候可以重现  
# 可以用于验证    用到随机数 一定配套使用 种子点 
set.seed(1)
x=rnorm(100)
#repeat 方法  将  0，1  每个数字重复50次 
f=rep(0:1,each=50)

y=x+f-f*x+rnorm(100,sd=0.5)
f=factor(f,labels = c("group1","group2"))
xyplot(y~x |f,layout=c(1,2))

xyplot(y~x | f, panel =function(x,y){
# 调用 默认 的panel 函数    重写  panel 方法 
  panel.xyplot(x,y)
  panel.abline(v=mean(x),h=mean(y),lty=2,lwd=2)
  panel.lmline(x,y,col="red")
})
#ggplot layer 

#qplot 

install.packages("ggplot2")  
library(ggplot2)
#factor 化 变量
airquality$Month=factor(airquality$Month)
qplot(Wind,Temp,data=airquality,col=Month)
qplot(Wind, Temp,data=airquality,color=Month,main="qplot 的标题 ",xlab="windSpeed",ylab="Month",log="I do not know what is the meanning of the log ",geom=c("point","smooth"),facets= Month~.)
qplot(Wind,data=airquality,color=Month,main="qplot 的标题 ",xlab="windSpeed",ylab="Month",log="I do not know what is the meanning of the log " ,geom="density" )
 #qplot 中 回归线 用 gemo 方法 实现  而不是  lm  和 abline

# 第一个参数是数据集 dataset   第二个是 修饰用的层  第三个是美学客体层
# 将 month  强转成  factor   是美学维度 的变换 要用 aes包裹起来 
ggplot(airquality,aes(Wind,Temp))+geom_point(aes(color=factor(Month)),alpha=0.4,size=5)


#添加统计信息层  2种方法 
# 在 stat 层  可以  动态控制   回归线的堆叠   如果在 ggplot 层 则会  只显示 一个 回归线  不够灵活 
ggplot(airquality,aes(Wind,Temp,col=factor(Month)))+
  geom_point()+
  stat_smooth(method="lm",se=FALSE,aes(group=1))+
  stat_smooth(method="lm",se=FALSE)
library(RColorBrewer)
#从  Dark 2 调色板 选取5种颜色 第六个颜色是黑色 
mc=c(brewer.pal(5,"Dark2"),"black")
ggplot(airquality,aes(Wind,Temp,col=factor(Month)))+
  geom_point()+
  stat_smooth(method="lm",se=FALSE,aes(group=1,color="All"))+
  stat_smooth(method="lm",se=FALSE)+
  scale_color_manual("Month",values=mc)
 


mc=c(brewer.pal(5,"Dark2"),"black")

ggplot(airquality,aes(Wind,Temp ,color=factor(Month)))+   # 通过 facet grid  之后  Month  已经变成一个变量  所以 不用 添加引号  但是搞不懂  black   要用字符串去传值
  geom_point()+                               #   设置是否显示 数据点 
  stat_smooth(method="lm",se=FALSE)+        # 设置  会给回归线 画法 
  scale_color_manual("Month",values=mc)+   #   手动设置调色板 
  facet_grid(.~Month)                   #按照月份进行分面板显示  
  


#看到所有调色板 
display.brewer.all()
