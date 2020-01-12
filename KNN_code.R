library(caret)
##KNN classification
set.seed (2)
n=nrow(df)*0.8
sample=sample(nrow(df),n )
train=df[sample, ]
test=df[-sample,]


default_knn_mod = train(
  q28suicideAttempt ~ .,
  data = train,
  method = "knn",
  trControl = trainControl(method = "cv", number = 5),
  tuneGrid = expand.grid(k = seq(1,40, by = 2))
)

default_knn_mod
plot(default_knn_mod)


head(default_knn_mod$results, 5)

knnPredict <- predict(default_knn_mod,newdata = test)
#Get the confusion matrix to see accuracy value and other parameter values
confusionMatrix(knnPredict,test$q28suicideAttempt)



