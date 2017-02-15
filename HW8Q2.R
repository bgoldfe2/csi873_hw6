# CSI 674
# Bruce Goldfeder
# HW #8 April 20, 2016
# Question #2

d1 <- c(90,76,90,64,86,51,72,90,95,78)

d2 <- c(73,102,118,104,81,107,100,87,117,111)

d3 <- c(107,95,97,80,98,74,74,67,89,58)

d4 <- c(98,74,56,111,95,88,82,77,86,92)


dAll <- cbind(d1,d2,d3,d4)
length(dAll)

# Data entered above, define the variables 
# Set directory to location of data file rats.txt

nS = ncol(dAll)      # Number of diets
nr <- nrow(dAll)   # Number of rats in each diet group


g <- array(0,c(4,2))


# Calculate the mean for each study
for (k in 1:nS) {
  m = mean(dAll[,k])
  sd = sd(dAll[,k])
#  d = paste(m," - ",sd)
#  print(d)
  
  g[k,1] <- m
  g[k,2] <- sd
  
}
n = 10              # number of samples in each diet
mu = sum(g[,1])/4   # prior mean mu average of sample means
sigma = sum(g[,2])/4  # observation standard deviation sigma

tau = sd(g[,1])     # prior tau sd of set of 4 group means

for (j in 1:nS) {
  
  mu_star = (mu/tau^2 + sum(dAll[,j])/sigma^2)/(1/tau^2 + n/sigma^2)
  tau_star = 1/sqrt((1/tau^2 + n/sigma^2))  # negative 1/2 exponent
  mu = mu_star
  tau= tau_star
}

qnorm(.025,mu,tau)
qnorm(.975,mu,tau)
