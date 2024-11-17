library(here)
here::i_am("code/02_graphical_analysis.R")

data <- read.csv(
  file=here::here("data/all_data.csv")
)

library(ggplot2)

fig1=ggplot(data, aes(x = age, color = factor(sex), fill = factor(sex))) +
  geom_density(alpha = 0.4) +
  labs(x = "Age", y = "Density", title = "Age Density Distribution by Sex") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "pink")) +  
  scale_color_manual(values = c("blue", "pink"))   

ggplot2::ggsave(
  fig1, 
  file = here::here("output/graphical_analysis_fig1.png")
)

fig2=ggplot(data, aes(x = factor(classification), y = age, fill = factor(sex))) +
  geom_boxplot() +
  labs(x = "Classification", y = "Age", 
       title = "Age Distribution by Classification and Sex") +
  theme_minimal()

ggplot2::ggsave(
  fig2, 
  file = here::here("output/graphical_analysis_fig2.png")
)

fig3=ggplot(data, aes(x = CLASIFICATION_FINAL, fill = OBESITY)) +
  geom_bar() +
  labs(
    title = "Stacked Bar Chart of Obesity and Classification",
    x = "CLASIFICATION_FINAL",
    y = "count",
    fill = "OBESITY"
  ) +
  theme_minimal()

ggplot2::ggsave(
  fig3, 
  file = here::here("output/graphical_analysis_fig3.png")
)

