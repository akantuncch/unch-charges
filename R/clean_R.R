# libraries
library(tidyverse)
library(tidyverse)
library(janitor)
library(hrbrthemes)

# scripts
# source("utils.R");

# specify  directory, then read a list of files
file_path <- here::here("data/")
file_list <- fs::dir_ls(file_path, regexp = ".csv$")

# return a single data frame, combine data
df_source <- file_list |>
  purrr::map_dfr(read_csv, .id = "source") |>
  clean_names()

# add column for year based on source
df_source$year <- with(df_source, ifelse(source == "C:/Users/akant/Documents/unch-charges/data/561118388_uncmedicalcenter_cdmstandardcharges.csv", 2021, 2022))

# gather 2021 data
df_clean21 <- df_source |>
  mutate(
    charge_description = str_remove_all(charge_description, "HC "),
    charge = parse_number(as.character(charge)),
    price = parse_number(as.character(price)),
    min = parse_number(as.character(min)),
    max = parse_number(as.character(max))
  ) |>
  select(year, charge_description, cpt_hcpcs, price, min, max) |>
  filter(year == 2021)

# gather 2022 data and clean cols
df_clean22 <- df_source |>
  mutate(
    price = parse_number(as.character(charge)),
    min = parse_number(as.character(de_identified_minimum_negotiated_charge)),
    max = parse_number(as.character(de_identified_maximum_negotiated_charge)),
    charge_description = str_remove_all(charge_description, "HC ")
  ) |>
  select(
    year,
    charge_description,
    cpt_hcpcs,
    price,
    min,
    max
  ) |>
  filter(year == 2022)

# merge long
df_diff <- bind_rows(df_clean22, df_clean21)

# calculate percent change
df_percent <- df_diff %>%
  arrange(charge_description, year) %>%
  group_by(charge_description) %>%
  mutate(
    percent_change = ((last(price) - first(price)) / first(price))*100,
    min_change = ((last(min) - first(min)) / first(min))*100,
    max_change = ((last(max) - first(max)) / first(max))*100
  ) %>%
  ungroup() %>%
  distinct()
