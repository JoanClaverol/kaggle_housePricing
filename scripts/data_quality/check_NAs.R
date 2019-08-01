# -------------------------------------------------------------------------
# GOAL: check missing values
# DESCRIPTION: 
# -------------------------------------------------------------------------

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
