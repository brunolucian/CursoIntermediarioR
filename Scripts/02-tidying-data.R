## ----------------------------------------------------------------
library(tidyverse)



## ----------------------------------------------------------------

table4b



## ----------------------------------------------------------------

table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "ano", values_to = "populacao")



## ----------------------------------------------------------------

table2



## ----------------------------------------------------------------

table2 %>%
    pivot_wider(names_from = type, values_from = count)



## ----------------------------------------------------------------

table3



## ----------------------------------------------------------------
table3 %>% 
  separate(rate, into = c("Casos", "Populacao"))


## ----------------------------------------------------------------

table3 %>% 
  separate(rate, into = c("Casos", "Populacao"), sep = "/")



## ----------------------------------------------------------------

table3 %>% 
  separate(rate, into = c("Casos", "Populacao"), convert = TRUE)



## ----------------------------------------------------------------
table_separate <- table3 %>%
  separate(rate, 
           into = c("Casos", "Populacao"), convert = TRUE) %>% 
  separate(year, into = c("Seculo", "Ano"), sep = 2)

table_separate



## ----------------------------------------------------------------
table_separate %>% 
  unite(Ano_Cheio, Seculo, Ano)


## ----------------------------------------------------------------
table_separate %>% 
  unite(Ano_Cheio, Seculo, Ano, sep = "")


## ----------------------------------------------------------------
stocks <- tibble(
  Anos   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  Tri    = c(   1,    2,    3,    4,    2,    3,    4),
  Retornos = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)


## ----------------------------------------------------------------
stocks %>% 
  pivot_wider(names_from = Anos, values_from = Retornos)


## ----------------------------------------------------------------
stocks %>% 
  pivot_wider(names_from = Anos, values_from = Retornos) %>% 
  pivot_longer(
    cols = c(`2015`, `2016`), 
    names_to = "Anos", 
    values_to = "Retornos", 
    values_drop_na = TRUE
  )


## ----------------------------------------------------------------
stocks %>% 
  complete(Anos, Tri)


## ----------------------------------------------------------------
tratamento <- tribble(
  ~ Pessoa,       ~ Tratamento, ~Resposta,
  "Roberto Silva",    2,           10,
  NA,                 3,           3,
  NA,                 1,           7,
  "Luciana Medeiros", 2,           9
)


## ----------------------------------------------------------------
tratamento %>% 
  fill(Pessoa)



## ----------------------------------------------------------------

library(gapminder)

by_country <- gapminder %>% 
  group_by(country, continent) %>% 
  nest()

by_country


## ----------------------------------------------------------------
by_country$data[[15]]


## ----------------------------------------------------------------
tibble(x = 1:2, y = list(1:4, 1)) 


## ----------------------------------------------------------------
tibble(x = 1:2, y = list(seq(1,100,20), 1)) %>% unnest(y)


## ----------------------------------------------------------------

df1 <- tribble(
  ~x, ~y,           ~z,
   1, letters[3:4], 12:13,
   2, "c",           3
)

df1
df1 %>% unnest(c(y, z))




