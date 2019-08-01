# -------------------------------------------------------------------------
# GOAL: feature selection
# Factors to consider when pricing a home are: 
#   > historic sales price, 
#   > quality of the neighborhood, 
#   > the market, 
#   > nearby features and 
#   > the size, 
#   > appeal, 
#   > age and
#   > condition of the home. 
# -------------------------------------------------------------------------

# select variables --------------------------------------------------------
# Most important variables (at first sight) affecting the price based on 
# correlation matrix (exluded var with colinearity) and decision tree with
# only categorical values: 
#   > OverallQual
#   > 1 stFlrrSF or TotalBsmtBF
#   > GrLivArea
#   > Garage Cars
#   > Neighbor
#   > MSSubCla
data %<>% 
  select(
    # id of the data and each observation 
    df_id, Id,
    
    # dependent variable
    SalePrice,
    
    # 1. historic sales price:
    # we do not have the historical price of each house, but we have when has 
    # been sold
    # MoSold, YrSold,  
    
    # 2. neighborhood: 
    Neighborhood,
    
    # 3. the market: 
    # maybe we can extract information from external sources. When has been 
    # this data collected? we can create a general price for each neiborhood
    
    # 4. size and appeal:
    OverallQual, MSSubClass, GarageCars, GrLivArea,
    
    # 5. Age and condition: 
    # YearBuilt, YearRemodAdd,
    
    # 6. nearby features:
    )
