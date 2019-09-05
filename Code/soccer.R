p0 <- c(0.1, 0.8, 1) # Behauptungen
priori <- c(1/3, 1/3, 1/3)

n <- 1 # Anzahl Elfmeter
x <- 1 # Anzahl Treffer

post <- priori * dbinom(x, n, p0) 
post / sum(post) 
