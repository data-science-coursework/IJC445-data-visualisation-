
# PM2.5 visualistions
# IJC445 coursework

library(tidyverse)
library(ggplot2)
library(lubridate)
  
# Set a colour palette to be used for all visualisations
  site_cols <- c(
  "Leeds Centre" = "#1f3c88",
  "Leeds Headingley Kerbside" = "#6aaed6",
  "Sheffield Barnsley Road" = "darkgoldenrod2",
  "Sheffield Tinsley" = "#d73027")

# Create the yearly box plot visualisation for Sheffield Barnsley Road
pm25_daily %>%
  filter(site_name == "Sheffield Barnsley Road") %>%
  ggplot(aes(x = factor(year), y = daily_mean)) +
  geom_boxplot(fill = "darkgoldenrod2", outlier.alpha = 0.3) +
  labs(
    title = "Distribution of daily PM2.5 concentrations by year",
    subtitle = "Sheffield Barnsley Road (2017–2025)",
    x = "Year",
    y = expression("PM2.5 ("*mu*"g/m"^3*")"))
    +
    theme_minimal()

# Create the seasonal bar chart including all four monitoring sites
pm25_seasonal_overall %>%
  mutate(
    season = factor(season, levels = c("Winter", "Spring", "Summer", "Autumn"))
  ) %>%
  ggplot(aes(x = season, y = mean_pm25, fill = site_name)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = site_cols, name = "Monitoring site") +
  labs( title = "Seasonal mean PM2.5 concentrations",
    x = "Season",
    y = expression("PM2.5 ("*mu*"g/m"^3*")"))
   +
   theme_minimal()



