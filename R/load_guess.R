
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
            created = anytime::anytime(created))] %>%
  .[, gender := fct_recode(gender, "Not specified" = "")] %>%
  .[, ethnicity := fct_recode(ethnicity, "Not specified" = "")]

ag_photos <- here::here("data", "ag_photos.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)] %>%
  .[, gender := fct_recode(gender, "Not specified" = "")] %>%
  .[, ethnicity := fct_recode(ethnicity, "Not specified" = "")]

ag_quality <- here::here("data", "ag_quality.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)]

ag_report <- here::here("data", "ag_report.csv") %>%
  fread() %>%
  as.data.table() %>%
  .[, created := anytime::anytime(created)]

ag_guess_ethn_match <- ag_guess[unique(ag_gamers[, c("uid", "ethnicity")]),
                                on = "uid", nomatch = 0] %>%
  merge(ag_photos[, c("photo_id", "ethnicity")] %>%
          setnames("ethnicity", "photo_ethnicity"),
        by = "photo_id") %>%
  .[, match_ethnicity := ethnicity == photo_ethnicity]
