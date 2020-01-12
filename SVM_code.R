#SVM
library(e1071)
svmfit=svm(q28suicideAttempt ~ .,data=train,kernel='radial',scale=FALSE,cost=0.01)  
summary(svmfit)
#tune.out=tune(svm,q28suicideAttempt ~ .,data=train,kernel='radial', ranges=list(cost=c(0.1,1,10),gamma=c(0.5,1) ))  
#summary(tune.out)
svmpredict=predict(svmfit,test)
table(predict=svmpredict, truth=test$q28suicideAttempt)
mean(svmpredict==test$q28suicideAttempt)

