PM2.5 analysis: Sheffield and Leeds
# IJC445 coursework

# 1. Load packages
library(tidyverse) 
library(lubridate)
library(ggplot2)

# 2. Load raw data
sheffield_barnsley_road <- read_csv("data/raw/SHEFFIELD BARNSLEY ROAD.csv")
sheffield_tinsley <- read_csv("data/raw/SHEFFIELD TINSLEY.csv")
leeds_centre <- read_csv("data/raw/LEEDS CENTRE.csv")
leeds_headingley_kerbside <- read_csv("data/raw/LEEDS HEADINGLEY KERBSIDE.csv")

# 3. Add a column called site_name with the site name 
sheffield_barnsley_road <- sheffield_barnsley_road %>%
  mutate(site_name = "Sheffield Barnsley Road")

sheffield_tinsley <- sheffield_tinsley %>%
  mutate(site_name = "Sheffield Tinsley")

leeds_centre <- leeds_centre %>%
  mutate(site_name = "Leeds Centre")

leeds_headingley_kerbside <- leeds_headingley_kerbside %>%
  mutate(site_name = "Leeds Headingley Kerbside")

# 4. Combine all four data sets
pm25_hourly <- bind_rows(
  sheffield_barnsley_road,
  sheffield_tinsley,
  leeds_centre,
  leeds_headingley_kerbside)

# 5. Format date
pm25_hourly <- pm25_hourly %>%
  mutate(date = as.Date(date, format = "%d/%m/%Y"))

# 6. Remove negative PM2.5 values
pm25_hourly <- pm25_hourly %>%
  mutate(pm25 = ifelse(pm25 < 0, NA, pm25))

# 7. Compute daily means ( where days must have more than 75% data completeness to be included)
pm25_daily <- pm25_hourly %>%
  group_by(site_name, date) %>%
  summarise(
    daily_mean = mean(pm25, na.rm = TRUE),
    n_obs = sum(!is.na(pm25)),
    .groups = "drop"
  ) %>%
  filter(n_obs >= 18)

# 8. Add year and month columns
pm25_daily <- pm25_daily %>%
  mutate(
    year = year(date),
    month = month(date, label = TRUE),
    month_num = month(date))

# 9. Add a season column
pm25_daily <- pm25_daily %>%
mutate(
   season = case_when(
    month_num %in% c(12, 1, 2)  ~ "Winter",
    month_num %in% c(3, 4, 5)   ~ "Spring",
    month_num %in% c(6, 7, 8)   ~ "Summer",
    month_num %in% c(9, 10, 11) ~ "Autumn"))

# 10. Create monthly means by year 
pm25_monthly <- pm25_daily %>%
  group_by(site_name, year, month) %>%
  summarise(
    monthly_mean = mean(daily_mean, na.rm = TRUE),
    .groups = "drop")

# 11. create seasonal means by year
pm25_seasonal <- pm25_daily %>%
  group_by(site_name, year, season) %>%
  summarise(
    seasonal_mean = mean(daily_mean, na.rm = TRUE),
    .groups = "drop")

# 12. Create WHO guideline & UK targets threshold exceedances in percentages of days
pm25_daily <- pm25_daily %>%
  mutate(
    exceed_5  = daily_mean > 5,
    exceed_10 = daily_mean > 10,
    exceed_12 = daily_mean > 12)

pm25_exceedance <- pm25_daily %>%
  group_by(site_name, year) %>%
  summarise(
    percentage_over_5  = mean(exceed_5, na.rm = TRUE) * 100,
    percentage_over_10 = mean(exceed_10, na.rm = TRUE) * 100,
    percentage_over_12 = mean(exceed_12, na.rm = TRUE) * 100,
    .groups = "drop")


# 13. Create overall seasonal means.
pm25_seasonal_overall <- pm25_daily %>%
  group_by(site_name, season) %>%
  summarise(
    mean_pm25 = mean(daily_mean, na.rm = TRUE),
  .groups = "drop")

# 14. Create overall yearly means
pm25_yearly <- pm25_daily %>%
  group_by(site_name, year) %>%
  summarise(
  yearly_mean = mean(daily_mean, na.rm = TRUE),
    .groups = "drop")

# 15. Diurnal variations 
pm25_diurnal <- pm25_hourly %>%
  group_by(site_name, hour) %>%
  summarise(
   mean_pm25 = mean(pm25, na.rm = TRUE),
   .groups = "drop"
)  %>%
  mutate(plot_hour = ifelse(hour == 24, 0, hour))
