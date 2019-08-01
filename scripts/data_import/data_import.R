# -------------------------------------------------------------------------
# GOAL: import the data into R
# DESCRIPTION: import the data and give the right type
# -------------------------------------------------------------------------

# load data ---------------------------------------------------------------
train <- read_csv("data/raw_data/train.csv", col_types = cols())
test <- read_csv("data/raw_data/test.csv", col_types = cols())

# data transformation -----------------------------------------------------
# bind the train and test by row
data <- test %>% 
  mutate(SalePrice = NA) %>% 
  bind_rows(train, .id = "df_id") %>%
  mutate(df_id = if_else(df_id == 1, "test", "train")) %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate_at(
    vars(contains("AbvGr"), starts_with("MS"), 
         "OverallQual", "Fireplaces"),
    as.factor
  )

# clean environment -------------------------------------------------------
rm(train, test)

