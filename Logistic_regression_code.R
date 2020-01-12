#logistic regression using glm
glm.fit=glm(q28suicideAttempt~.,data = train,family = binomial)
n=0.65
#response prediction
glm.predict=predict(glm.fit,test,type="response")
#link function prediction
glm_link_scores <- predict(glm.fit, test, type="link")
#logit scores
score_data <- data.frame(link=glm_link_scores, 
                         response=glm.predict,
                         q28=test$q28suicideAttempt,
                         stringsAsFactors=FALSE)

#logistic fit curve
library(ggplot2)
score_data %>% 
  ggplot(aes(x=link, y=response, col=q28)) + 
  scale_color_manual(values=c("black", "red")) + 
  geom_point() + 
  geom_rug() + 
  ggtitle("Both link and response scores put cases in the same order")


#ROC plot
library(pROC)
plot(roc(test$q28suicideAttempt, glm.predict),print.auc=TRUE,
     col="red", lwd=3, main="ROC curve")
 

glm.predict=ifelse(glm.predict>n,"1","0")
table(glm.predict,test$q28suicideAttempt)
errorRate1=mean(glm.predict1==test$q28suicideAttempt)
sprintf("Error rate when threshold is %f : %f" ,0.5,errorRate)

#best fit using backward selection
library(MASS)
stepAIC(glm.fit, direction = 'backward')

summary(glm.fit)

#best model by AIC 
glm(formula = q28suicideAttempt ~ grade + sex + q8seatBelt + 
      q12weaponCarrying + q13weaponsInSchool + q15feelUnsafeAtSchool + 
      q16threatenedAtSchool + q17physicalFight + q19forcedSex + 
      q25hopeless + q32smokingDays + q41drinkingAge + q49severeDrugs + 
      q65pregPrevention + q68weightPercep + q89grades, family = binomial, 
    data = train)
