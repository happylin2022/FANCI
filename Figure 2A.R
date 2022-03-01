
# library(tidyverse)
library(ggplot2)


data <- dat
data <- read.table("~/file.txt", header = T)
head(data)
#   gene_name      logFC     pvalue      padj
# 1    TSPAN6 -0.1847277 0.70495937 0.8875868
# 2      TNMD -0.5731570 0.66768318 0.8696220
# 3      DPM1  0.3804519 0.33123387 0.6587634
# 4     SCYL3 -0.6330844 0.22489833 0.5537215
# 5  C1orf112  0.0152763 0.98369157 0.9943630
# 6       FGR -1.0904422 0.01899727 0.1463301

data$col <- "no significant"
data$col[data$padj < 0.05 & data$logFC > 2] <- "Up"
data$col[data$padj < 0.05 & data$logFC < -2] <- "Down"
data$col <- factor(data$col, levels = c("Down", "no significant","Up"))

data$size <- 1
data$size[data$padj < 0.05 & data$logFC > 2] <- 2
data$size[data$padj < 0.05 & data$logFC < -2] <- 2



ggplot() +
  geom_point(data = data, aes(logFC, -log10(padj), colour = col, fill = col),
             size = data$size) +
  scale_colour_manual(values = c("#4DBBD5", "grey", "#E64B35"))  +
  geom_vline(xintercept = c(-2, 2), color="grey40", linetype=2) +
  geom_hline(yintercept = -log10(0.05), color="grey40", linetype=2)