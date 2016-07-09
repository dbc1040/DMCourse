library(arules)
require(arules)
setwd("D:\Program Files\python3\data mining\code")
mydata=read.csv("pre_data.csv")
#找出频繁项集
frequentsets=eclat(mydata,parameter=list(support=0.2,maxlen=10))
inspect(sort(frequentsets,by="support"))#查看求得的频繁项集
#导出关联规则
rules=apriori(mydata,parameter=list(support=0.2,confidence=0.2))
summary(rules)

subset.matrix<-is.subset(rules,rules)#生成一个所有规则的子集矩阵,行和列分别是每条rules，其中的值是TRUE和FALSE，当rules2是rules1的子集时，rules2在rules1的值为TRUE
subset.matrix[lower.tri(subset.matrix,diag=T)]<-NA#将矩阵对角线以下的元素置为空，只保留上三角
redundant<-colSums(subset.matrix,na.rm=T)>=1#R会将矩阵中的TRUE当做1，统计每列的和（忽略缺失值），如果该列的和大于等于1，也就是表示该列（规则）是别的规则的子集，应该删除。
rules.pruned<-rules[!redundant]#去掉冗余的规则

inspect(sort(rules.pruned,by="support"))
#规则评价
inspect(sort(rules.pruned,by="lift"))
#画出规则分布散点图
plot(rules.pruned)
#矩阵分组
plot(rules.pruned,method="grouped")
#规则关联图
plot(rules.pruned,measure="confidence",method="graph",control=list(type="items"),shading="lift")