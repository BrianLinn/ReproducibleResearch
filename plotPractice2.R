#plotting practice
#Clear the environment
rm(list = ls())

#Ensure there is a data folder in the working directory to store the files
if(!exists("./data")){dir.create("./data")}

##read the data into R
data <- read.csv("./data/payments.csv")

##add the data code from DRG.Definition to a new column
data$DRG.Code <- substring(data$DRG.Definition, 1, 3)

#assign the colors to a variable
colors = unique(data$DRG.Code)

#turn on graphics deveice for pdf
pdf(file = "medPlot.pdf")

#set the display to 3 rows and 2 columns with margins set
par(mfrow = c(3, 2), mar = c(5, 4, 2, 1))

#create a plot for each unique state detailing charges by payments
#use colors for the points
#use i which is equal to state to label each plot
for (i in unique(data$Provider.State)) {
        d <- subset(data, data$Provider.State == i)
        plot(d$Average.Covered.Charges, d$Average.Total.Payments, 
             pch = 19, 
             col = colors, 
             xlab = "Average Covered Charges",
             ylab = "Average Total Payments",
             main = i,
             axes = F,
             panel.first = c(abline(lm(d$Average.Total.Payments ~ 
                                               d$Average.Covered.Charges),
                                col = 'red')))
        axis(side = 1, at = axTicks(1), labels = format(axTicks(1), big.mark = ","))
        axis(side = 2, at = axTicks(2), labels = format(axTicks(2), big.mark = ","))
        box(lty = 'solid', col = "black")
        
}

##thanks to a clever classmate for the technique on inserting one legend for all plots
#reset margins etc to minimum for legend
par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), new = TRUE)
#dummy plot to insert legend
plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
#add legend using the same colors below all plots as legend applies to all
legend("bottom", xpd = TRUE, horiz = TRUE, inset = c(2, 0),
       legend = paste(levels(as.factor(substr(data$DRG.Code,1,3)))),
       bty = "n", pch = 19,
       cex=1.3,
       pt.cex=2,
       xjust=1,
       title="DRG Codes",
       col = colors)

#Turn off the pdf graphics device
dev.off()
