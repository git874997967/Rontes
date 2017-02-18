#进行  回归树和随机森林的测试 
#R语言完成CART
#1   调用  rpart包进行建模
library(rpart)
head(stagec)
progstat= factor(stagec$pgstat,levels=0:1,labels=c("No","Prog"))
#建树 做生存分析通常选择  exp  因变量是因子变量 选择class   做poission 选择 poisson   其他情况选择  anova
cfit=rpart(progstat~age +eet+g2 +grade +gleason+ploidy,data=stagec,method='class')
#输出结果
print(cfit)
#作图
par(mar=rep(0.1,4))
plot(cfit)
#添加标签 
text(cfit)
# 对分类结果做混淆矩阵
(temp = with(stagec, table(cut(grade, c(0, 2.5, 4)),cut(gleason,c(2,5.5,10)),exclusde=NULL)))
#3剪枝
cfit2=prune(cfit,cp=.02)
plot(cfit2)
text(cfit2)
printcp(cfit2)# 输出剪枝表格 
summary(cfit2) #输出完整细节
y=matrix(1:20,nrow=4,ncol=5)
print(y)
mymatrix=matrix(c(1,26,25,66),nrow=2,ncol=2, byrow = FALSE,dimnames = list(c("R1","R2"),c("AA","BB")))  

print(mymatrix)
 
summary(mtcars$mpg)
plot(mtcars$mpg,mtcars$disp)
attach(mtcars)
summary(mpg)
plot(mpg,disp)
with(
  mtcars,{
   status<<-summary(mpg,disp,wt)
  plot(mpg,disp)
  plot(mpg,wt)
  })
status
#with(数据集名称,{ 对数据集进行的 操作}) 彼此之间没有逗号分开  
sta=factor(c("important","poor","excellent",order=TRUE,levels=c("poor","important","excellent")))
print(sta)
str(sta)
summary(airquality)
t="my first list"
v=c(25,26,18,39)
m=matrix(1:10,nrow=5)
n=c("one","two","three")
mylist=list(title=t,ages=v,m,n)
summary(mylist)
mylist
mylist=edit(mylist)
fix(mylist)

head(airquality,10,na.remove=TRUE)
pdf("abc.pdf")
with(mtcars,{
  plot(mpg,disp)
  plot(wt,mpg)
  abline(lm(mpg~wt))
  title("regression of mpg on weight")
})
dev.off()



