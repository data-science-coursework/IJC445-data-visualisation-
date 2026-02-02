# IJC445 - Data Visualisation - PM2.5 air pollution in Sheffield and Leeds (2017-2025)
IJC445 Data Visualisation coursework

This repository contains data visualisations and analysis of PM2.5 concentrations across four monitoring sites in Sheffield and Leeds between 2017 to 2025. 

## Visualisations included

The repository produces the following visualisations:
- Annual trends in PM2.5 concentrations in Sheffield Barnsley Road monitoring site (box plots)
- Seasonal mean PM2.5 concentrations by site (bar chart)
- Diurnal variation in PM2.5 concentrations by hour of the day (line graph)
- Percentage of days exceeding the PM2.5 WHO guideline by monitoring site (heatmap)

These visualisations aim to highlight long-term trends, seasonal patterns, short-term exposure variability and health-based guideline exceedances.

## Repository contents

- `data/`  
  PM2.5 monitoring data (hourly measurements).

- `pm25_analysis.R`  
  Data processing code necessary for creating all visualisations used in this coursework

  - `pm25_visualisations.R`  
  Code to generate all visualisations used in the coursework.


  ## How to run the analysis
1. 
2. Open Rstudio
3. Run `pm25_analysis.R`
4. Run `pm25_visualisations.R` to generate all visualisations
