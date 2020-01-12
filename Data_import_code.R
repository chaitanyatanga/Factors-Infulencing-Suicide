
#set wd to the loction of file
#state data import
statedfNationaFinalMeta=read.csv('state_EDA_data.csv')
#national data import
nationalData=read.csv('data_EDA.csv')
dfNationaFinal=nationalData
#data importing
df=read.csv("Final_data.csv")
#converting to factors
df[]=lapply(df, as.factor)
#settings levels No=No suicide,Yes=Suicide
levels(df$q28suicideAttempt) <- c('No','Yes')

#train and test split
set.seed (2)
n=nrow(df)*0.8
sample=sample(nrow(df),n )
train=df[sample, ]
test=df[-sample,]