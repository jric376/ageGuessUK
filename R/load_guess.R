
# AgeGuess Various Data Files ---------------------------------------------


library(here)
library(magrittr)
library(data.table)
library(anytime)

ag_guess <- here::here("data", "ag_guess.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, access := anytime::anytime(access)] %>%
  .[, ageT := ageG - outG] %>%
  .[, signG := sign(outG)]

ag_gamers <- here::here("data", "ag_gamers.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, ':=' (access = anytime::anytime(access),
            created = anytime::anytime(created))]

ag_photos <- here::here("data", "ag_photos.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)]

ag_quality <- here::here("data", "ag_quality.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)]

ag_report <- here::here("data", "ag_report.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)]
