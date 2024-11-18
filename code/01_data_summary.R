library(here)
library(dplyr)
library(gtsummary)

#this is where the code is for data summary
here::i_am(
  "code/01_data_summary.R"
)

# Load datasets
all_data <- read.csv(
  file = here::here("data/all_data.csv")
)


#creating the demographic table of all the variables
demographic_table <- all_data %>%
  select(SEX, AGE, PATIENT_TYPE, INTUBED, PNEUMONIA, DIABETES, COPD, ASTHMA, 
         INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, 
         RENAL_CHRONIC, TOBACCO, ICU) %>%
  tbl_summary(
    by = SEX,  #grouping by sex for now
    statistic = list(all_categorical() ~ "{n} ({p}%)", all_continuous() ~ "{mean} ({sd})"),
    missing = "no"  
  )



saveRDS(
  demographic_table,
  file = here::here("output", "demographic_table.rds")
)

