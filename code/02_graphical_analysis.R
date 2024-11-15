here::i_am("02_graphical_analysis.R")

library(ggplot2)
fig3=ggplot(data=xy,aes(x=children,fill=sex))+geom_histogram(alpha=0.8,position = "dodge",bins = 10)+ggtitle("Fig.3 Distribution plot of the number of children by gender.")+theme(plot.title = element_text(hjust = 0.5))+ 
  labs(x = "Number of children/dependents", y = "Count")

ggplot2::ggsave(
  fig3, 
  file = here::here("output/fig1.png")
)

