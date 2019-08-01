# -------------------------------------------------------------------------
# GOAL: find and fill  or extract NAs
# -------------------------------------------------------------------------

# replace garage cars NAs by the median
data %<>% 
  mutate(
    GarageCars = if_else(
      is.na(GarageCars), # condition 
      round(median(as.integer(GarageCars), na.rm = T),0), # replace by median
      GarageCars # in case is not an NA, don't do anything
    )
  )
