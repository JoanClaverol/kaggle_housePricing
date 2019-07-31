# -------------------------------------------------------------------------
# GOAL: organize image exploration
# DESCRIPTION: script to put all ggplots with relevant insights 
# -------------------------------------------------------------------------

# libraries ---------------------------------------------------------------
if (require(pacman) == FALSE) {
  install.packages("pacman")
}
pacman::p_load(ggplot2, dplyr)


# origin year vs remodel add ----------------------------------------------
# load data
source("scripts/data_import/data_import.R")
# prepare the data wit cuts for ege
data %>% 
  mutate(SalePrice_cl = cut(
    SalePrice, breaks = 5, 
    labels = c("$34K - $178K", "$179K - $320K","$324 - $466K",
               "$475K - $582K","$611K - $755K")
  )) %>% 
  filter_at(vars(starts_with("Year"), "SalePrice_cl"), 
            ~!is.na(.))-> temp
# do the plot with face grid
temp %>% 
  ggplot(aes(x = YearBuilt, y = YearRemodAdd, 
             col = SalePrice_cl)) + 
  geom_point(alpha = 0.6, size = 3) + 
  facet_wrap(.~SalePrice_cl) +
  ggtitle(label = "Original contruction year vs remodel date") +
  labs(subtitle = paste(" After the 1950, a lot of houses start to have the", 
                        "original construction date as a remodel date."), 
       color = "Range of prices:")  +
  xlab(label = "Original construction date") +
  ylab(label = "Remodel date") +
  scale_color_brewer(palette="Dark2") +
  theme(legend.direction = "horizontal", 
        legend.position = "top", 
        panel.background = element_rect(fill = NA),
        panel.spacing.x = unit(0,"line"),
        panel.grid.major = element_line(colour = "snow2"),
        panel.ontop = FALSE, 
        strip.background = element_blank(), 
        strip.text.x = element_blank(),
        legend.title = element_text(face = "bold"))
  

# neighborhood effect on price --------------------------------------------
# load data
source("scripts/data_import/data_import.R")
# select variables 
data %>% 
  group_by(Neighborhood) -> temp_all %>% 
  summarise(SalePrice = median(SalePrice, na.rm = T)/1000) -> temp
y_intercept <- mean(temp$SalePrice)
# column chart
temp %>% 
  ggplot(aes(x = reorder(Neighborhood, SalePrice), y = SalePrice)) +
    geom_col(fill = "grey") + # strong blue color #01579B
    geom_hline(yintercept = y_intercept, color = "#01579B") + 
    coord_flip() + 
    labs(title = "Median sale price by neighborhood") +
    ylab(label = "Sale price in thousands") +
    xlab(label = "Neighborhood name") +
    theme(panel.background = element_blank())

# boxplot: detect and extract outliers for sales price
data %>% 
  ggplot(aes(x = Neighborhood, y = SalePrice)) +
    geom_boxplot() + 
    coord_flip() +
    theme(panel.background = element_blank())
# see the relation between the two variable 
data %>% 
  mutate(SalePrice = round(SalePrice/1000, 0)) %>% 
  ggplot(aes(x = GrLivArea, y = SalePrice)) +
    geom_point(aes(color = (GrLivArea > 4000 & SalePrice < 200))) + 
    geom_smooth(method = "loess") +
    scale_color_manual(values = c("#56B4E9","red"),
                       labels = c("Tipical obs.", "Outlier")) +
    labs(title = "Relation between sale price and ground living area",
         subtitle = paste(
           "The red dots clearly deviates the linear relation", 
           "between both variables")) +
    xlab(label = "Ground living area in square feet") + 
    ylab(label = "Sale price($) in thousands") +
    theme(legend.title = element_blank(), 
          panel.background = element_blank())


# -------------------------------------------------------------------------

source("scripts/data_import/data_import.R")
data %>% 
  # group_by(MSZoning) %>% 
  # summarise(SalePrice = median(SalePrice, na.rm = T)) %>%
  ggplot() + 
    geom_density(aes(x = SalePrice, fill = MSZoning), alpha = 0.5)
