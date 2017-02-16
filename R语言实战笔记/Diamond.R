#基于R语言钻石价格预测
library(ggplot2)
#dataset 名称由   diamond 改为 diamonds
 head(diamonds)
 # 构件数据  将原有的一个数据集按照比例拆分成两个 
 sample_data=sample(2,nrow(diamonds),replace = TRUE,prob=c(0.7,0.3))
 trail_data=diamonds[sample_data==1,] #训练数据 
 test_data=diamonds[sample_data==2,] # 测试数据
 # 首先获取统计性数据描述 
 summary(trail_data)
 # 以下代码绘制出关于钻石深度的一个分布  
 library(car)
 par(mfrow=c(1,2))
 hist(trail_data$depth,prob=T,xlab="钻石高度")
 lines(density((trail_data$depth)))
 # qqplot  用于直观验证一组数据是否来自某个分布
 # 或者验证两个数据是否来自同一分布  
 #通常用于验证是否为正态分布
qqPlot( test_data$depth)
#根据  柱状图得出深度为62的钻石最多  符合一个类似的正态分布  
# 但是从qqplot 来看 是不符合正态分布的   因为是一条曲线而不是一条直线
# 深度上不遵循正态分布  下面测试  在颜色上的区别
#使用箱行图
library(lattice)
bwplot(depth~color, data=trail_data,ylab = "深度",xlab="颜色等级")
#发现各个颜色上钻石的深度差异并不是很大 
# 处理缺失值
# 我们想要知道各个变量之间的关系到底是怎样的   我们有个叫cor的函数可以肌酸各个变量之间的关系系数  并生成一个关系系数矩阵 
cor(trail_data[,-c(2,3,4)],use="everything") # 这里剔除了三个名义变, 量(切工  颜色  深度 )
#   优化输出  使用  symnum  方法  
symnum(cor(trail_data[c(1,5,6,7,8,9,10)]))
#   预测有两个模型  回归模型和随机森林   
# 回归模型 包括 多元线性回归和回归决策树
# 首先采用 多元线性回归分析
lm_model=lm(price~., data=trail_data)
summary(lm_model)
#   多元线性回归分析  完毕  接下来是回归树 
# 导入 rpart 包
library(rpart)
library(cluster)
tree_model=rpart(price~.,data=trail_data)
#要想对模型进行可视化 需要导入另外的包
library(maptree)
draw.tree(tree_model)
# 防止过度拟合   要对模型进行剪枝 
rsq.rpart(tree_model)
#这时我们要选择合适的cp值  来构建复杂性和效果性达到一个平衡点   选择plotcp
# 函数帮助我们选择cp值  根据下图  选择cp=0.1 的时候最佳
plotcp(tree_model)

#通过prune 函数对初始模型进行剪枝
tree_model2=prune(tree_model,cp=0.1)
#  该方法不完整   要从网上摘取其他教程
library(randomForest)
test=head(trail_data,10000)
#随机森林
m =ncol(trail_data)
 
for (i in 1:(m-1)){
  test_model <- randomForest(price~.,data=trail_data,mtry=i,importance=TRUE, proximity=TRUE)
  mse <- mean(test_model$mse)
  print(mse)
}
 