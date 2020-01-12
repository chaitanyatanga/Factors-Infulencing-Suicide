
#boosting model
library(gbm)
trainMeta=train
trainMeta$q28suicideAttempt=ifelse(trainMeta$q28suicideAttempt=='Yes',1,0)
#trainMeta$q28suicideAttempt=as.factor(trainMeta$q28suicideAttempt)
testMeta=test
testMeta$q28suicideAttempt=ifelse(testMeta$q28suicideAttempt=='Yes',1,0)
boost.q28suicideAttempt=gbm(q28suicideAttempt~.,data=trainMeta,distribution="bernoulli",n.trees=5000, interaction.depth=4,cv.folds = 10)
summary(boost.q28suicideAttempt)
#accuracy is 0.7702
#choosing best models
ntreeCV=gbm.perf(boost.q28suicideAttempt,method = "cv")
ntreeOOB=gbm.perf(boost.q28suicideAttempt,method = "OOB")
#best model is when ntrees=200 and lambda=0.01
boost.q28suicideAttempt1=gbm(q28suicideAttempt~.,data=trainMeta,distribution="bernoulli",n.trees=200, interaction.depth=4)
summary(boost.q28suicideAttempt1)
#ntress control has increased the accuracy
#predicting using boosting 
yhat.boost=predict(boost.q28suicideAttempt1,testMeta,n.trees=200,type = 'response')
yhat.boost_factor=as.factor(ifelse(yhat.boost>0.5,1,0))
testMeta$q28suicideAttempt=as.factor(testMeta$q28suicideAttempt)
library(caret)
confusionMatrix(yhat.boost_factor,testMeta$q28suicideAttempt)

#ROC curve
library(ROCR)
plot(roc(test$q28suicideAttempt,yhat.boost),print.auc=TRUE,
     col="red", lwd=3, main="ROC curve")


