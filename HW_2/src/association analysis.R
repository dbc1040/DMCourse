library(arules)
require(arules)
setwd("D:\Program Files\python3\data mining\code")
mydata=read.csv("pre_data.csv")
#�ҳ�Ƶ���
frequentsets=eclat(mydata,parameter=list(support=0.2,maxlen=10))
inspect(sort(frequentsets,by="support"))#�鿴��õ�Ƶ���
#������������
rules=apriori(mydata,parameter=list(support=0.2,confidence=0.2))
summary(rules)

subset.matrix<-is.subset(rules,rules)#����һ�����й�����Ӽ�����,�к��зֱ���ÿ��rules�����е�ֵ��TRUE��FALSE����rules2��rules1���Ӽ�ʱ��rules2��rules1��ֵΪTRUE
subset.matrix[lower.tri(subset.matrix,diag=T)]<-NA#������Խ������µ�Ԫ����Ϊ�գ�ֻ����������
redundant<-colSums(subset.matrix,na.rm=T)>=1#R�Ὣ�����е�TRUE����1��ͳ��ÿ�еĺͣ�����ȱʧֵ����������еĺʹ��ڵ���1��Ҳ���Ǳ�ʾ���У������Ǳ�Ĺ�����Ӽ���Ӧ��ɾ����
rules.pruned<-rules[!redundant]#ȥ������Ĺ���

inspect(sort(rules.pruned,by="support"))
#��������
inspect(sort(rules.pruned,by="lift"))
#��������ֲ�ɢ��ͼ
plot(rules.pruned)
#�������
plot(rules.pruned,method="grouped")
#�������ͼ
plot(rules.pruned,measure="confidence",method="graph",control=list(type="items"),shading="lift")