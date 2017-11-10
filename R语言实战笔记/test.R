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
