# -------------------------------------------------------------------------
# GOAL: first exploration
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(readr, dplyr, ggplot2, modelr)

# load data ---------------------------------------------------------------
# load data
train <- read_csv("data/raw_data/train.csv")
test <- read_csv("data/raw_data/test.csv")
submission <- read_csv("data/raw_data/sample_submission.csv")

# check missing values
summary(train)
temp <- train %>% 
  summarise_all(~sum(is.na(.)))
# filter missing values
train <- train %>% 
  select(-FireplaceQu, -PoolQC, -Fence, -MiscFeature, -Alley, -LotFrontage) %>% 
  filter_all(~!is.na(.))
# maybe we can use correlation to detect relevant variables. Let's find the 
# numeric variables and checki for missing values
train_dbl <- train %>% 
  select_if(is.double) 
test %>% 
  summarise_all(~sum(is.na(.))) -> temp


# numeric values relation -------------------------------------------------
# Done! Let's look for the correlation inside the variables.
train_cor <- cor(train_dbl)
library(corrplot)
corrplot(train_cor)
# we can also use the library ggally and ggplot
library(GGally)
ggcorr(train_cor, nbreaks = 11) -> p1
plotly::ggplotly(p1)
train_cor %>% 
  as_tibble() %>%
  mutate(names = names(.)) %>% 
  select(SalePrice, names) %>% 
  filter(
    !between(SalePrice, -0.2, 0.6),
    ) %>% 
  arrange(desc(SalePrice)) -> temp
ggpairs(train, 
        columns = c(temp$names)) 
# CONCLUSIONS: 
# Variables affecting the price: 
#   > OverallQual
#   > 1 stFlrrSF or TotalBsmtBF
#   > GrLivArea
#   > Garage Cars
# Colinearity
#   > 1 stFlrrSF and TotalBsmtBF
#   > Garage cards and Garage Area

# categorical values correlation ------------------------------------------
# find relevant features categorical values
train_chr <- data %>% 
  filter(df_id == "train") %>% 
  select_if(is.factor) %>% 
  bind_cols(train %>% select(SalePrice))
# run a rpart model
library(rpart)
mod_dt <- rpart(SalePrice ~ ., data = train_chr)
rpart.plot::prp(mod_dt, extra = 100)
# CONCLUSION:
# relevant features
#   > Neighbor
#   > MSSubCla
#   > OverallQual


# model -------------------------------------------------------------------
source("scripts/modalization/fun_model_creation.R")
y <- c("SalePrice","OverallQual","GrLivArea","GarageCars","TotalBsmtSF")
mod <- modalization(data = train, p_partition = 0.75, cv_repeats = 3, 
                    cv_number = 5, x = "SalePrice", y = y, model_name = "lm",
                    set_seed = 666)

# applyting to test on selected variabels
test$pred <- predict(object = mod, newdata = test)
test %>% select("Id","OverallQual","GrLivArea","GarageCars","TotalBsmtSF") -> temp
library(magrittr)
temp %<>% 
  mutate(
    GarageCars = replace(
      GarageCars, is.na(GarageCars),median(GarageCars, na.rm = T)),
    TotalBsmtSF = replace(
      TotalBsmtSF, is.na(TotalBsmtSF), median(TotalBsmtSF, na.rm = T))
  )

temp %<>% 
  add_predictions(model = mod, var = "SalePrice") %>% 
  mutate(SalePrice = as.integer(SalePrice))

submission %>% 
  select(Id) %>% 
  left_join(y = temp %>% select(Id, SalePrice), by = "Id") %>% 
  write_csv("data/results/1st_final_results.csv")
