# -------------------------------------------------------------------------
# GOAL: deplying model on the test data and saving it for kaggle competition
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(modelr)


# apply the model ---------------------------------------------------------
# apply on test data
test %<>% 
  add_predictions(model = output$model, var = "SalePrice") %>% 
  mutate(SalePrice = as.integer(SalePrice))

# load submission data
submission <- read_csv("data/raw_data/sample_submission.csv", 
                       col_types = cols())
# join to submission data ready to load on kaggle
submission %>% 
  select(Id) %>% 
  left_join(y = test %>% select(Id, SalePrice), by = "Id") %>% 
  write_csv("data/results/results.csv")
