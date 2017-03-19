#for basic  plots
library(vcd)
library(plotrix)
counts=table(Arthritis$Improved)
counts
head(Arthritis)

barplot(counts,main="Simple bar plot",
        xlab="Improvement", ylab=" Frequncy")
barplot(counts,main="Simple bar plot",horiz=TRUE,
        xlab="Improvement", ylab=" Frequncy")
with(Arthritis,
     plot(Improved, main="this is title",
          xlab="this is xlab",
          ylab="this is ylab",
          horiz = TRUE)
)
counts=table(Arthritis$Treatment,Arthritis$Improved,)
counts
barplot(counts)
legend=rownames(counts)
barplot(counts,beside = TRUE,horiz = TRUE,
        legend=rownames(counts))

states=data.frame(state.region,state.x77)
means=aggregate(states$Illiteracy,by=list(state.region),FUN=mean)
means=means[order(means$x),]
# cex.names change the size of font
barplot(means$x, names.arg=means$Group.1, besides=TRUE,cex.names = 0.5)


# spin gram
attach(Arthritis)
# the order is really mater  tghe first will become the x axis and the second become y axis
counts=table(Treatment,Improved)
spineplot(counts,main="title of spinplot")
detach(Arthritis)
#  pie chart  limited functions

par(mfrow=c(2,2))
slices=c(10,12.4,16,8,7)
lbls=c("US","UK","AUS","GER","FRAN")
pie(slices,labels = lbls,main="simple chart")

pct=round(slices/sum(slices)*100)
pie(slices,labels =  lbls , col=rainbow(length(lbls)),main="simple chart")


pie3D(slices ,labels=lbls,explode=0.1,main="3D chart")
fan.plot(slices,labels=lbls,main="fan plot",cex.name=0.5)

hist(slices)
par(mfrow=c(2,2))
hist(mtcars$mpg)
with(mtcars,(
  hist(
    mpg,breaks=12, col="red",xlab=" mpg",main=" colored mpg with 12 bins"
  )
))
with(mtcars,(
  hist(mpg,freq=FALSE, breaks=12,col="green",xlab="Mpg",main=" his of mpg ")
),
rug(jitter(mpg)),
lines(density(mpg),col="blue",lwd=2)
)

x=mtcars$mpg
h=with(mtcars,hist(mpg,breaks=12,col="blue",xlab="mpg",main="hist of mpg of mtcars"))

# error happens on length
xfit=seq(min(x),max(x),length-40)
yfit=dnorm(xfit,mean=mean(x),sd=sd(x))
yfit=yfit*diff(h$mids[1:2])*length(x)
lines=(xfit,yfit,col="green",lwd=2)
box()

#核密度图
h=density(head(mtcars$mpg))
t=density(tail(mtcars$mpg))

par(mfrow=c(2,1))

plot(d,main="kernel density of miles per gallon")
polygon(d,col= rgb(255, 0, 0, 80, maxColorValue=255),border = "blue")
polygon(t,col= rgb(0, 255, 0, 80, maxColorValue=255) ,border = "blue")
rug(mtcars$mpg,col="brown")
mtcars$mpg


