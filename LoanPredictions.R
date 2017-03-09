train = read.csv("train.txt", sep = ",", header = T, na.strings = c("", NA))
test = read.csv("test.txt", sep = ",", header = T, na.strings = c("", NA))

summary(train)
str(train)
train$Credit_History = as.factor(train$Credit_History)

summary(test)
str(test)
test$Credit_History = as.factor(test$Credit_History)

train1 = train
train1$Loan_Status = NULL
total = rbind(train1,test)
total$Loan_ID=NULL
rm(train1)
summary(total)

library(missForest)
imputed = missForest(total)
summary(imputed)

totalNew = imputed$ximp
summary(totalNew)

trainNew = totalNew[1:614,]
trainNew$Loan_Status = train$Loan_Status
testNew = totalNew[615:981,]

summary(trainNew)
summary(testNew)

library(randomForest)
forestModel = randomForest(Loan_Status~., data = trainNew, ntree = 200)
pred = predict(forestModel, newdata = testNew)

prediction = as.matrix(test$Loan_ID,367,1)
colnames(prediction) = "Loan_ID"
prediction = as.data.frame(prediction)
prediction$Loan_Status = pred

write.csv(prediction, "submission.csv")
