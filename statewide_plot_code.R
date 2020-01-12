
####state wide ideation plot
library(dplyr)
library(ggplot2)
library(plotly)

Sys.setenv("plotly_username"="chaitu2595")
Sys.setenv("plotly_api_key"="10UKFOU1ssKKL2pDnQic")
q<-ggplot(data=statedfNationaFinalMeta, aes(x=year, y=n, color=sitename))+ 
  geom_line() +
  ylab("Suicide Ideation")+ labs(title = "State Level Suicide Ideation")+
  geom_point()
q <- ggplotly(q)
api_create(q, filename = "Statewide Suicide Ideation over the years")
