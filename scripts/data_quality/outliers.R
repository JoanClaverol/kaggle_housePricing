# -------------------------------------------------------------------------
# GOAL: extract outliers 
# DESCRIPTION: esctraction of outliers based
# -------------------------------------------------------------------------

# libraires ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(dplyr, magrittr)

# load data ---------------------------------------------------------------
source("scripts/data_import/data_import.R")

# ground living area ------------------------------------------------------
# bigger than 4000 we are going to consider them as outliers
data %<>% 
  filter(!(GrLivArea > 4000 & SalePrice < 200000 & df_id == "train"))
# they represent 5 observations, a 0.17% of the data.  
