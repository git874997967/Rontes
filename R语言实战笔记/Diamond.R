
#基于R语言钻石价格预测
library(ggplot2)
#dataset 名称由   diamond 改为 diamonds
 head(diamonds)
 # 构件数据  将原有的一个数据集按照比例拆分成两个 
 # sample  样本函数  sample(2,nrow(diamonds),replace=TRUE,prob=(0.7,0.3))
 # 从diamonds 数据集中抽取两个样本样本大小比例为7：3
 
 sample_data=sample(2,nrow(diamonds),replace = TRUE,prob=c(0.7,0.3))
 trail_data=diamonds[sample_data==1,] #训练数据 
 test_data=diamonds[sample_data==2,] # 测试数据
 # 首先获取统计性数据描述 
 summary(trail_data)
 # 以下代码绘制出关于钻石深度的一个分布  
 library(car)
 #par(mfrow=c(1,2))   将两个图并排显示 c(1,2)  意思为  一行两列的图
 
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
# 我们想要知道各个变量之间的关系到底是怎样的  
#我们有个叫cor的函数可以肌酸各个变量之间的关系系数  并生成一个关系系数矩阵 
#cor  关系系数  取值在－1 和1 之间   越接近0越不相关 0时却不意味着 两组数据独
cor(trail_data[,-c(2,3,4)],use="everything") # 这里剔除了三个名义变, 量(切工  颜色  深度 )
#   优化输出  使用  symnum  方法  
symnum(cor(trail_data[c(1,5,6,7,8,9,10)]))
#   预测有两个模型  回归模型和随机森林   
# 回归模型 包括 多元线性回归和回归决策树
# 首先采用 多元线性回归分析
lm_model=lm(price~., data=trail_data)
summary(lm_model)
# 调整后的可决系数高达0.9194，这说明了模型可以解释百分九十一的方差，
#各个变量的显著性也很高，大部分都是三颗星以上的高度显著；先说一下R是怎么处理那三个名义变量的，
#当像上面一样进行建模的时候，R会生成一组辅助变量，对每一个有K个水平的因子变量，R会生成K-1个辅助变量，
#辅助比那辆的值为0或者1，当辅助变量的值为1，表示该因子出现，同时表明其他所有辅助变量值为0，以上结果汇总；
#所以从上图结果我们可以看得出来cut变量生成了cut.l,cut.q,cut.c,cut.4:这4个辅助变量。
#我们要提出那些不相关的变量，一个个剔除确实是有些麻烦，这个时候我们选择通过对初始模型用向后剔除法得到一个新的模型
step_lm_model=step(lm_model)
#上图结果展示，模型的AIC值是下降了，也剔除了变量Y,模型是稍微精简了点，这时候我们在看一下模型的整体结果如何；
summary(step_lm_model)
par(mfrow=c(2,2))
plot(step_lm_model)