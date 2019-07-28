# -------------------------------------------------------------------------
# GOAL: first exploration
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(readr, dplyr, ggplot2)

# load data ---------------------------------------------------------------
# load data
train <- read_csv("data/raw_data/train.csv")

# check missing values
summary(train)
temp <- train %>% 
  summarise_all(~sum(is.na(.)))
# filter missing values
train <- train %>% 
  select(-FireplaceQu, -PoolQC, -Fence, -MiscFeature, -Alley, -LotFrontage) %>% 
  filter_all(~!is.na(.))

# model -------------------------------------------------------------------
mod <- lm(SalePrice ~ ., data = train)
