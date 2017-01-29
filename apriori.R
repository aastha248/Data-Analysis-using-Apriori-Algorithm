my_data <- read.table("C:\\Users\\Aastha\\Documents\\test_data.txt", sep=",", header = TRUE)
attach(my_data)
names(my_data)
library(arules)
rules <- apriori(my_data, parameter=list(support=0.06, confidence=0.7))
inspect(rules)
rules.sorted <- sort(rules, by="lift")
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
library(arulesViz)
plot(rules.pruned)