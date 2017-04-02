#Rattle 
library(rattle)
library(e1071)
rattle()
data()
x=rnorm(100)
y=rnorm(100)
z=rnorm(100)
df=data.frame(x,y,z)
df

# svm  STUDY  
data(cats,package="MASS")
inputData=data.frame(cats[,c(2,3)],response=as.factor(cats$Sex))
inputData
cats
#liear SVM
svmfit=svm(response~., data=inputData,kernel="linear",cost=10,scale=FALSE)
print(svmfit)
plot(svmfit,data = inputData)
compareTable=table(inputData$response,predict(svmfit))
mean(inputData$response!=predict(svmfit))

svmfit2=svm(response~.,data=inputData,kernel="radial",cost=10,scale=FALSE)
print(svmfit2)
plot(svmfit2,data = inputData)

### Tuning
# Prepare training and test data
set.seed(100) # for reproducing results
rowIndices <- 1 : nrow(inputData) # prepare row indices
sampleSize <- 0.8 * length(rowIndices) # training sample size
trainingRows <- sample (rowIndices, sampleSize) # random sampling
trainingData <- inputData[trainingRows, ] # training data
testData <- inputData[-trainingRows, ] # test data
tuned <- tune.svm(response ~., data = trainingData, gamma = 10^(-6:-1), cost = 10^(1:2)) # tune
summary (tuned) # to select best gamma and cost
sam=sample(2,nrow(inputData),replace = TRUE,prob=c(0.85,0.15))
train_data=inputData[sam==1,]
test_data=inputData[sam==2,]
tuned2=tune.svm(response~., data=inputData,gamma = 10^(-6:-1), cost = 10^(1:2),scale=FALSE)
summary(tuned2)
svmfit3=svm(response~., data = train_data,kerneal="radial",cost=100,gamma=0.01,scale = FALSE)
comparetable2=table(test_data$response,predict(svmfit3,test_data))
mean(test_data$response!=predict(svmfit3,test_data))
plot(svmfit3,inputData)
table(test_data$response,predict(svmfit3,test_data))
 
