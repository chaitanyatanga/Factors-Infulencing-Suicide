#GoodmanKruskal matrix\
library(dplyr)
library(GoodmanKruskal)
GKmatrix1 <- GKtauDataframe(df%>% dplyr::select(-c(age,grade,q48past30numberOfDrugs,q32smokingDays,q49severeDrugs,q89grades)))
plot(GKmatrix1)

