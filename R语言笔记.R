# R语言 代表注释  向量笔记
# 5种基本数据类型  整数  数值   字符  布尔 向量 
#names(x1)=c("a","b","c","d")
#运行后结果是 第一个名称是a 第二个元素名称是b  第三个是c  第四个是 d
x=vector("character",length=10)
x1=1:4
x2=c(1,2,3,4)
x3=c(1,TRUE,3L,"a")
class(x3)
# 矩阵和数组
x5=matrix(1:6,nrow=2,ncol=3)
dim(x5)
attributes(x5)
x6=1:6
dim(x6)=c(2,3)
rbind(x6,x5)
cbind(x6,x5)
x7=array(1:24,dim=c(4,6))
#三维数组 dim=c(2,3,4) 表示有四个 两行三列的数组 
#列表可以包含不同类型的元素
l1=list(1,"TRUE",TRUE,3L,4+5i)
l2=list(a=1,b=2,c=3)
l3=list(c(1,2,3),c(2,3,4))
#dimnames 给矩阵的每行每列进行命名
x8=matrix(1:6,nrow=2,ncol=3)
dimnames(x8)=list(c("a","b"),c("c","d","e"))


#factor 因子  整数型向量+ 标签

z=factor(c("female","female","female","male","male"))
z1=factor(c("female","female","female","male","male"),levels=c("male","female"))
table(z)
table(z1)
unclass(z)
#NaN 属于NA     NA(所有缺失值) 不属于NaN(数字缺失值)
# 判断是否有缺失值   使用 is.na() is.nan()
z2=c(1,NA,TRUE,NA,"xdb")
z3=c(1,NA,TRUE,NaN,"xdb")
is.na(z2)
is.nan(z3)
is.na(z3)
# 数据框 每个元素代表一类数据 每个元素长度代表行数  元素类型可以不同


df=data.frame(id=c(1,2,3,4),name=c("d","d","cvb","cb"),gender=c(TRUE,FALSE,TRUE,FALSE))
# 日期和时间
# 主要方法有  date()/Sys.Date()/weekdays()/months()/quarters()


d=date()
d2=Sys.Date()
class(d2)
#任意一个日期存储到日期类型
d3=as.Date("1991-07-01")
class(d3)
weekdays(d3)
quarters(d3)
months(d3)
julian(d3)
d4=as.Date("2012-01-12")
as.numeric(d4-d3)
#POSTct   整数  常用于存入数据框
#POST lt 列表 还包括星期  年月日等信息

e=Sys.time()
class(Sys.time())

p=as.POSIXlt(e)

class(p)

class(Sys.time())
class(as.POSIXlt(Sys.time()))
names(unclass(p))
p$sec
 e1="Jan 1 2015 01:10"
 
strptime(e1,"%B %d %Y %H:%M")
# 拿到的数据叫做原始数据  数据预处理 clean  dataset   
# 构建子集 基本方法  
#[] 提取一个或者多个类型相同的元 素 
# 类似 对数组的操作 下标从1 开始
#[[]]  从列表或数据框中提取元素
#$ 按名字从列表或数据框中提取元素

n=1:5
n[1:5]
n[n>2 & n<5]
names(n)=c("a","b","c","d","e")
n['b']
n[(n %%3)==1]
m=matrix(1:6,ncol=3,nrow=2)
m[1,]
#返回一个矩阵 而不是数组
m[1,,drop=FALSE]
o=data.frame(v1=1:5,v2=6:10,v3=11:15)
o$v3[c(2,4)]=NA
o[,"v2"]
o[(o$v1<4&o$v2>=8),]

o[(o$v1<4|o$v2>=8),]
# which 方法相当于 把true的返回结果直接显示了
subset(o,o$v1>2)
p=list(id=1:4,height=170,gender="Male")
#列表比矩阵复杂  只拿到列表中元素值不要名字的话要嵌套两层中括号
p[[1]]=#1234
# p$ 后面要直接接名字而不是 引用名称 
  #从列表中获取嵌套的元素
# c 和list 的使用不同  list 先是水平  c是在之后纵向扩展
q1=list(a=list(1,2,3,4),b=c("Monday","Tuesday"))
View(q1)
q2=list(b=list("Monday","Tuesday"),a=c(1,2,3,4))
View(q2)
#q2[[1]][[2]] 相当于 对二维数组进行[1][2] 
#q2[[c(x,y)]] 列表中第x个元素的第y个元素
# 不完全匹配
l=list(asdf=1:10)
View(l)
#关掉精确匹配 首字母生效
l[["f",exact=FALSE]]
# 处理缺失值
r1=c(1,2,3,NA,4,NA)
r2=c(1,NA,3,NA,NA,NA)
is.na(r1)
which(is.na(r1))
r3=complete.cases(r1,r2)
View(r3)
#数据集  []操作针对数据集   只要前面是数据集  []可以叠加
library(datasets)
head(airquality)
airquality
a1=complete.cases(airquality)
View(a1)
airquality[a1,][1:10,][1:3,]

# 向量化操作
install.packages("swirl")
library("swirl")
swirl()
#lapply 作用是 循环处理列表中的每一个元素 
# 第一个参数强制转换成列表 
#lapply(列表名  函数名  其他参数)
str(lapply)

L=list(a=1:10,b=c(11,21,31,41,51))
lapply(L,mean)
L=1:4
 lapply(L,runif)
 lapply(L,runif,min=0,max=100)
# R 语言 先填充列元素  
L=list(a=matrix(1:6,2,3),b=matrix(1:6,3,2))
lapply(L,function(m)m[0,])
#SLAPPLY  化简 lapply 结果

#apply 相当于 foreach    apply(数组, 纬度 函数/函数名)
M=matrix(1:16,4,4)
apply(M,2,mean)
#rowSums   rowMeans colSums colMeans
#mapply   lapply 多元版本   mapply(函数/数据/函数相关参数)
L1=list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
mapply(rep, 1:4, 4:1)
#n  正态分布抽取数据的个数   mean 平均数   std   标准差
s=function(n,mean,std){
  rnorm(n,mean,std)
}
#  从平均值为0 标准差为1 的正态分布抽取四个数据 
s(4,0,1)
# 显示的关系表示并不是成疾影盛关系 而是  单纯的对应关系
mapply(s,1:5,5:1,4)

#split   对向量 列表进行分组 

A=c(rnorm(5),runif(5),rnorm(5,1))
B=gl(3,5)
split(A,B)

head(airquality)

#对数据集进行分组的的话  分组依据要用数据集列名字的时候用到 数据集$列名
s=split(airquality,airquality$Month)
split(airquality,airquality$Solar.R)
#   用table 方法 显示当前列下有多少条元素
table(airquality$Month)
# 显示 每个月温度的平均值 na.rm  =TRUE  在计算 的时候去掉NA值

sapply(s,function(x) colMeans(x[,c("Ozone","Temp","Wind")],na.rm = TRUE))

# sort  对象量进行排序  order   返回  排好序的下标  多个标准尽心排序

C=data.frame(v1=1:5,v2=c(10,7,6,8,9),v3=11:15,v4=c(1,1,2,2,1))
sort(C$v2)
sort(C$v2,decreasing = TRUE)
order(C$v2,decreasing = TRUE)
C[order(C$v2),]
# str 函数对数据进行总结
head(airquality)
tail(airquality)
str(airquality)
#table  分组后 默认没有缺失值  要显示NA 数据要写  useNA="ifany"
table(airquality$Month,airquality$Ozone,useNA = "ifany")

# any  all sum  summary
ti=as.data.frame(Titanic)
head(ti,10)
summary(ti)
#xtabs 交叉表   ftable  扁平化的表格 

Xt=xtabs(Freq~Class ,data=ti)


ftable(Xt)
print(object.size(airquality),unit="Kb")

#######
#
#
########
#R语言数据可视化 
A=c(1,2,3,4,5,3,4,5,2,8)
summary(A)
mean(A)
median(A)
sd(A)
var(A)

#####基本绘图系统  plot  方法  
plot(x,y)

