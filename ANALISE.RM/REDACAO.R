library(dplyr)
features <- read.csv("http://rii.lcad.inf.ufes.br/james/dataset/dataset", sep= " ",header =  F, stringsAsFactors = F)
label <- read.csv("http://rii.lcad.inf.ufes.br/james/dataset/labels_CF1F.txt", header = F, stringsAsFactors = F)
vbin <- rep.int(0, ncol(features))
label[label$V1 == 10, ] = 1.0
#vbin[37:ncol(features)] <- 1
vbin[10]= 1
vbin[11]= 1

features2 <- features[,vbin == 1]
n.lab = 0
while(n.lab != 5){
  vtr <- sample(1:nrow(label), nrow(label)*.75)
  tr.dataset <- features2[vtr,]
  tr.labels <- label[vtr, ]
  n.lab = length(table(tr.labels))
  tr.dataset$label <- tr.labels
}

ts.features <- features2[-vtr, ]
ts.labels <- label[-vtr, ]
model <- lm(formula = label ~ V10, 
   data = tr.dataset)
anv<-anova(model)
plot(tr.dataset$V10, tr.dataset$label, ylab = "Nota(Y)", xlab = "erros ortograficos(Y)")
abline(model)

print(anv$`Sum Sq`[2]) # soma do quadrado dos erros
print(anv$`Mean Sq`[2]) # Variancia residual 
print(sqrt(anv$`Mean Sq`[2]))
print(sqrt(anv$`Mean Sq`[2])*2)
print(res) #resultado predito

#erros gramaticais cogroo
lm(formula = label ~ V11, 
   data = tr.dataset)

model <- lm(formula = label ~ V11, 
            data = tr.dataset)


anv<-anova(model)
plot(tr.dataset$V11, tr.dataset$label, ylab = "Nota(Y)", xlab = "erros gramaticais cogroo(Y)")
abline(model)

print(anv$`Sum Sq`[2]) # soma do quadrado dos erros
print(anv$`Mean Sq`[2]) # Variancia residual 
print(sqrt(anv$`Mean Sq`[2]))
print(sqrt(anv$`Mean Sq`[2])*2)


summary(model)
res <- predict(model, newdata = ts.features)
plot(tr.dataset$V10, tr.dataset$label, pch = 16, cex = 1.3, col = "blue")
abline(model)



#erros gramaticais cogroo
lm(formula = label ~ V11, 
   data = tr.dataset)

model <- lm(formula = label ~ V10 + V11, 
            data = tr.dataset)

anv<-anova(model)
plot(tr.dataset$V11, tr.dataset$label, ylab = "Nota(Y)", xlab = "erros gramaticais cogroo(Y)")
abline(model)

print(anv$`Sum Sq`[2]) # soma do quadrado dos erros
print(anv$`Mean Sq`[2]) # Variancia residual 
print(sqrt(anv$`Mean Sq`[2]))
print(sqrt(anv$`Mean Sq`[2])*2)