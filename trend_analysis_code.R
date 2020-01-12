#Exploratory dfNationaFinal analysis
library(dplyr)
YearSuicide<-dfNationaFinal %>%dplyr:: select(year,q26,q27)
unique(dfNationaFinal$year)

library(ggplot2)
###Year vs Ideation plot
n=sum(is.na(YearSuicide$q26))
YearSuicide=na.omit(YearSuicide)
YearSuicideMetadfNationaFinal=YearSuicide %>%dplyr:: filter(q26 == 1)%>%
  group_by(year) %>%
  count(q26)
p = ggplot() + 
  geom_line(data = YearSuicideMetadfNationaFinal, aes(x = year, y = n), color = "red") +
  xlab('Year') +
  ylab('Suicide ideation')+geom_smooth(method = "lm")
print(p)

###gender vs idearion plot
genderSuicide<-dfNationaFinal %>% dplyr:: select(year,q26,q27,sex)
genderSuicideMetadfNationaFinal=genderSuicide %>% 
  group_by(year,sex) %>%filter(q26 == 1)%>%
  count(q26)
genderSuicideMetadfNationaFinal=na.omit(genderSuicideMetadfNationaFinal)
genderSuicideMetadfNationaFinal$sex=as.factor(genderSuicideMetadfNationaFinal$sex)
ggplot(data =genderSuicideMetadfNationaFinal, aes(x=year, y=n, group=sex, color=sex))+ 
  geom_line() + 
  geom_point()+
  scale_color_manual(values = c("red", "blue"),
                     labels = c("Male","Female"))


####age vs ideation plot
ageSuicide<-dfNationaFinal %>% select(year,q26,sex,age)
ageSuicideMetadfNationaFinal=ageSuicide %>% 
  group_by(year,sex,age) %>%filter(q26 == 1)%>%
  count(q26)
ageSuicideMetadfNationaFinal=na.omit(ageSuicideMetadfNationaFinal)
maleSuicideAge=ageSuicideMetadfNationaFinal%>%filter(sex==1)
femaleSuicideAge=ageSuicideMetadfNationaFinal%>%filter(sex==2)
maleSuicideAge$age=as.factor(maleSuicideAge$age)
femaleSuicideAge$age=as.factor(femaleSuicideAge$age)

ggplot(data = maleSuicideAge, aes(x=year, y=n, group=age, color=age))+ 
  geom_line() +
  ylab("Suicide Ideation")+ labs(title = "Male Suicide Ideation Over the Years")+
  geom_point()+
  scale_color_manual(values = c("red", "blue","orange","purple","green","yellow","black"),
                     labels = c("12 or below","13 years","14 years","15 years","16 years","17 years","18 years or older"))

ggplot(data =femaleSuicideAge, aes(x=year, y=n, group=age, color=age))+ 
  geom_line() + ylab("Suicide Ideation")+
  geom_point()+labs(title = "Female Suicide Ideation Over the Years")+
  scale_color_manual(values = c("red", "blue","orange","purple","green","yellow","black"),
                     labels = c("12 or below","13 years","14 years","15 years","16 years","17 years","18 years or older"))





