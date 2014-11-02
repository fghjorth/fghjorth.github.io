setwd("/Users/frederikhjorth/GitHub/fghjorth.github.io")
pf<-read.csv("peffleyhurwitz.csv",sep=";",dec=",")
require(ggplot2)
png("pf.png",height=240)
ggplot(pf,aes(x=blackster,y=noinner)) +
  geom_smooth(method="loess",color="dark gray") +
  geom_smooth(aes(y=inner),method="loess",color="#666666") +
  theme_bw() +
  xlab("Negative black stereotypes") +
  ylab("Pr(Favor prisons)") +
  annotate("text", x=18, y=.5, label = "\"inner city\"") +
  annotate("text", x=21, y=.22, label = "no \"inner city\"",color="#666666")
dev.off()

