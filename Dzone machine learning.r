summary(iris)
head(iris)
# prepare trrain and test dataset
testidx <- which(1:length(iris[,1])%%5 == 0)
 iristrain <- iris[-testidx,]
 iristest <- iris[testidx,]
library(car)
library(ranger)
summary(Prestige)
head(Prestige)

table(Prestige$type)

#  1  linear regression
lm1=lm(prestige~.,data=prestige_train)
summary(lm1)
steplm1=step(lm1)
lm2=lm(prestige~ log10(income*education)+type+women+census,data=prestige_train)
summary(lm2)  # 83.88
summary(step(lm2))#854.99
#??? cannot use =
# lm3=lm(prestige= log10(income*education)~.,data=prestige_train)
# summary(lm3)  #88.75
# summary(step(lm3)) #89.02

lm4=lm(I(prestige)^(1/2)~ log10(income*education)+type* women*census, data=prestige_train)
summary(lm4)  # 83.88
summary(step(lm4))#854.99

par(mfrow=c(2,2))
plot(lm1)
# better than plot()
qqPlot(lm1) # fail
crPlots(lm4)
vif(lm4) 
ncvTest(lm4)  #fail  
spreadLevelPlot(lm4)
outlierTest(lm4)
hatvalues(lm1)
cooks.distance(lm4)
influencePlot(lm1)
with(Prestige,{
  plot(women~type+women*census,type="l",col=2)
})

p1=predict(lm1,newdata = prestige_test)
p2=predict(lm2,newdata = prestige_test)
p3=predict(lm3,newdata = prestige_test) 
p4=predict(lm4,newdata = prestige_test) 
par(mfrow=c(3,1))
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 1 ")
  points(p1,col=3,type="l")
})
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 2")
  points(p2,col=3,type="l")
})
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 4")
  points(p4^2,col=3,type="l")
})
plot(p2,type="l",col=2)
View(p2)
# 
# fm1 <- ranger(prestige ~ ., data = prestige_train, write.forest = TRUE)
# p4 <- predict(fm1, data =prestige_test, interval = "prediction",level = .95)

# 2   logic regression is used to classification  prediction  both  powerful than lm

newcol=data.frame(isSetosa=(iristrain$Species=='setosa'))
traindata=cbind(iristrain,newcol)
head(traindata)


#increase the iterate times to cover the first waring

gm2=glm(prestige~.,data=prestige_train,family="gaussian")
spreadLevelPlot(gm2)
p6=predict(gm2,newdata = prestige_test,type="response")
 
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 6 ")
  points(p6,col=3,type="l")
})

gm3=glm(I(prestige)^(1/2)~ log10(income*education)+type* women*census, data=prestige_train)
p7=predict(gm3,newdata = prestige_test)
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 7 ")
  points(p7^2,col=3,type="l")
})
outlierTest(gm3)
ncvTest(gm3)
#1: glm.fit: algorithm did not converge
formula=isSetosa~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width
gm1=glm(formula,data=traindata,family = binomial(link = "logit"),control = list(maxit = 50))
p5=predict(gm1,newdata=iristest, type="response")
summary(gm1)
round(p5,3)

plot(p5,type="l",col=2)



# 3  reguression with regularization  to avoid overfitting   user ridge regression. 
# so powerful!!! better than my trained lm 
library(glmnet)
cv.fit <- cv.glmnet(as.matrix(prestige_train[,c(-4, -6)]), as.vector(prestige_train[,4]), nlambda=100, alpha=0.7, family="gaussian")
plot(cv.fit)
coef(cv.fit)
p6 <- predict(cv.fit, newx=as.matrix(prestige_test[,c(-4, -6)]))
cor(prediction, as.vector(prestige_test[,4]))
with(prestige_test,{
  plot(prestige,type="l",main=" predict with model 6 ")
  points(p6,col=3,type="l")
})

#4  neural network  good at non-linear  and predict multiple at same time.


library(neuralnet)
 nnet_iristrain <-iristrain
 #Binarize the categorical output
   nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'setosa')
 nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'versicolor')
 nnet_iristrain <- cbind(nnet_iristrain, iristrain$Species == 'virginica')
 names(nnet_iristrain)[6] <- 'setosa'
 names(nnet_iristrain)[7] <- 'versicolor'
 names(nnet_iristrain)[8] <- 'virginica'
 nn <- neuralnet(setosa+versicolor+virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=nnet_iristrain, hidden=c(3))
 plot(nn)
 mypredict <- compute(nn, iristest[-5])$net.result
 # Consolidate multiple binary output back to categorical output
   maxidx <- function(arr) {
       return(which(arr == max(arr)))
     }
 idx <- apply(mypredict, c(1), maxidx)
 prediction <- c('setosa', 'versicolor', 'virginica')[idx]
 table(prediction, iristest$Species)
 

# 5   Support Vector Machine

 library(e1071)
   tune <- tune.svm(Species~., data=iristrain, gamma=10^(-6:-1), cost=10^(1:4))
   summary(tune)
 
   model <- svm(Species~., data=iristrain, method="C-classification", kernel="radial", probability=T, gamma=0.001, cost=10000)
  prediction <- predict(model, iristest, probability=T)
   table(iristest$Species, prediction)

# 6 Bayesian Network and Na�ve Bayes
   
   model <- naiveBayes(Species~., data=iristrain)
   prediction <- predict(model, iristest[,-5])
     table(prediction, iristest[,5])
     
     
#7  K-Nearest Neighbors
     
     library(class)
      train_input <- as.matrix(iristrain[,-5])
      train_output <- as.vector(iristrain[,5])
      test_input <- as.matrix(iristest[,-5])
      prediction <- knn(train_input, test_input, train_output, k=5)
      table(prediction, iristest$Species)
      
    #8 Decision Tree
      
      library(rpart)
       #Train the decision tree
         treemodel <- rpart(Species~., data=iristrain)
       plot(treemodel)
       text(treemodel, use.n=T,all=TRUE)
       #Predict using the decision tree
         prediction <- predict(treemodel, newdata=iristest, type='class')
       #Use contingency table to see how accurate it is
         table(prediction, iristest$Species)
#9 random forest
         
         
         library(randomForest)
         #Train 100 trees, random selected attributes
          model <- randomForest(Species~., data=iristrain, nTree=500)
         #Predict using the forest
          prediction <- predict(model, newdata=iristest, type='class')
          table(prediction, iristest$Species)
          importance(model)
      
          library(gbm)
           iris2 <- iris
           newcol = data.frame(isVersicolor=(iris2$Species=='versicolor'))
           iris2 <- cbind(iris2, newcol)
           iris2[45:55,]
           formula <- isVersicolor ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
          model <- gbm(formula, data=iris2, n.trees=1000, interaction.depth=2, distribution="bernoulli")
          prediction <- predict.gbm(model, iris2[45:55,], type="response", n.trees=1000)
            round(prediction, 3)
            summary(model)
          
