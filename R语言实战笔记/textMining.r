Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_91') # for 64-bit version
library(rJava)
library(SnowballC)
library(RWeka)
library(tm)
library(Rwordseg)
library(XML)
library(wordcloud)
#install.packages("tm.corpus.Reuters21578", repos = "http://datacube.wu.ac.at")
library(tm.corpus.Reuters21578)
#词干化  和标签化 
wordStem(c("functions","stemming","liked","doing","done",'does','goes'))
NGramTokenizer(' 中华人民共和国 成立 于 1949年')
segmentCN(' 花儿为什么这样红')
 # V动态语料库 在内存中  P静态语料库在外存中
data(Reuters21578)
# 创建语料库
docs=c("this is a text","this is another one")
Corpus(VectorSource(docs))
# 完整版语料库
Reuters21578
reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- Corpus(DirSource(reut21578),readerControl = list(reader = readReut21578XML,language="en"))
#inspect(reuters[1:2])
#inspect(Reuters21578[1:3])
#identical(reuters[[2]],reuters[["reuters_2.txt"]])
data('crude')
# ??? as.PlainTextDocument not found
#转化纯文本
retuers=tm_map(reuters,as.PlainTextDocument)
# 取出空白
retuers_Plain=tm_map(reuters,stripWhitespace)
# 小写变化
retuers_Plain=tm_map(retuers_Plain,tolower)
# 去除停止词
retuers_Plain=tm_map(retuers_Plain,removeWords,stopwords("english"))
# 填充 
 tm_map(retuers_Plain,stemDocument)
# 过滤
 tm_filter(retuers_Plain,FUN=searchFullText,pattern="company")
 tm_filter(reuters, FUN = sFilter, "company")
 tm_filter(crude, FUN = function(x) any(grep("co[m]?pany", content(x))))
#dataframe=data.frame(text=unlist(sapply(crude,'[',"content")),stringsAsFactors = FALSE)
#dataframe[1]$text
 # 元数据管理 为了标记语料库的附加信息 
crude[[1]]$content
DublinCore(crude[[1]])
meta(crude[[1]])
meta(crude,type = "corpus")
# 创建文档关系矩阵
dtm=TermDocumentMatrix(retuers_Plain)
inspect(dtm[1:5,100:105])
#字典  是字符集的集合  Dictionary()已经被废除
myTerms <- c("some", "opec", "price","reuter","oil")
inspect(DocumentTermMatrix(crude, list(dictionary = myTerms)))

# 处理网页数据
fileName <- system.file("exampleData", "include.xml", package="XML")
root=xmlParse(fileName)
test=getNodeSet(root,"//para")
vdata=sapply(test,xmlValue)
vdata
###
fileName1=file.choose()
#fileName1 <- system.file("exampleData", "book.xml", package="XML")
root1=xmlParse(fileName1)
test1=getNodeSet(root1,"//tr//div")
vdata1=sapply(test1,xmlValue)
vdata1
findFreqTerms(DocumentTermMatrix(crude))
wordcloud(Reuters21578,random.order=FALSE,random.color=TRUE)

# 文本聚类分析 
data(acq,crude)
m=c(acq,crude)
dtm=DocumentTermMatrix(m)
dtm=removeSparseTerms(dtm,0.8)
inspect(dtm[1:5, 1:5])
class(dtm)
dist_dtm <- dissimilarity(dtm, method ='cosine')
hc <- hclust(dist_dtm, method = 'ave')
plot(hc, xlab = '')