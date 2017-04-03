 library(ggplot2)
 library(devtools)
 library(Rcpp)
 install_github('ramnathv/rCharts')
 install_github("madlogos/recharts") 
 library(rCharts)
 library(recharts)
 library(d3r)
 #basic scatter plot
 qplot(mpg,wt,data=mtcars)
 names(mtcars) = gsub("\\.", "", names(mtcars))
 rPlot(mpg ~ wt , data = mtcars, color = 'wt', type = 'point')
 # change the shape of the point with ggplot2
 #  use factor function will have a better effect when
 #the size is not too big 
 facr=factor(mtcars$cyl)
 p= ggplot(mtcars,aes(x=mpg,y=wt,color=facr))
 
 p+ geom_point()+theme_classic()+ggtitle("scatter plot in ggplot2")+xlab("mpgg")+ylab("weight")+labs("cylinders")
 
 
 