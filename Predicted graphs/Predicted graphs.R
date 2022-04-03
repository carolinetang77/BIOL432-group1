# Created by Caroline Tang 20115082
# Predicted graphs

library(ggplot2)
library(tidyverse)

# Boxplot of transmission vs mutation rate ---------------
# Create fake data on transmission and mutation rates
set.seed(1)
nullViruses <- data.frame(group = rep("H0", 50),
                          transmission = rep(c("aerosolic", "vector", "body fluids", "fecal-oral", "blood/sexual"), 10),
                          mutation = c(rnorm(50, 0.01, 0.001)))

# Create fake data with one method higher than the rest 
biasedViruses <- data.frame(group = rep("HA", 50),
                            transmission = rep(c("aerosolic", "vector", "body fluids", "fecal-oral", "blood/sexual"), 10),
                            mutation = c(rnorm(50, 0.01, 0.001)))
biasedViruses$mutation[biasedViruses$transmission == "vector"] <- biasedViruses$mutation[biasedViruses$transmission == "vector"] * 1.1

#Bind two groups together
viruses <- rbind(nullViruses, biasedViruses)
viruses$group <- factor(viruses$group, levels = c("H0", "HA"))

# Create boxplot
png("Predicted graphs/transmission-vs-mutation.png", width = 6, height = 4, units = "in", res = 300)
ggplot(data = viruses, aes(x = transmission, y = mutation, fill = transmission)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = "Transmission method", y = "Mutation rate") +
  facet_grid(rows = vars(group))
dev.off()

# Scatterplot of GC content vs mutation rate --------------
png("Predicted graphs/gc-vs-mutation.png", width = 5, height = 4, units = "in", res = 300)
ggplot() +
  stat_function(fun = function(x){x * 0.01}) +
  labs(x = "GC Content", y = "Mutation Rate") +
  theme_bw()
dev.off()
