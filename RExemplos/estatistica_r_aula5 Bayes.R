# install.packages("tidyverse", dependencies = TRUE)
# install.packages("BayesFactor")
# install.packages("brms")

library("tidyverse") #carregar pacote

setwd("C:/PROJETOS/RExemplos/" )
dados_brasil <- read.csv("Pesquisa-Brasil-e-Espanha-fusionado.csv")

dados_brasil <- dados_brasil %>% 
  mutate(bsq_soma = rowSums(.[45:78], na.rm = T)) %>% 
  mutate(sexo = if_else(sexo == "1","Mulheres","Homens")) %>%
  drop_na(sexo) %>% 
  mutate(mulheres = if_else(sexo == "Mulheres",1,0)) %>%
  mutate(eat_soma= rowSums(.[19:44], na.rm=T)) %>%
  mutate(imc = peso_atual/(altura^2))


#plotar
vert_line <- dados_brasil %>% group_by(sexo) %>% summarise(mm = mean(bsq_soma))

ggplot(dados_brasil, 
       aes(x = bsq_soma, fill = sexo)) + 
  geom_density(alpha = .5) +
  geom_vline(data=vert_line, aes(xintercept=mm, color=sexo))

#Teste T
#Ambiente R-Base
t.test(bsq_soma ~ mulheres, 
       alternative = c("two.sided"), 
       data=dados_brasil)

t.test(dados_brasil$bsq_soma[dados_brasil$mulheres==0],
       dados_brasil$bsq_soma[dados_brasil$mulheres==1])

library("BayesFactor")

dados_brasil <- data.frame(dados_brasil)
reg_bsq <- lmBF(bsq_soma ~ mulheres, data = dados_brasil) 
chains <- posterior(reg_bsq, iterations = 10000)

dados_brasil %>% 
  summarise(mean(bsq_soma[mulheres==1]) - mean(bsq_soma[mulheres==0]))

samples <- ttestBF(x = dados_brasil$bsq_soma[dados_brasil$mulheres==0],
                  y = dados_brasil$bsq_soma[dados_brasil$mulheres==1], paired=FALSE,
                  posterior = TRUE, iterations = 1000)

b_posterior <- data.frame(samples)

ggplot(b_posterior, aes(x=mu)) + 
  geom_density()

plot(samples[,"mu"])

bsq_regress <- dados_brasil %>% select(bsq_soma, mulheres, idade, 
                                       faz_esporte, familia_esporte, eat_soma, imc) %>%
  drop_na()

#Regressão linear
bsq_regress <- data.frame(bsq_regress)
rl <- lm(data=bsq_regress, bsq_soma ~. ) 
summary(rl)

bf <- regressionBF(bsq_soma ~ ., data = bsq_regress)
length(bf) #Quantas compara??es ? poss?vel fazer (2^p)-1
bf
plot(bf)

bf2 <- lmBF(bsq_soma ~ mulheres + eat_soma, data = bsq_regress)
chains = posterior(bf2, iterations = 10000)
summary(chains)
plot(bf2)

summary(lm(bsq_soma ~ mulheres + eat_soma, data = bsq_regress))

# Luis Anunciacao, 2017
# This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
#https://creativecommons.org/licenses/by-nc-sa/4.0/

#no site
library(brms)
d <- dados_brasil
mod_eqvar <- brm(bsq_soma ~ mulheres, data = d)
plot(mod_eqvar)
uneq_var_frm <- bf(bsq_soma ~ mulheres, sigma ~ mulheres)
mod_uneqvar <- brm(uneq_var_frm, data = d, cores=4)

# Posterior distribution of Group effect
x <- as.data.frame(mod_uneqvar, pars = "mulheres")[,1]
# Proportion of MCMC samples below zero
round((sum(x < 0) / length(x)), 3)


#no site: http://bayesfactor.blogspot.com/2014/02/bayes-factor-t-tests-part-1.html
improvements <- dados_brasil %>% filter(mulheres == 1) %>% select(bsq_soma)
ggplot(improvements, aes(x=bsq_soma)) + geom_histogram()
t.test(improvements$bsq_soma)
N = length(improvements$bsq_soma)
t = mean(improvements$bsq_soma)/sd(improvements$bsq_soma) * sqrt(N)
t
deltaHat = t/sqrt(N)
deltaHat
dt(t, df=length(improvements-1))
ttestBF(improvements$bsq_soma, nullInterval = c(0, Inf))
2*pt(t, 30, lower=FALSE)
dt(t, df = 92, ncp = 1 * sqrt(93))

#no site: 
library(BayesianFirstAid)
j<-bayes.t.test(dados_brasil$bsq_soma[dados_brasil$mulheres==0],dados_brasil$bsq_soma[dados_brasil$mulheres==1],
             conf.level=0.95)
summary(j)
plot(j)
