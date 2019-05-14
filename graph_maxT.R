library(ggplot)
library(Rmisc)


rm(list=ls())

setwd("C:/Users/cbird/Texas A&M University - Corpus Christi/Hamilton, Ashley - AshleyHamilton_MS/HawaiiTemp/data")
maxT <- read.table("maxT.dat", sep="\t", header=FALSE)
maxT <- maxT[which(maxT$V9 != "NearShore"),]
maxT <- maxT[which(maxT$V5 != "Midway"),]

boxplot(maxT$V4~maxT$V14)

ggplot(maxT, aes(x=V14, y=V4, color=as.factor(V10)))+
  facet_grid(cols = vars(V10)) +
  geom_point(shape=1) +    # Use hollow circles
  geom_smooth(method=lm, se=FALSE, na.rm = TRUE)            # Add a loess smoothed fit curve with confidence region

mean_maxT <- summarySE(maxT, measurevar="V4", groupvars=c("V14","V10"), na.rm=TRUE)
ggplot(mean_maxT, aes(x=V14, y=V4, colour=V10)) + 
  geom_errorbar(aes(ymin=V4-se, ymax=V4+se), width=.1) +
  #geom_smooth(method=loess,se=FALSE, na.rm = TRUE, span=1) +
  #geom_smooth(method=lm, se=FALSE, na.rm = TRUE, formula = y ~ x**2 + x) +           # Add a loess smoothed fit curve with confidence region
  geom_point()
