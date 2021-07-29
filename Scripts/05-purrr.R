## Instalando pacotes ---------------------------------
install.packages(c("Rtools", "devtools", "purrr"))
devtools::install_github("jennybc/repurrrsive")
library(repurrrsive)
library(tidyverse) # Ou
library(purrr)

## 01 - map -------------------------------------------

length(sw_people)

sw_people[[1]]

sw_people[1]

map(sw_people, ~length(.x$starships))

## ---------------------------------------------------

## 02 - map_*() --------------------------------------

map_int(sw_people, ~ length(.x[["starships"]]))

map_chr(sw_people, ~ .x[["hair_color"]])

map_lgl(sw_people, ~ .x[["gender"]] == "male")

map_dbl(sw_people, ~ .x[["mass"]])

map(sw_people, ~ .x[["mass"]])

map_dbl(sw_people, ~ as.numeric(.x[["mass"]]))

map_chr(sw_people, ~ .x[["mass"]]) %>%
  readr::parse_number(na = "unknown")

## 03 - challenges --------------------------------------

map(sw_films, "characters") %>%
  map_int(length) %>%
  set_names(map_chr(sw_films, "title")) %>%
  sort()

sw_species[[1]]$eye_colors

map_chr(sw_species, "eye_colors") %>%
  strsplit(", ") %>%
  map_int(length) %>%
  set_names(map_chr(sw_species, "name"))

map_lgl(sw_planets[[61]], ~ "unknown" %in% .x) %>%
  sum()

map_int(sw_planets,
        ~ map_lgl(.x, ~ "unknown" %in% .x) %>% sum()) %>%
  set_names(map_chr(sw_planets, "name")) %>%
  sort(decreasing = TRUE)

## 04 - map2() ---------------------------------------

x <- list(1, "a", 3)

x %>%
  walk(print)

x <- list(1, 2, 3)

modify(x, ~.+2)

# ---------------------------------------

gap_split_small <- gap_split[1:10]
countries <- names(gap_split_small)

ggplot(gap_split_small[[1]], aes(year, lifeExp)) +
  geom_line() +
  labs(title = countries[[1]])

plots <- map2(gap_split_small, countries,
              ~ ggplot(.x, aes(year, lifeExp)) +
                geom_line() +
                labs(title = .y))

plots[[1]]

walk(plots, print)

walk2(.x = plots, .y = countries,
      ~ ggsave(filename = paste0(.y, ".pdf"), plot = .x))

file.remove(paste0(countries, ".pdf"))

