# color
#有点混乱  vector  下表访问 从1 开始  这里又从 0 开始  
#从 显示 来看   颜色是一个   三维数组  分别代表rgb

pal=colorRamp(c("red","blue"))
pal(0)
pal(1)
pal(seq(0,1,len=10)) # 从红色到蓝色 等间距取10个颜色 
pal=colorRampPalette(c("red","blue"))
pal(1)
pal(3)
brewer.pal.info
display.brewer.all()
cols=brewer.pal(3,"Greens")
pal=colorRampPalette(cols)
pal(10)
display.brewer.pal(20,"Greens")
image(volcano,col=pal(20))
#  图形设备  两种 
# 电脑屏幕  和文件设备   
pdf(file="myfig.pdf")
with(airquality,plot(Wind,Temp,main = "这个是标题"))

dev.off()

# 探索性绘图原则   
# 突出比较  和谁比较 
# 凸显机制 因果 机制  解释 
# 凸显多元性   逃离扁平  多余两个变量  
#  整合证据  文字数字图标 用多种方式显示  不要让工具主宰分析
# 适当使用图标   尺度  完备性 
#
#内容是王道  
# 