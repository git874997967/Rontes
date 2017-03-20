
#chap7   basic  statistic analysis 
vars=c("mpg","hp","wt")
summary(mtcars[vars])
describe(mtcars[vars])
aggregate(mtcars[vars],by=list(am=mtcars$am,cyl=mtcars$cyl),mean)
aggregate(mtcars[vars],by=list(am=mtcars$am),sd) 
#aggregate can return single value only
describeBy(mtcars[vars],mtcars$am)

with(Arthritis,table(Improved))
attach(Arthritis)
#show the frenquicy number divide into the last type  for example below divide with sex
mytable=table(Improved,Sex)
mytable
fisher.test(mytable)
chisq.test(mytable)
#ftable(mytable)
# show the radio of each type
#prop.table(mytable)*100
detach(Arthritis)

table2flat=function(mytable){
  df=as.data.frame(mytable)
  rows=dim(df)[1]# 1 means rows and 2 means the col
  cols=dim(df)[2]
  x=NULL
  for(i in 1:rows){
    for(j in 1: cols){
      row=df[i,c(1:(cols-1))]
      x=rbind(x,row)
    }
  }
  row.names(x)=c(1:dim(x)[1])
  return (x)
}
tre=rep(c("A","B","C"),times=3)
imp=rep(c("AA","BB","CC"),each=2)
freq=c(29,13,7,17,7,21)
myt=as.data.frame(cbind(tre,imp,freq))
mydata=table2flat(myt)
head(mydata,20)