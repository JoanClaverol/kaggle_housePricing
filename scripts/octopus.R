# -------------------------------------------------------------------------
# GOAL: organize the execution of the relevant scripts
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(tidyverse, magrittr)

# data import -------------------------------------------------------------
source("scripts/data_import/data_import.R")

# data quality ------------------------------------------------------------
# outliers
source("scripts/data_quality/outliers.R")

# missing values
source("scripts/data_quality/NAs.R")

# pre process -------------------------------------------------------------
# feature selection 
source("scripts/pre_process/feature_selection.R")

# feature engineering
source("scripts/pre_process/feature_engineering.R")

# modeling ----------------------------------------------------------------
# creating the model 
source("scripts/modalization/model_creation.R")
# running the model 


# deploy model ------------------------------------------------------------



