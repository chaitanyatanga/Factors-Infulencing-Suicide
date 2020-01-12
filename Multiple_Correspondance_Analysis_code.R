
#Multiple Correspondence Analysis
library("FactoMineR")
library("factoextra")
library(dplyr)
mca=MCA(df, graph = FALSE)

library("factoextra")
#percentage of explained variances
fviz_screeplot(mca, addlabels = TRUE, ylim = c(0, 45))
#dimension 1 vs dimension 2 plot of imporatnce 
fviz_mca_var(mca, choice = "mca.cor", 
             repel = TRUE, # Avoid text overlapping (slow)
             ggtheme = theme_minimal())

# Contributions of rows to dimension 1
fviz_contrib(mca, choice = "var", axes = 1, top = 15)
# Contributions of rows to dimension 2
fviz_contrib(mca, choice = "var", axes = 2, top = 15)
#scattering plot for the points with respect to dim1 and dim 2 explaining the factors Yes and No 
fviz_mca_ind(mca, 
             label = "none", # hide individual labels
             habillage = df$q28suicideAttempt, # color by groups 
             palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, ellipse.type = "confidence",
             ggtheme = theme_minimal()) 
#dim2 is able to  explain more No variance

