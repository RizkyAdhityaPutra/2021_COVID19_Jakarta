library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(dplyr)
library(lubridate)
library(shiny)
library(shinydashboard)
library(DT)

covid <- read.csv("datasets/2021_COVID19_Samples_All.csv", stringsAsFactors = T)

covid_clean <- covid %>% 
  mutate(tanggal = mdy(tanggal),
         nama_bulan = months(covid_clean$tanggal, abbreviate = T))