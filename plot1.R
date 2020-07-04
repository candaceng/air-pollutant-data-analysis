# read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum up emissions by year
yearly_emissions <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

# generate plot
png("plot1.png", width=480, height=480)
with(yearly_emissions, plot(x = year, y = x, type="l", ylab = "Total Annual Emissions (tons)",xlab = "Year", main = "Total Emissions in the US by Year", col = "red"))
dev.off()