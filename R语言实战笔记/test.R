library(lubridate) 
library(stringr)
library(editrules)
library(deducorrect)
######data cleaning
 # type checking   normalizing
 # fix and impute
 # estimate analyze derive
# store the input for each stage and each steps could store as
# a seprete R script
(1:4)*c(1,3)
### 1:1 2*3 3*1 4*3
x <- 1:10

x[c(TRUE, FALSE)] <- 1
####odd index of number will be selected and given a new value 1 
x[c(T,F)]
capColor = c(huey = "red", duey = "blue", louie = "green")
L <- list(x = c(1:5), y = c("a", "b", "c"), z = capColor)
L[[2]]
L$y
L[c(1, 3)]
L[c("x", "y")]
L[["z"]]
d <- data.frame(x = 1:10, y = letters[1:10], z = LETTERS[1:10])
d[1]
d[, 1]
d[, "x", drop = FALSE]
### take x z as column 
d[ c("x", "z")]
###choice rownumber where x>3 and y column
d[d$x > 3, "y", drop = F]
d[2, ]
### special numbers in the numberic  
# NA NULL NaN and inf
NA + 1
sum(c(NA, 1, 2))
median(c(NA, 1, 2, 3), na.rm = TRUE)
length(c(NA, 2, 3, 4))
3 == NA
NA == NA
TRUE | NA
##Null
# Null means empty no value and no space.
length(c(1, 2, NULL, 4))
sum(c(1, 2, NULL, 4))
x <- NULL
c(x, 2)
#Inf
pi/0
2 * Inf
Inf - 1e+10
Inf + Inf
3 < -Inf
Inf == Inf
#NaN
NaN + 1
exp(NaN)
##
 exp(-Inf)
NA == NA
 NA == NULL
 NULL == NULL
 NA & FALSE
 txt=readLines(file.choose(),encoding = 'UTF-8')
 ### first regp the txt
 I=grepl('^%',txt)
I
data=txt[!I]
data
fieldList=strsplit(data,split=',')
fieldList
assignFields=function(x){
  out=character(3)
  #get names
  i=grepl('[[:alpha:]]',x)
  out[1]=x[i]
    i=which(as.numeric(x)<1890)
    out[2]=ifelse(length(i)>0,x[i],NA)
    i=which(as.numeric(x)>1890)
    out[3]=ifelse(length(i)>0,x[i],NA)
  out
}
data2=assignFields(fieldList[3])
data2
##lapply  first params second function 
###lapply treat first element as a list, get value from each row and combin them back 

standardFields <- lapply(fieldList, assignFields)
standardFields
 
M=matrix( unlist(standardFields),nrow=length(standardFields),byrow=F)
###matrix  default byrow
M2=matrix(unlist(standardFields),nrow=length(standardFields),byrow=T)
colnames(M2)=c('name','birth','dead')
M3=data.frame(M2,stringsAsFactors = F)
M3=transform(M3,birth=as.numeric(birth),
             dead=as.numeric(dead))
M3
as.numeric(c("7", "7*", "7.0", "7,0"))
gender=c(2,1,1,0,2,0,1,1)
recode=c(other=0,male=1,female=2)
names(recode)
genderF=factor(gender,levels=recode,labels=names(recode))
genderF
current_time=Sys.time()
class(current_time)
Sys.timezone()
dates= c("15/02/2013", "15 Feb 13", "It happened on 15 02 '13")
dmy(dates)
dmy("15 Febr. 2013")
dates='28-02-2011'
as.POSIXct(dates,format='%d-%m-%Y')
gender
 
GenderEx=c('M ','male ','FEMALE','Fem.','male')
GenderEx1=str_trim(GenderEx)
GenderEx2=str_to_lower(GenderEx1)
codes=c('male','female')
Data=adist(GenderEx2,codes)
colnames(Data)=codes
rownames(Data)=GenderEx2
i=apply(Data,1,which.min)
data.frame(final=codes[i])
#Sys.getlocale("LC_CTYPE")
v <- factor(c("2", "3", "5", "7", "11",'44546'))
v1=as.character(v)
v2=as.numeric(v)
v3=strtoi(v)
class(v3) 
class(v3[5])
exer=readLines(file.choose(),encoding = 'utf-8')
commont=grepl("^/",exer)
commonts=exer[commont]
info=exer[!commont]
 str_trim(info)
info=str_to_lower(info) 
info[2]=paste(info[2],'NA')
infoList=strsplit(info,';')
infoList 
infom=matrix(unlist(infoList),byrow=T,ncol=3)
df=data.frame(infom)
colname=c('gender','age','weight')
colnames(df)=colname
df
dis=adist(df$gender,codes)
dis
i=apply(dis,1,which.min)
i
df$gender=codes[i]
str(df)
df$age=as.numeric(df$age)
#### next part process to the consistent data
# 1 detection of an inconsistency 
age=c(23,21,NA)
mean(age)
mean(age,na.rm=T)
x <- c(1:10, 20, 30)
boxplot.stats(x)
x
data=read.csv(file.choose(),encoding = 'utf-8')
class(data)
## use editrules to set check rules
(E <- editset(c("age >=0", "age <= 150","yearsmarried >=0", "yearsmarried <= 50")))
F=editfile(file.choose())
F
ve=violatedEdits(F,data)
data[1,]$status %in% c('married','single','widowed')
summary(ve)
plot(F)
id=c(2,5)
data[id,]
violatedEdits(F,data[id,])
le=localizeErrors(F,data[id,],method='mip')
le$adapt
data[2, "status"] <- "single"
data[5, "height"] <- 7
data[5, "agegroup"] <- "adult"
summary(violatedEdits(E, data[id, ]))
#####  unifiy the height
marx=read.csv(file.choose(),sep=' ')
marx_m=marx
I ='cm'
marx_m[I,'height']=marx$height[I]/100
marx_m
###########dedu correct 
G=editmatrix(expression(
  staff+cleaning+housing==total,
  staff>=0,
  housing>=0,
  cleaning>=0
))
dat=data.frame(
  staff=c(100,100,100),
  housing=c(NA,50,NA),
  cleaning=c(NA,NA,NA),
  total=c(100,180,NA)
)
str(dat)
cor=deduImpute(G,dat)
cor$corrected
