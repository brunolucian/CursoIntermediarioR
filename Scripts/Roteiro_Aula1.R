######## Roteiro Aula 1 ########

#### Revisão ####

## Tipos de Objetos ####

# Vetor

v1 <- c(1, 0.2, 0.3, 2, 2.8); v1

# Matriz
# Criando uma matriz vazia
matriz <- matrix(nrow = 20, ncol = 20)

# Data frames
v6 <- 11:15
v7 <- seq(0.3, 0.7, by=0.1)
v8 <- rep("CEPERJ", 5)
v9 <- rep(c(TRUE, FALSE), 5)
df1 <- data.frame(v6, v7, v8, v9)
df1

# renomeando as colunas do dataframe
df1 <- data.frame(col1 = v6, col2 = v7, col3 = v8, col4 = v9)

# estrutura do df
str(df1)

# dimensão do df
dim(df1)

# número de linhas
nrow(df1)

# número de colunas
ncol(df1)

# única linha
df1[3, ]

# algumas linhas
df1[c(1,2,5), ]

# uma sequência de linhas
df1[3:5, ]

# forma alternativa de selecionar coluna
df1[, "col2"]

# outra forma alternativa de selecionar coluna
df1$col3


# Listas
x <- list(5, "Casas", v1, v9, v8)
x

# verificando a classificação do objeto x
class(x)

# extraindo elementos da lista
x[[2]]
x[c(3,1)]

## For ####
# Definindo os elementos da matriz
for(i in 1:dim(matriz)[1]){
  for(j in 1:dim(matriz)[2]){
    matriz[i,j] <- i*j
  }
}

## 5 verbos ####
library(tidyverse)

customers <- read_csv("https://raw.githubusercontent.com/brunolucian/CursoIntermediarioR/main/Dados/olist_customers_dataset.csv")

# Quantidade de clientes por estado
customers %>%
  group_by(customer_state) %>%
  summarise(count = n_distinct(customer_unique_id))

# ordenando os estados pela quantidade de clientes (crescente)
customers %>%
  group_by(customer_state) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  arrange(count)

# ordenando os estados pela quantidade de clientes (decrescente)
customers %>%
  group_by(customer_state) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  arrange(-count)

# Cidades com maior e com menor número de clientes
# tibble com a quantidade de clientes na cidade
customers %>%
  group_by(customer_city) %>%
  summarise(count = n_distinct(customer_unique_id))

# identificando a cidade com mais clientes
customers %>%
  group_by(customer_city) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  filter(count == max(count))

# identificando as cidades com menos clientes
customers %>%
  group_by(customer_city) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  filter(count == min(count))

# Calculando o percentual de clientes por estado
customers %>%
  group_by(customer_state) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  mutate(percent_client = count/sum(count)*100)

# Selecionando o percentual de clientes por estado
customers %>%
  group_by(customer_state) %>%
  summarise(count = n_distinct(customer_unique_id)) %>%
  mutate(percent_client = count/sum(count)*100) %>%
  select(customer_state, percent_client)

# ------------------------------- #

#### Join ####

orders <- read_csv("https://raw.githubusercontent.com/brunolucian/CursoIntermediarioR/main/Dados/olist_orders_dataset.csv")
products <- read_csv("https://raw.githubusercontent.com/brunolucian/CursoIntermediarioR/main/Dados/olist_products_dataset.csv")
items <- read_csv("https://raw.githubusercontent.com/brunolucian/CursoIntermediarioR/main/Dados/olist_order_items_dataset.csv")

## inner join ####
# retorna todas as linhas de x onde há valores
# correspondentes em y, e todas as colunas de x e y
# (interseção). Se houver várias correspondências
# entre x e y, todas as combinações das
# correspondências serão retornadas.
inner <- inner_join(orders, items, by="order_id")

## left join ####
# retorna todas as linhas de x e todas as colunas de
# x e y. As linhas em x sem correspondência em y
# terão valores NA nas novas colunas. Se houver
# várias correspondências entre x e y, todas as
# combinações das correspondências serão retornadas.
left <- left_join(orders, items, by="order_id")


## right join ####
# retorna todas as linhas de y e todas as colunas de
# x e y. As linhas em y sem correspondência em x
# terão valores NA nas novas colunas. Se houver
# várias correspondências entre x e y, todas as
#combinações das correspondências serão retornadas.
right <- right_join(items, products, by="product_id")

## full join ####
# retorna todas as linhas e colunas dos dois conjunto
# de dados (soma)
full <- full_join(customers, orders, by="customer_id")
# copy = FALSE
# suffix = c(".x", ".y")

