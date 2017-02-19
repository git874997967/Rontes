pdf("mygraph1.pdf")
 attach(mtcars)
plot(mpg,wt)
abline(lm(wt~mpg))

title("regression of mpg on wtt")
detach(mtcars)
with(airquality,{
  plot(Wind,Solar.R)
  abline(lm(Solar.R~Wind))
  title("regression of wind on solar")
  })
dev.off()
#colors example
 
 n=10
 mycolors=rainbow(n)
 pie(rep(1,n),labels = mycolors,col=mycolors)
 mygrays=gray(0:n/n)
 pie(rep(1,n),labels = mygrays,col=mygrays)
 #list all fonts you can use in pdf
 names(pdfFonts())
 
# a simple example
dose= c(20,30,40,50,60)
drugA=c(16,20,27,40,60)
drugB=c(15,18,25,31,40)
A=data.frame(dose,drugA,drugB)
 


opar=par(no.readonly = TRUE)
#pin means the size of graph   wide and height
par(pin=c(2,3))
# lwd means the line width and cex means the size of symbol
par(lwd=2,cex=3)
par(mar = rep(2)) 
par(cex.axis=.75,font.axis=3)
with(A,{
  #lty means the style of line   pch means the symbol style. 
  plot(dose,drugA,type="b", pch=19,lty=2,col="red")
  title(main="this is title",sub="this is subtitle",xlab=" x axis",ylab="y axis")
#  plot(dose,drugB,type ="b", pch=23, lty=6,col="blue", bg="green")
})
par(opar)

x=c(1:10)
y=x

z=10/x
opar=par(no.readonly = TRUE)
par(mar=c(4,4,4,4))
plot(x, y, type="b",pch=21,col="red",yaxt="n",lty=3,ann=FALSE)
lines(x,z,type="b", pch=22,col="blue",lty=2)
axis(2,at=x,labels = x,col.axis="red",las=2,tck=0.1)
axis(4,at=z, labels=round(z,digits=2),col.axis="blue",las=2,cex.axis=0.7,tck=-0.1)
mtext("z=1/x",side=1,line=3,cex.lab=1,las=2,col="blue")
title("an example of creatibe axes",xlab=" x values",ylab="Y=X")
par(opar)


opar=par(no.readonly = TRUE)
par(lwd=2,cex=0.5,font.lab=2)
with(A{
  plot(dose,drugA, type="b", pch=15, lty=1, col="red", ylim=c(0,60),main="DrugA vs Drug B",
       xlab="Drug dosage ", ylab=" drug response")
  lines(dose, drugB,type = "b", pch=17,lty=2,col="blue")
  abline(h=c(30),lwd=1.5,lty=2,col="gray")
  #个人理解这个是自定义的一个  像文本边界添加注释  
  mtext("AAA",col="black",las=1,side=2)
  library(Hmisc)
  #minor.tick(nx=3,ny=3,tick.radio=0.5)
  legend("topleft",inset=.05,title="drug type", c("A","B"),lty=c(1,2),pch=c(15,17),col=c("red","blue"))
})
par(opar)
#利用 text 方法描述  图性中的点 
head(mtcars)

with(mtcars,{
  plot(wt,mpg,main="millage vs car weight",
       xlab="weight",
       ylab="millage",
       pch=18,col="blue",lty=1)
  text(wt,mpg,row.names(mtcars),cex=0.6,pos=4,col="red")
  mtext("显示在上面的坐标注释",side=3,col="red")
  legend("topright",inset = .05,title=" 汽车类型", c("brand name"),lty=c(1),pch=c(18),col="blue" )
})
 opar=par(no.readonly = TRUE)
 par(cex=1.5)
 plot(1:7,1:7,type="n")
text(3,3,"example of mono-spaced text")
 text(4,4,family="mono","example of mono-spaced text")
 # text(5,5,family ="serif", "example of serif text")
par(opar)



# 多个  图表进行组合

opar=par(no.readonly = TRUE)
par(mfrow=c(2,2))
with(mtcars,{
  plot(wt,mpg,main="scatterplot of wt vs mpg")
  plot(wt,disp, main=" scatterplot of wt vs disp")
  hist(wt,main="histogram of wt")
  boxplot(wt,main="boxplot of wt")
})
par(opar)

attach(mtcars)
layout(
  matrix(c(1,1,2,3),2,2, byrow =  TRUE),
  widths = c(3,1),heights = c(1,2)
  )
hist(wt)
hist(disp)
hist(mpg)
detach(mtcars)

opar=par(no.readonly = TRUE)
par(fig=c(0, 0.8, 0, 0.8))
plot(mtcars$wt,mtcars$mpg,xlab="mpg",ylab="car weight")
par(fig=c(0, 0.8, 0.55, 1),new=TRUE)
boxplot(mtcars$wt,horizontal = TRUE, axis=FALSE)
par(fig=c(0.65, 1, 0,0.8),new=TRUE)
boxplot(mtcars$mpg,axis=FALSE)
mtext(" enhance scatterplot",side=3,outer=TRUE,line=-3)
par(opar)
  
 

 
 
