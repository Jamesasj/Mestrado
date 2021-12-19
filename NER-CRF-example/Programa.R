# install.packages("crfsuite")
# install.packages("data.table")
library(crfsuite)
library(data.table)

x <- ner_download_modeldata("wikiner-pt-wp3")

x <- as.data.table(x)
x <- x[, pos_previous   := shift(pos,   n = 1, type =  "lag"), by = list(doc_id)]
x <- x[, pos_next       := shift(pos,   n = 1, type = "lead"), by = list(doc_id)]
x <- x[, token_previous := shift(token, n = 1, type =  "lag"), by = list(doc_id)]
x <- x[, token_next     := shift(token, n = 1, type = "lead"), by = list(doc_id)]

subset(x, doc_id == 350, select = c("doc_id", "token", "token_previous", "token_next"))
x$label[x$label == "B-PER"] = "B_PESSOA"
x$label[x$label == "I-PER"] = "I_PESSOA"
crf_train <- subset(x)
crf_test <- subset(x, doc_id == 1)

# method = c("lbfgs", "l2sgd", "averaged-perceptron", "passive-aggressive", "arow")
model <- crf(y = crf_train$label, 
             x = crf_train[, c("pos", "pos_previous", "pos_next","token", "token_previous", "token_next")], 
             group = crf_train$doc_id, 
             method = "lbfgs", file = "tagger.crfsuite",
             options = list(max_iterations = 500, feature.minfreq = 5, c1 = 0, c2 = 1)) 

model
stats <- summary(model, "modeldetails.txt")
stats
plot(stats$iterations$loss)

scores <- predict(model,
                  newdata = crf_test[, c("pos", "pos_previous", "pos_next","token", "token_previous", "token_next")],
                  group = crf_test$doc_id)


crf_test$score <- scores$label
View(crf_test[,c('token','label','score')])
