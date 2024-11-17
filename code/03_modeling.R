library(here)
library(dplyr)
library(nnet) #multinomial logistic regression
library(broom) #create tables
library(effects)

here::i_am("code/03_modeling.R")

all_data <- read.csv(
  file = here::here("data/all_data.csv")
)

obese_data <- read.csv(
  file = here::here("data/obese_data.csv")
)

not_obese_data <- read.csv(
  file = here::here("data/not_obese_data.csv")
)



all_data$CLASIFFICATION_FINAL=as.factor(all_data$CLASIFFICATION_FINAL) # Ensure the values are categories instead of a number

all_data_multinomial <- multinom(
  CLASIFFICATION_FINAL ~ AGE + SEX,
  data = all_data
)

obese_data$CLASIFFICATION_FINAL=as.factor(obese_data$CLASIFFICATION_FINAL)

obese_data_multinomial <- multinom(
  CLASIFFICATION_FINAL ~ AGE + SEX,
  data = obese_data
)


not_obese_data$CLASIFFICATION_FINAL=as.factor(not_obese_data$CLASIFFICATION_FINAL)

not_obese_data_multinomial <- multinom(
  CLASIFFICATION_FINAL ~ AGE + SEX,
  data = not_obese_data
)


all_models <- list(
  all =all_data_multinomial,
  obese = obese_data_multinomial,
  not_obese= not_obese_data_multinomial
)
saveRDS(
  all_models,
  file = here::here("output/all_models.rds")
)

#generate tables to hold values from the multinomial 

all_multinomial_table <- 
  tidy(all_data_multinomial) |>
  mutate_if(is.numeric, round, 3) 

colnames(all_multinomial_table) <- c("Level", "Term", "Estimate", "Error", "Statistics" , "Pvalue")

obese_multinomial_table <- 
  tidy(obese_data_multinomial) |>
  mutate_if(is.numeric, round, 3) 

colnames(obese_multinomial_table) <- c("Level", "Term", "Estimate", "Error", "Statistics" , "Pvalue")

not_obese_multinomial_table <- 
  tidy(not_obese_data_multinomial)  |>
  mutate_if(is.numeric, round, 3) 

colnames(not_obese_multinomial_table) <- c("Level", "Term", "Estimate", "Error", "Statistics" , "Pvalue")


all_multinomial_tables_combined <- list(
  all = all_multinomial_table,
  obese=obese_multinomial_table,
  not_obese = not_obese_multinomial_table
)


saveRDS(
  all_multinomial_tables,
  file = here::here("output/all_multinomial_tables_combined.rds")
)










