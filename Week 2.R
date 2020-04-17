set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10),"var3"=sample(11:15))
X
X <- X[sample(1:5),]; X$var2[c(1,3)]=NA
X

X[X$var2>8,]

a <- data.frame ("var1"=sample(1:100, 20), "var2"=sample(6:88,20), "var3"=sample(98:154,20))
head(a)
arrange(a,desc(var1))