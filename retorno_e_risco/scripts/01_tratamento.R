
# bibliotecas -------------------------------------------------------------

library(tidyverse)
library(dplyr)


# leitura de bases --------------------------------------------------------

imob <- read.csv("data/IMOB.csv") %>% 
  janitor::clean_names()

ibov <- read.csv("data/IBOVESPA.csv") %>% 
  janitor::clean_names()

tris <- read.csv("data/TRIS3.csv") %>% 
  janitor::clean_names()

# tratamento --------------------------------------------------------------
setdiff(tris$data, imob$data)

tris <- tris %>% 
  filter(!(data %in% setdiff(tris$data, imob$data))) %>% 
  rename_with(~ paste0(., "_tris"), -data)

base <- left_join(imob, ibov, by = "data", suffix = c("_imob", "_ibov"))
base <- left_join(base, tris, by = "data", suffix = c("", "_tris")) 

base <- base %>%
  mutate_all(~ gsub("%", "", .)) %>% 
  mutate_all(~ gsub(",", ".", .)) %>% 
  mutate_all(~ gsub("[A-Za-z]", "", .)) %>% 
  mutate(across(-data, ~ as.numeric(.)))


base_var <- 
  base %>% 
  select(var_imob, 
         var_ibov, 
         var_tris) 
  
