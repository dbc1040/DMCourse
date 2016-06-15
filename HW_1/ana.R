algae <- read.table(file = 'Analysis.txt', col.names = c('season','size','speed','mxPH','mnO2','Cl','NO3','NH4','oPO4','PO4','Chla','a1','a2','a3','a4','a5','a6','a7'), na.strings = c('XXXXXXX'))
head(algae)

summary(algae)

hist(algae$mxPH)

par(mfrow=c(1,2))
qq.plot(algae$mxPH,main="Normal QQ plot of maximum pH")

boxplot(algae$oPO4,ylab='oPO4')
rug(algae$oPO4,side=4)
abline(h=mean(algae$oPO4,na.rm=T),lty=2)

algae[!complete.cases(algae), ]

algae <- na.omit(algae)
apply(algae,1,function(x) sum(is.na(x)))

write.table(algae,file = 'Analysis_1.txt',quote=FALSE,sep='\t',row.names =FALSE, col.names = FALSE)

library(DMwR)
algae<-centralImputation(algae)

write.table(algae,file = 'Analysis_2.txt',quote=FALSE,sep='\t',row.names =FALSE, col.names = FALSE)

data(algae)
symnum(cor(algae[,4:18],use='complete.obs'))

data(algae)
algae<-algae[-manyNAs(algae), ]
lm(PO4~oPO4,data = algae)
algae[28,"PO4"] <- 42.897+1.293*algae[28,'oPO4']
algae[28,'PO4']
write.table(algae,file = 'Analysis_3.txt',quote=FALSE,sep='\t',row.names =FALSE, col.names = FALSE)

algae <- read.table(file = 'Analysis.txt', col.names = c('season','size','speed','mxPH','mnO2','Cl','NO3','NH4','oPO4','PO4','Chla','a1','a2','a3','a4','a5','a6','a7'), na.strings = c('XXXXXXX'))
library(DMwR)
algae<-algae[-manyNAs(algae),]
algae<-knnImputation(algae,k=10)
write.table(algae,file = 'Analysis_4.txt',quote=FALSE,sep='\t',row.names =FALSE, col.names = FALSE)
