p0 <- c(0.1, 0.8, 1)
priori <- c(1/3, 1/3, 1/3)

n <- 1
x <- 1

post <- priori * dbinom(x, n, p0)
post / sum(post)
