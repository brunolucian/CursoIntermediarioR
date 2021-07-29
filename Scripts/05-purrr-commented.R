## Instalando pacotes ---------------------------------
install.packages(c("Rtools", "devtools", "purrr"))
devtools::install_github("jennybc/repurrrsive")
library(repurrrsive)
library(tidyverse) # Ou
library(purrr)

## 01 - map -------------------------------------------

# Quantos elementos existem em sw_people?
length(sw_people)

# Quem é a primeira pessoa em sw_people?
sw_people[[1]]

# Uma lista dentro da lista
sw_people[1]

# Utilizando a map

# Em quantas naves (starships) cada personagem esteve?
map(sw_people, ~length(.x$starships))

# For later
planet_lookup <- map_chr(sw_planets, "name")  %>%
  set_names(map_chr(sw_planets, "url"))
planet_lookup
#save(planet_lookup, file = "data/planet_lookup.rda", compress = FALSE)

map(sw_people,
    ~planet_lookup[.x$homeworld])

## ---------------------------------------------------

## 02 - map_*() --------------------------------------

# Em quantas naves (starships) cada personagem esteve?
map_int(sw_people, ~ length(.x[["starships"]]))

# Qual é a cor do cabelo de cada personagem?
map_chr(sw_people, ~ .x[["hair_color"]])

# Quais são os personagens masculinos?
map_lgl(sw_people, ~ .x[["gender"]] == "male")

# Qual é o peso de cada personagem?
map_dbl(sw_people, ~ .x[["mass"]])

# Não funciona ...
map(sw_people, ~ .x[["mass"]])

# Um pouco arriscado
map_dbl(sw_people, ~ as.numeric(.x[["mass"]]))

# Provavelmente queremos algo como:
map_chr(sw_people, ~ .x[["mass"]]) %>%
  readr::parse_number(na = "unknown")

## 03 - challenges --------------------------------------

# Qual filme (ver em sw_films) tem mais personagens?
map(sw_films, "characters") %>%
  map_int(length) %>%
  set_names(map_chr(sw_films, "title")) %>%
  sort()

# Qual espécie tem as cores de olhos mais frequente?
sw_species[[1]]$eye_colors

map_chr(sw_species, "eye_colors") %>%
  strsplit(", ") %>%
  map_int(length) %>%
  set_names(map_chr(sw_species, "name"))

# Which planets do we know the least about?
# For one, entry 61
# Para quais planetas temos menos informações?
# Para 1 de 61
map_lgl(sw_planets[[61]], ~ "unknown" %in% .x) %>%
  sum()

# Para todos
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

# Criar um ggplot, considerando a Expectativa de vida, para
# cada país ao longo do tempo com um título

# Para um país
ggplot(gap_split_small[[1]], aes(year, lifeExp)) +
  geom_line() +
  labs(title = countries[[1]])

# Para todos os países
plots <- map2(gap_split_small, countries,
              ~ ggplot(.x, aes(year, lifeExp)) +
                geom_line() +
                labs(title = .y))

plots[[1]]
# Mostrar todos os gráficos
walk(plots, print)

# Salvando todos os gráficos
walk2(.x = plots, .y = countries,
      ~ ggsave(filename = paste0(.y, ".pdf"), plot = .x))

# Removendo todos eles
file.remove(paste0(countries, ".pdf"))

## 05 - manipulate columns ------------------------------

# Criando uma tabela para nos ajudar
film_number_lookup <- map_chr(sw_films, "url") %>%
  map(~ stringr::str_split_fixed(.x, "/", 7)[, 6])  %>%
  as.numeric() %>%
  set_names(map_chr(sw_films, "url"))

# Inserindo algumas variáveis em um tibble
people_tbl <- tibble(
  name    = sw_people %>% map_chr("name"),
  films   = sw_people %>% map("films"),
  height  = sw_people %>% map_chr("height") %>%
    readr::parse_number(na = "unknown"),
  species = sw_people %>% map_chr("species", .null = NA_character_)
)

# Transformando parte de nossa lista em um tibble
people_tbl$films

# Use map with mutate to manipulate list columns
people_tbl <- people_tbl %>%
  mutate(
    film_numbers = map(films,
                       ~ film_number_lookup[.x]),
    n_films = map_int(films, length)
  )

people_tbl %>% select(name, film_numbers, n_films)


# Criar uma nova coluna de caracteres que reduz os números
# dos filmes em uma única sequência, por exemplo, para
# Luke "6, 3, 2, 1, 7"

people_tbl <- people_tbl %>%
  mutate(films_squashed = map_chr(film_numbers, paste,
                                  collapse = ", "))

people_tbl %>% select(name, n_films, films_squashed)

## 06 - safely() and transpose() ------------------------

urls <- list(
  example = "http://example.org",
  asdf = "http://asdfasdasdkfjlda"
)

map(urls, read_lines)

safe_readlines <- safely(readLines)
safe_readlines

# Usando a função safe_readLines() com map(): html
html <- map(urls, safe_readLines)

str(html)

# Extraindo o resultado do elemento que teve sucesso
html[["example"]][["result"]]

# Extraindo o erro do elemento que não teve sucesso
html[["asdf"]][["error"]]

str(transpose(html))

# Extraindo os resultdos: res
res <- transpose(html)[["result"]]

# Extraindo os erros: errs
errs <- transpose(html)[["error"]]

## ------------------------------------------------

## Outras funções ----------------------------------

purr::rerun() # para repetir uma função várias vezes

## -------------------------------------------------
