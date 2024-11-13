suppressWarnings(source("scripts/01_tratamento.R", encoding = "UTF-8"))
library(corrplot)
# análises ----------------------------------------------------------------

# Calcular a média e o desvio padrão de cada coluna
medias <- colMeans(base_var, na.rm = TRUE)
desvios <- apply(base_var, 2, sd, na.rm = TRUE)

# Criar uma tabela com as médias e desvios padrão
tabela_resultados <- data.frame(
 Variavel = c("IMOB", "IBOVESPA", "TRIS3"),
 Media = round(medias, 4),
 Desvio_Padrao = round(desvios, 4)
)

# Exibir a tabela
tabela_resultados              

# Criar o gráfico de dispersão
plot(tabela_resultados$Desvio_Padrao,
     tabela_resultados$Media, 
     main = "Gráfico de Dispersão com Texto", xlab = "Eixo X", ylab = "Eixo Y", pch = 19)

# Adicionar texto nos pontos
text(tabela_resultados$Desvio_Padrao,
     tabela_resultados$Media,
     labels = tabela_resultados$Variavel, pos = 4)

# Calcular a matriz de correlação
matriz_cor <- cor(base_var)

# Criar o gráfico de matriz de correlação
corrplot(matriz_cor, 
         method = "number", 
         type = "lower",  # Exibe somente a metade inferior
         diag = TRUE,     # Exibe a diagonal
         tl.cex = 0.8,    # Tamanho do texto
         number.cex = 1)
