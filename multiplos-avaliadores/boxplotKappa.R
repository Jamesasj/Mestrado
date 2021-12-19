# Boxplot of MPG by Car Cylinder
setwd("C:\\PROJETOS\\avaliacao_pares_professor")
dados <- data.frame(criterio = c(1,2,3,1,2,3,1,2,3),
                    professorA = c(1,1,1,2,2,2,3,3,3),
                    professorB = c(2,2,2,3,3,3,4,4,4),
                    kappa = c (0.5,1,0.1,0.3,0.4,1,1,1,1))
jpeg("coeficienteKappa.jpg")
boxplot(kappa~criterio,data=dados, 
        xlab="Critério", ylab="Coeficiente Kappa")
dev.off()