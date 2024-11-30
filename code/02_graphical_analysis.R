library(here)
here::i_am("code/02_graphical_analysis.R")

data <- read.csv(
  file=here::here("data/all_data.csv")
)

library(ggplot2)

fig1=ggplot(data, aes(x = AGE, color = factor(SEX), fill = factor(SEX))) +
  geom_density(alpha = 0.4) +
  labs(x = "Age", y = "Density", title = "Age Density Distribution by Sex") +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "pink")) +  
  scale_color_manual(values = c("blue", "pink"))

saveRDS(
  fig1,
  file = here::here("output", "graphical_analysis_fig1.rds")
)


fig2=ggplot(data, aes(x = factor(CLASIFFICATION_FINAL), y = AGE, fill = factor(SEX))) +
  geom_boxplot() +
  labs(x = "Classification", y = "Age", 
       title = "Age Distribution by Classification and Sex") +
  theme_minimal()


saveRDS(
  fig2,
  file = here::here("output", "graphical_analysis_fig2.rds")
)


fig3=ggplot(data, aes(x = CLASIFFICATION_FINAL, fill = OBESITY)) +
  geom_bar() +
  labs(
    title = "Stacked Bar Chart of Obesity and Classification",
    x = "CLASIFICATION_FINAL",
    y = "count",
    fill = "OBESITY"
  ) +
  theme_minimal()

saveRDS(
  fig3,
  file = here::here("output", "graphical_analysis_fig3.rds")
)
