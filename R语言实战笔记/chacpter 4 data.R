# 创建 leadership  数据 
manager=c(1,2,3,4,5)
date=c("10/24/08","10/28/08","10/1/08","10/12/08","5/1/09")
country=c("US","US","UK","UK","UK")
gender=c("M","F","F","M","F")
age=c(32,42,25,39,99)
q1=c(5,3,3,3,2)
q2=c(4,5,5,3,2)
q3=c(5,2,5,4,1)
q4=c(5,5,5,NA,2)
q5=c(5,5,2,NA,1)
B=data.frame(manager,date,country,gender,age,q1,q2,q3,q4,q5,stringsAsFactors=FALSE)
print(B)
# 对现有数据集 添加加项的时候  要使用 transform()方法  
mydata=data.frame(x1=c(2,2,4,6),x2=c(3,4,2,8))
print(mydata)
# mydata$sum=x1+x2
# mydata$mean=(x1+x2)/2
mydata=transform(mydata,sum=x1+x2,mean=(x1+x2)/2)
mydata
B$age[B$age==99]=NA
B
#variable[condition]=expression  将在condition 的值为true  时进行赋值
B
#使用  within 方法  实现如上的   操作 
B=within(B,{
  agecat=NA
  agecat[age>75]="elder"
  agecat[age>55&age<75]="Middle aged"
  agecat[age<55]="Young"
})
fix(B)
install.packages(reshape)
library(reshape)
B=rename(B,c(stringAsFactors="stringsAsFactors"))
print(na.omit(B))
# 日期以 字符串形势输入R   署执行时存储日期变量
Sys.Date()
date()
# order 排序函数   支持多个变源
attach(B)
newdata=B[order(age,gender),]
detach(B)
print(newdata)
A=c(1,2,3,4,5)
C=c(6,7,8,9,0)
D=cbind(A,C)
E=merge(A,C)
F=rbind(A,C)
print(D)
print(F)
#选取数据集的子集   [行范围  列范围]
print(B[c(1:3),c(2:4)])
#  剔除选定的变量   c(- 需要剔除的列序号)
B$date=as.Date(B$date,"%mm/%dd%y")
B
startdate=as.Date("2000-01-01")
B$date
startdate
enddate=as.Date("2019-10-31")
print(B[which(B$date>=startdate&B$date<=enddate)])
# 重头戏 随机抽样函数   有放回或者无放回 
mysample=B[sample(1:nrow(B),3,replace = FALSE),]
mysample
library(sqldf)
newdf=sqldf("select * from mtcars where carb=1 order by mpg",row.names=TRUE)
 print(sqldf("select round(avg(mpg)) as avg_mpg , avg(disp) as avg_disp, gear from mtcars where cyl in (4,6) group by gear"))
