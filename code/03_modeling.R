# Load libraries
library(here)
library(broom)
library(dplyr)
library(nnet)
library(knitr)
library(effects)

here::i_am(
  "code/03_modeling.R"
)

# Load datasets
all_data <- read.csv(
  file = here::here("data/all_data.csv")
)

obese_data <- read.csv(
  file = here::here("data/obese_data.csv")
)

not_obese_data <- read.csv(
  file = here::here("data/not_obese_data.csv")
)

# Mileati
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

# Jiani
# Build models
model_obese <- multinom(CLASIFFICATION_FINAL ~ AGE + SEX, data = obese_data)
summary(model_obese)

model_not_obese <- multinom(CLASIFFICATION_FINAL ~ AGE + SEX, data = not_obese_data)
summary(model_not_obese)

# Extract coefficients for both models
coef_obese <- summary(model_obese)$coefficients
coef_non_obese <- summary(model_not_obese)$coefficients

# Odds ratios for both models
or_obese <- exp(coef(model_obese))
or_not_obese <- exp(coef(model_not_obese))

# Confidence intervals for both models
confint_obese <- confint(model_obese)
confint_not_obese <- confint(model_not_obese)

# P-values for both models
p_values_obese <- 2 * pnorm(-abs(coef_obese[, 3]))
p_values_not_obese <- 2 * pnorm(-abs(coef_not_obese[, 3]))

# Create data frame for obese model
table_obese <- data.frame(
  Predictor = rep(c("(Intercept)", "AGE", "SEXmale"), times = 2),
  Level = rep(c("Moderate COVID", "Severe COVID"), each = 3),
  Estimate_Obese = c(coef_obese[1:3, 1], coef_obese[4:6, 1]),  # Adjusted indices
  Std_Error_Obese = c(coef_obese[1:3, 2], coef_obese[4:6, 2]),
  Z_Value_Obese = c(coef_obese[1:3, 3], coef_obese[4:6, 3]),
  P_Value_Obese = c(p_values_obese[1:3], p_values_obese[4:6])  # Ensure p-values match
)

# Create data frame for non-obese model
table_not_obese <- data.frame(
  Predictor = rep(c("(Intercept)", "AGE", "SEXmale"), times = 2),
  Level = rep(c("Moderate COVID", "Severe COVID"), each = 3),
  Estimate_NotObese = c(coef_not_obese[1:3, 1], coef_not_obese[4:6, 1]),  # Adjusted indices
  Std_Error_NotObese = c(coef_not_obese[1:3, 2], coef_not_obese[4:6, 2]),
  Z_Value_NotObese = c(coef_not_obese[1:3, 3], coef_not_obese[4:6, 3]),
  P_Value_NotObese = c(p_values_not_obese[1:3], p_values_not_obese[4:6])  # Ensure p-values match
)

combined_table <- merge(table_obese, table_not_obese, by = c("Predictor", "Level"), all = TRUE)
kable(combined_table, format = "markdown", caption = "Comparison of Coefficients for Obese and Not-Obese Models")

# Compare AICs of the two models
aic_obese <- AIC(model_obese)
aic_not_obese <- AIC(model_not_obese)

# Save combined table
saveRDS(combined_table, file = "output/combined_table.rds")

# Save AIC results
aic_results <- list(
  AIC_Obese = aic_obese,
  AIC_Not_Obese = aic_not_obese
)
saveRDS(aic_results, file = "output/aic_results.rds")


