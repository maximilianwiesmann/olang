library(stats)

par(mfrow = c(3, 2)) # display multiple plots
x = seq(0, 1, by = 0.001) # Probability
alpha = c(1, 2, 0.5, 3, 5, 500)
beta = c(1, 2, 0.5, 0.5, 2, 125.8)
for(i in 1:length(alpha)){
  y <- dbeta(x, shape1 = alpha[i], shape2 = beta[i])
  plot(x, y, main = paste("alpha = ", alpha[i], ", beta = ", beta[i], sep = ""), 
       type = "l", xlab = "theta", ylab = "density")
}