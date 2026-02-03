
# PM2.5 visualistions
# IJC445 coursework

library(tidyverse)
library(ggplot2)
library(lubridate)

source("pm25_analysis.R")
  
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
    y = expression("PM2.5 ("*mu*"g/m"^3*")"))  + theme_minimal()

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
    y = expression("PM2.5 ("*mu*"g/m"^3*")"))  + theme_minimal()

# Create the diurnal line plot including all four monitoring locations

ggplot(pm25_diurnal,
 aes(x = plot_hour, y = mean_pm25, colour = site_name)) +
  geom_line(linewidth = 1.2) +
  scale_colour_manual(values = site_cols, name = "Monitoring site") +
  scale_x_continuous(breaks = seq(0, 23, by = 2)) +
  labs(
    title = "Diurnal variation in PM2.5 concentrations",
    x = "Hour of day",
    y = expression("PM2.5 ("*mu*"g/m"^3*")")) + theme_minimal()

# Create the heatmap of percentage of days in each year exceeding the WHO health-based guideline, including all 4 monitoring sites
ggplot(pm25_exceedance,
       aes(x = year, y = site_name, fill = percentage_over_5)) +
  geom_tile(color = "white") +
  scale_fill_gradient(
    name = "% of days > 5 µg/m³",
    low = "white",
    high = "red",
    limits = c(0, 100)) +
  labs(title = "Percentage of days exceeding WHO PM2.5 guideline",
    x = "Year",
    y = "Monitoring site") +  theme_minimal()


