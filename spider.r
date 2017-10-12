# system.time({
#   library(MASS)
#   result <- kmeans(Boston,4,nstart=100000)
# })
library(snow)
library(parallel)
library(foreach)
library(doParallel)
system.time({
  data(Boston)
  cl <- makeCluster(2,type='SOCK')
  clusterExport(cl,'Boston')
  results <- clusterApply(cl,rep(50000,2),function(nstart) kmeans(Boston,4,nstart=nstart))
  i <- sapply(results,function(result) result$tot.withinss)
  result <- results[[which.min(i)]]
  stopCluster(cl)
})
####
func <- function(x) {
  n = 1
  raw <- x
  while (x > 1) {
    x <- ifelse(x%%2==0,x/2,3*x+1)
    n = n + 1
  }
  return(c(raw,n))
}
func(1e6)
system.time({
  x <- 1:1e6
  cl <- makeCluster(8)  # 初始化四核心集群
  results <- parLapply(cl,x,func) # lapply的并行版本
  res.df <- do.call('rbind',results) # 整合结果
  stopCluster(cl) # 关闭集群
})
# 找到最大的步数对应的数字
res.df[which.max(res.df[,2]),1]
system.time({
  x <- foreach(x=1:2e4,.combine='rbind') %do% func(x)
})
  cl <- makeCluster(8)
  registerDoParallel(cl)
  system.time({
   
  # 并行计算方式
  x <- foreach(x=1:2e4,.combine='rbind') %dopar% func(x)
  
  })
  stopCluster(cl)
cl <- makeCluster(8)
registerDoParallel(cl)
rf <- foreach(ntree=rep(25000, 4), 
              .combine=c,
              .packages='randomForest') %dopar%
  randomForest(Species~., data=iris, ntree=ntree)
stopCluster(cl)
plot(rf)
cl.cores <- detectCores()
cl.cores
