# -------------------------------------------------------------------------
# GOAL: check missing values
# DESCRIPTION: 
# -------------------------------------------------------------------------

# libraires ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(dplyr)

# load data ---------------------------------------------------------------
source("scripts/data_import/data_import.R")

# MOst important variables (at first sight) affecting the price: 
#   > OverallQual
#   > 1 stFlrrSF or TotalBsmtBF
#   > GrLivArea
#   > Garage Cars
#   > Neighbor
#   > MSSubCla
data %>% 
  select(OverallQual, TotalBsmtSF, Neighborhood, MSSubClass, GarageCars) %>% 
  summarise_all(~sum(is.na(.)))
# There are two NA
