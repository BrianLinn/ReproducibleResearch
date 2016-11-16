#plotting practice


#Clear the environment
rm(list = ls())

#Ensure there is a data folder in the working directory to store the files
if(!exists("./data")){dir.create("./data")}

##read the data into R
data <- read.csv("./data/payments.csv")

dataNy <- subset(data, grepl("NY", data$Provider.State))
remove(data)

#turn on graphics deveice for pdf
pdf(file = "nyPlot.pdf")

#plot1
with(dataNy, plot(Average.Covered.Charges, Average.Total.Payments,
                  pch = 19, col = "steelblue",
                  xlab = "Average Covered Charges", 
                  ylab = "Average Total Payments",
                  main = "New York Medical Expenditures",
                  axes = F,
                  panel.first = c(abline(lm(dataNy$Average.Total.Payments ~ 
                                                dataNy$Average.Covered.Charges),
                                col = 'red'))))
axis(side = 1, at = axTicks(1), labels = format(axTicks(1), big.mark = ","))
axis(side = 2, at = axTicks(2), labels = format(axTicks(2), big.mark = ","))
box(lty = 'solid', col = "black")
legend("bottomright", legend = c("Average Payments by Average Charges",
                                 "Linear Model"),
       col = c("steelblue", "red"), lty = c(NA, 'solid'), pch = c(19,NA),
       cex = 0.8)

#Turn off the pdf graphics device
dev.off()


