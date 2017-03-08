 library(sqldf)
 BD=as.data.frame(diamondsbig, na.rm=TRUE)
 BD=na.omit(BD,TRUE)
View(head(BD,100))

new_data=sqldf("select cert,count(*) from BD group by cert ")
 
new_data
