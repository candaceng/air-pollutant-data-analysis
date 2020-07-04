# read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 1
yearly_emissions <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)
png("plot1.png", width=480, height=480)
with(yearly_emissions, plot(x = year, y = x, type="l", ylab = "Total Annual Emissions (tons)",xlab = "Year", main = "Total Emissions in the US by Year", col = "red"))
dev.off()

# Plot 2
baltimore <- subset(NEI, NEI$fips=="24510")
baltimore_yearly <- aggregate(baltimore$Emissions, by=list(baltimore$year), FUN=sum)
png("plot2.png", width=480, height=480)
with(baltimore_yearly, plot(x = Group.1, y = x, type="l", ylab="Total Annual Emissions (tons)", xlab="Year", main="Total Emissions in Baltimore by Year", col="blue"))
dev.off()

# Plot 3
library(ggplot2)
baltimore_type <- aggregate(baltimore$Emissions, by=list(baltimore$type, baltimore$year), FUN=sum)
colnames(baltimore_type) <- c("Type", "Year", "Emissions")
png("plot3.png", width=480, height=480)
qplot(Year, Emissions, data=baltimore_type, color=Type, geom="line")
    + ggtitle("Total Emissions by Type")
    + ylab("Total Emissions (tons)")
    + xlab("Year")
dev.off()

# Plot 4
coal <- SCC[grepl("Coal", SCC$Short.Name),]
coal_data <- NEI[NEI$SCC %in% coal$SCC,]
coal_yearly <- aggregate(coal_data$Emissions, by=list(coal_data$year), FUN=sum)
colnames(coal_yearly) <- c("Year", "Emissions")
png("plot4.png", width=480, height=480)
plot(coal_yearly$Year, coal_yearly$Emissions, xlab="Year", type="h", ylab="Emissions", main="Annual Coal Related Emissions", col="red")
dev.off()