Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_91') # for 64-bit version
library(rJava)
library(Rwordseg)
library(XML)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)
library(devtools)
library(sparklyr)
spark_install(version = "2.0.2")
spark_available_versions()
install.packages("git2r")
install.packages("xml2")
install.packages("rversions")
#install_github("amplab-extras/SparkR-pkg", subdir="pkg")
installDict(file.choose(),"honglou1")
installDict(file.choose(),"honglou2")
installDict(file.choose(),"honglou3")
installDict(file.choose(),"honglou4")
z=list("朝辞白帝彩云间千里江陵一日还 两岸猿声啼不住 轻舟已过万重山",
    "白发三千丈 缘愁似个长 不知明镜里何处得秋霜",
    "白日依山尽,黄河入海流欲穷千里目 更上一层楼",
    "君不见黄河之水天上来 奔流到海不复回 君不见高堂明镜悲白发 朝如青丝暮成雪",
    "天门中断楚江开 碧水东流至此回
    两岸青山相对出 孤帆一片日边来","北国风光 千里冰封 万里雪飘")
class(z)
tests=unlist(sapply(z,segmentCN))
test=lapply(X=tests,FUN=strsplit," ")
test
View(test)
testTable=table(unlist(test))
#sort
testTable=rev(sort(testTable))
# table 转换成  dataframe
names(testTable)
#df=data.frame(词汇=names(testTable),词频=testTable)
df=data.frame(testTable)
#wordcloud(df$Var1,df$freq,random.color = TRUE,random.order = TRUE)
df
wordcloud2(df)
View(testTable)
testTable[2]
class(testTable)
      
########
honglou1=file.choose()
lecture1=read.csv(honglou1, fileEncoding="UTF-8",stringsAsFactors = FALSE,header=FALSE)
res1=lecture1[]
# words 每一行的分词结果  但是  类型是 character
words=unlist(lapply(X=res1,FUN=segmentCN))
htest=segmentCN(file.choose(),returnType = tm)
class(htest)
head(htest)
class(words)
word=unlist(lapply(X=words,FUN=strsplit,' '))
class(word)
hTable=table(words)
hdf=data.frame(hTable)
hdf=subset(hdf,nchar(as.character(hdf$words))>1& hdf$Freq>100)
hdf
wordcloud2(hdf,shape = "diamond")


res2=read.csv(file.choose(),fileEncoding ="UTF-8", stringsAsFactors = FALSE,header = FALSE)[]
 
words2=unlist(lapply(X=res2,FUN=segmentCN))
hdf2=data.frame(words2)
hdf=data.frame(table(words2))
hdf=subset(hdf,nchar(as.character(hdf$words2))>1& hdf$Freq>100)
wordcloud2(hdf)
hdf
