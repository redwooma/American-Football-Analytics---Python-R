#z <- 2
#z / 3
#install.packages("nflfastR")
#options(repos = c(CRAN = "https://cloud.r-project.org"))
#install.packages("devtools")
#devtools::install_github("nflverse/nflfastR")
library("tidyverse")
library("nflfastR")

# play-by-play
# _r is to help you tell that the code is from R
pbp_r <- load_pbp(2021)

# pass (or pipe) the data along to be filtered by using |>.
# Use the filter() function to seleect only data where passing plays occured (play_type == "pass") and
# where air_yards are not missing, or NA in R syntax
pbp_r_p <- pbp_r |> filter(play_type == "pass" & !is.na(air_yards))

# average depth of target (aDOT), or mean air yards per pass,
# for every quarterback in the NFL in 2021 who threw 100 or more passes with a designated depth
pbp_r_p |>
  group_by(passer_id, passer) |>
  summarize(n = n(), adot = mean(air_yards)) |>
  filter(n >= 100 & !is.na(passer)) |>
  arrange(-adot) |>
  print(n = Inf)
