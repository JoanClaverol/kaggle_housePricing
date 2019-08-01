

# split data --------------------------------------------------------------
# define training data 
train <- data %>% 
  filter(df_id == "train") 
# define validation data
test <- data %>% 
  filter(df_id == "test")

# run model ---------------------------------------------------------------
# call the function to run the pipeline 
source("scripts/modalization/fun_model_creation.R")
# define dependent and indepent variables
x <- "SalePrice"
y <- train %>% 
  select(-Neighborhood, -OverallQual, -MSSubClass, -GarageCars, -df_id, -Id) %>% 
  names(.)

# run the function
output <- modalization(
  data = train, 
  p_partition = 0.8, 
  cv_repeats = 3, 
  cv_number = 2, 
  x = x, 
  y = y,
  model_name = "lm", 
  set_seed = 123
  )
output


# clean environment -------------------------------------------------------
rm(modalization, x, y, train)



