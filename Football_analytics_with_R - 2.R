library("tidyverse") # collection of packages to assist in wrangling and plotting the data.
library("nflfastR") # provides you with the data from the NFL
#install.packages("ggthemes")
#chooseCRANmirror(graphics=FALSE)
#install.packages("ggthemes", repos = "https://cran.microsoft.com/snapshot/2022-01-01")
#install.packages("ggthemes", type = "source")
library("ggthemes") # plotting formatting

# specify the range 2016 to 2022
pbp_r = load_pbp(2016:2022)

# subset of data
pbp_r_p <-
  pbp_r |>
  filter(play_type == "pass" & !is.na(air_yards))

# ifelse function inside mutate() allows the same change:
pbp_r_p <-
  pbp_r_p |>
  mutate(
    pass_length_air_yards = ifelse(air_yards >= 20, "long", "short"),
    passing_yards = ifelse(is.na(passing_yards), 0, passing_yards)
  )

# make a dataframe and select (or pull()) the passing_yards column and then calculate the summary() statistics:
pbp_r_p |>
  pull(passing_yards) |>
  summary()

# observe summary of data under different values of pass_length_air_yards
# short passes, filter out the long passes and then summarize.
pbp_r_p |>
  filter(pass_length_air_yards == "short") |>
  pull(passing_yards) |>
  summary()
# long passes
pbp_r_p |>
  filter(pass_length_air_yards == "long") |>
  pull(passing_yards) |>
  summary()

# expected points added (EPA)
pbp_r_p |>
  filter(pass_length_air_yards == "long") |>
  pull(epa) |>
  summary()

