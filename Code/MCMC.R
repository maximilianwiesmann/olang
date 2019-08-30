# Reading in the data
n <- 100 # number of tosses
x <- 50	# number of heads obtained

# Initialize the Markov Chain
alpha <- 1 
beta <- 1 
p <- runif(1, 0, 1) # random starting value between 0 and 1

# Likelihood function
likelihood <- function(x, n, p){  
  lh <- dbinom(x, n, p) # binomial probability
  return(lh)  
} 

# Prior distribution
priorDistribution <- function(p) {
  prior <- dbeta(p, alpha, beta)
  return(prior)
}

posterior <- data.frame() # for storing accepted p values
iter <- 10000 # length of the loop

# Start loop MCMC
for (i in 1:iter){
  
  # New proposal value for p  in range 0 - 1
  p_prime <- p + runif(1, -0.05, 0.05)  
  if (p_prime < 0) p_prime <- abs(p_prime)
  if (p_prime > 1) p_prime <- 2 - p_prime
  
  # Acceptance probability
  R <- likelihood(x, n, p_prime) / likelihood(x, n, p) * (priorDistribution(p_prime)/priorDistribution(p))  
  
  # Accept or reject the new value of p  
  if (R > 1) R <- 1
  random <- runif (1, 0, 1) # random number between 0 and 1
  if (random < R) p <- p_prime  # update p
    
  # Store the likelihood of the accepted p and its value  
  posterior[i, 1] <- log(likelihood(x, n, p))  
  posterior[i, 2] <- p  
  print(i)
}

# Plot results
par(mfrow= c(1,2))  # display multiple plots
prior <- rbeta(iter, alpha, beta)  

plot(1:iter, posterior$V2, cex = 0, xlab = "generations", ylab = "p",  
     main = paste("trace of MCMC\n accepted values of parameter p\n prior = beta(", alpha, ",", beta, 
                  ")\n generations = ", iter, sep = ""))  
lines(1:iter, posterior$V2, cex = 0)  
abline(h = mean(posterior$V2), col = "red")  

plot(density(posterior$V2), 
     xlim = c(min(min(prior), min(posterior$V2)), max(max(prior), max(posterior$V2))),   
     ylim = c(0, max(max(density(prior)$y), max(density(posterior$V2)$y))), 
     main = paste("prior VS posterior\n prior = beta(", alpha, ",", beta, ")", sep = ""),  
     lwd = 3, col = "red")  
lines(density(prior), lwd = 3, lty = 2, col = "blue")  
legend("topleft", legend = c("prior density", "posterior density"),  
       col = c("blue","red"), lty = c(3,1), lwd = c(3,3), cex = 1)  
