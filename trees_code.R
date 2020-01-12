library(rpart)
model=rpart(q28suicideAttempt~.,train,method = 'class',control = rpart.control(cp=0,maxdepth = 9,minsplit = 1000))
rpart.plot::rpart.plot(model)
printcp(model)
plotcp(model)

#splits are optimised at cp=0
cp= model$cptable[which.min(model$cptable[,"xerror"]),"CP"]
ptree<- prune(model,cp,minsplit = 1000)
rpart.plot::rpart.plot(ptree, uniform=TRUE,main="Pruned Classification Tree")


ptree.pred=predict(model,test,type = 'class')
table(ptree.pred,test$q28suicideAttempt)
mean(ptree.pred==test$q28suicideAttempt)



library(randomForest)
#bagging model where all the predictors are used 
set.seed(300)
bag.q28suicideAttempt=randomForest(q28suicideAttempt~.,data = train,mtry=21,importance=TRUE,ntree=500)
#error plot for number of trees
plot(bag.q28suicideAttempt,type = 'l',main='errorrate')

#prediction
yhat.bag = predict(bag.q28suicideAttempt ,newdata=test)
table(yhat.bag,test$q28suicideAttempt)
mean(yhat.bag==test$q28suicideAttempt)

#selecting sqrt(predictors) as it is a classification problem
rf=randomForest(q28suicideAttempt~.,data = train,mtry=5,importance=TRUE,ntree=200)
plot(rf,type = 'l',main='errorrate')
varImpPlot(rf,main = 'randomforest')

#prediction
yhat.rf= predict(rf,newdata=test)
table(yhat.rf,test$q28suicideAttempt)
mean(yhat.rf==test$q28suicideAttempt)




