## ---- message=FALSE--------------------------------------
library(reprex)

reprex({
  (y <- 1:4)
  mean(y)
}, style = TRUE)


## --------------------------------------------------------
(y <- 1:4)
#> [1] 1 2 3 4
mean(y)
#> [1] 2.5


## ---- eval=FALSE-----------------------------------------
## 
## mean(meus_dados$y)
## 


## --------------------------------------------------------
reprex({mean(meus_dados$y)})

## ---- eval=FALSE-----------------------------------------
## mean(meus_dados$y)
## #> Error in mean(meus_dados$y): objeto 'meus_dados' não encontrado


## ----setup, include=FALSE--------------------------------
knitr::opts_chunk$set(collapse = TRUE, fig.align = "center")
library(glue)
library(tidyverse)


## ---- echo=FALSE-----------------------------------------
knitr::include_graphics("fig/img_str.png")


## --------------------------------------------------------
str_length("São Paulo")
str_length(c("São Paulo", "Rio de Janeiro", 
             "Rio Grande do Norte", "Acre"))


## --------------------------------------------------------
estados <- c("São Paulo", "Rio de Janeiro", 
       "Rio Grande do Norte", "Acre")
str_length(estados)
length(estados)


## --------------------------------------------------------
s <- "Hoje é um lindo dia, para SALVAR Vidas!"
str_to_lower(s)
str_to_upper(s)
str_to_title(s)


## --------------------------------------------------------
espacados <- c("M", "F", "F", " M", " F ", "M")
as.factor(espacados)


## --------------------------------------------------------
string_aparada <- str_trim(espacados)
as.factor(string_aparada)


## --------------------------------------------------------
vetor_sujo <- c("01-Feminino", "02-Masculino", "03-Indefinido")


## --------------------------------------------------------

str_sub(vetor_sujo, start = 4) 



## --------------------------------------------------------

str_sub(vetor_sujo, end = 2) 



## --------------------------------------------------------
vetor_sujo_inv <- c("Feminino-01", "Masculino-02", "Indefinido-03")
str_sub(vetor_sujo_inv, end = -4)
str_sub(vetor_sujo_inv, start = -2)


## --------------------------------------------------------
uf_no_texto <- c("__SP__", "__MG__", "__RJ__")
str_sub(uf_no_texto, 3, 4)


## --------------------------------------------------------
string1 <- "O valor p é: "
string2 <- 0.03
str_c(string1, string2) 


## --------------------------------------------------------
string1 <- "modo"
string2 <- "pouco"
string3 <- "amar"
str_c("Cada qual sabe amar a seu", string1,"; o ",string1, string2," importa; o essencial é que saiba", string3, ".")


## --------------------------------------------------------
str_c("Cada qual sabe amar a seu", string1,"; o ",string1, string2," importa; o essencial é que saiba", string3, ".",sep = " ")


## --------------------------------------------------------
string1 <- c("R", "SPSS")
string2 <- c("bom", "ruim")
string3 <- c("melhor", "pior")
str_c(string1, " é a prova de que não existe nada tão ", string2,
      " que não pode ficar ", string3, ".")


## --------------------------------------------------------
str_detect("sao paulo", pattern = "paulo$")
str_detect("sao paulo sp", pattern = "paulo$")


## ---- message=FALSE, warning=FALSE, include=FALSE--------
s <- c('ban', 'banana', 'abandonado', 'pranab anderson', 'BANANA', 
            'ele levou ban')
expressoes <- list(
  'ban', # reconhece tudo que tenha "ban", mas não ignora case
  'BAN', # reconhece tudo que tenha "BAN", mas não ignora case
  'ban$', # reconhece apenas o que termina exatamente em "ban"
  '^ban', # reconhece apenas o que começa exatamente com "ban"
  'b ?an' # reconhece tudo que tenha "ban", com ou sem espaço entre o "b" e o "a"
)


## ---- echo=FALSE, message=FALSE, warning=FALSE-----------

list(strings = s, expressoes = expressoes) %>%
  cross_df() %>%
  distinct() %>%
  mutate(detect = str_detect(s, expressoes)) %>%
  spread(expressoes, detect) %>%
  knitr::kable()


## --------------------------------------------------------
library(stringr)
str_detect("sao paulo", pattern = "paulo$")
str_detect("sao paulo sp", pattern = "paulo$")


## --------------------------------------------------------
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")
str_replace(cidades, "S[.]", "São")


## --------------------------------------------------------
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")
str_replace(cidades, "S.", "São")


## --------------------------------------------------------
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")
str_replace(cidades, fixed("S."), "São")


## --------------------------------------------------------
cpf <- c("303.030.111-33", "102-177-011-20", "987.220.199.00")
str_replace_all(cpf, "[.-]", " ")


## --------------------------------------------------------
r_core_group <- c(
  'Douglas Bates', 'John Chambers', 'Peter Dalgaard',
  'Robert Gentleman', 'Kurt Hornik', 'Ross Ihaka', 'Tomas Kalibera',
  'Michael Lawrence', 'Friedrich Leisch', 'Uwe Ligges', '...'
)
sobrenomes <- str_extract(r_core_group, '[:alpha:]+$')
sobrenomes


## --------------------------------------------------------
texto <- 'Somos autores e protagonistas da nossa própria história, cada página é cada dia, os amores são os momentos e oportunidades são os capítulos... Façamos que essa nossa história se torne um bom livro de vida. Que cada momento seja bem aproveitado, é muito mais prazeroso o ato do fazer acontecer do que a frustração do não tentar. Que os olhares sejam lançados e trocados, que sorrisos sejam esbanjados e eternizados em nossas faces. Não há nada
melhor que o abraço de uma saudade, ombro de um amigo e o gosto de um gostar... Amigos são a família que Deus nos permitiu escolher, que façamos nossas escolhas e na companhia deles possamos desfrutar, aproveitar, compartilhar e manter aquele sentimento tão bom o qual deram o nome de AMIZADE. Que a gente aprenda a rir de nós mesmos, que possamos dar altas gargalhadas, que gritemos nossos medos, saibamos cantar nossas saudades e dançar rodopiando nossas alegrias... Que possamos dar asas a nossa imaginação e espaço a nossas mais puras lembranças, pois estas, as quais nos acompanham, nos engrandecem de alguma forma e nos fazem perceber que a vida é muito. Que percebamos o mais simples entre os mais exuberantes, a mais simples criação, o mais simples gesto, o mais simples ato... Que a gente aprenda a perdoar e acima de tudo que possamos viver sabendo AMAR! Os amores vem e vão, nem tudo é tão certo, nem tudo é pra sempre... E há quem diga,assim como o poeta, que mesmo aquele amor que não compensa é melhor que a solidão. E quando a tristeza bater, a dúvida insistir e a saudade apertar, devemos lembrar que somos apenas humanos sujeitos à erros e falhas, mas com capacidade de superação e aprendizagem. Que nossas histórias sejam bem escritas e que nunca deixemos de viver por medo de errar. Tudo passa tão rápido e o tudo e imensuravelmente importante. O tempo não retroage. Que aproveitemos cada momento e o que dele vier, cada minuto, cada pessoa, cada palavra, cada abraço, cada beijo. Que contemos nossa idade, não por anos que foram completados, mas por momentos únicos e bem vividos... toda idade tem seu prazer e seu medo! Por fim, que num futuro distante, ao olhar pra traz e ao ler toda a nossa história, possamos simplesmente dizer: que se problemas tivemos,dificuldade passamos e tristeza sentimos, não foi por falta do tal sentimento, o qual deram o nome de felicidade. Isso é um pouquinho do viver.'
str_split(texto, fixed('.'))


## --------------------------------------------------------
str_split_fixed(texto, fixed('.'), 3)


## --------------------------------------------------------
frases <- c('a roupa do rei', 'de roma', 'o rato roeu')
str_subset(frases, 'd[eo]')


## --------------------------------------------------------
frases[str_detect(frases, "d[eo]")]


## ----ex="exercicio_02", type="sample-code"---------------
input <- c("01 - Alto", "02 - Médio", "03 - Baixo")
result <- c('Alto', 'Médio', 'Baixo')


## ----ex="exercicio_03", type="sample-code"---------------
input <- c('Casa', 'CASA', 'CaSa', 'CAsa')


## ----ex="exercicio_04", type="sample-code"---------------
url <- c('/rj/sao-goncalo/xpto-xyz-1-0-1fds2396-5')

