plot(dnorm,-3,3)
plot(pnorm,-3,3)

h = pnorm(10,100, 10,lower.tail = FALSE)

x <- seq( 70, 130, len=100)
Fd <- dnorm(x , 100, 10)
q5 = qnorm(0.05, 100, 10)
q95 = qnorm(0.95, 100, 10)

plot(x, Fd, type = 'l')
cord.x <- c(70,seq(70,80,1),80) 
cord.y <- c(0,dnorm(seq(70,80,1), 100, 10),0) 
polygon(cord.x,cord.y,col='skyblue')

x <- seq(5, 15, length=1000)
y <- dnorm(x, mean=10, sd=3)
plot(x, y, type="l", lwd=1)

cord.x <- c(-3,seq     (-3,-2,0.01),-2)
cord.y <- c(0,dnorm(seq(-3,-2,0.01)),0)

curve(dnorm(x,0,1),xlim=c(-3,3),main='Normal padrao')
polygon(cord.x,cord.y,col='skyblue')
