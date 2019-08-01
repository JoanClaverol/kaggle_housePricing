# -------------------------------------------------------------------------
# GOAL: feature engineering
# DECRIPTION: Creation of new feature thanks to existing ones: 
#   > dummification of relevant variables 
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(fastDummies)


# dummify factor variables ------------------------------------------------
# dummify all factor variables
data %<>% 
  mutate(GarageCars = factor(GarageCars)) %>% 
  dummy_cols(., remove_first_dummy = TRUE)# remove the first dummy variable to 
                                          # avoid colinearity
