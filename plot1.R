# Script showing the trend in total PM2.5 emissions in the United States between 1999 to 2008.
# This script outputs plot1.png.

# Data file constants
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataZipFile <- "NEI_data.zip"
scc_file <- "Source_Classification_Code.rds"
pm25_file <- "summarySCC_PM25.rds"

# Load required libraries
if (!require(dplyr)) {
    install.packages("dplyr")
}

# Download the US National Emissions data if not available in the current working folder
if ((!file.exists(scc_file) | !file.exists(pm25_file)) &
    !file.exists(dataZipFile)) {
    download.file(url = dataUrl,
                  destfile = dataZipFile,
                  mode = "wb")
}

# Extract the US National Emissions data if not in the current working folder
if ((!file.exists(scc_file) | !file.exists(pm25_file)) &
    file.exists(dataZipFile)) {
    unzip(dataZipFile, exdir = ".")
}

# Read the pm 2.5 data
#   NOTE: Only read the data if the data variable does not exist or does not have the expected dimensions
#         This was used to make the repeated execution of the script quicker.
if (!exists("pm25")) {
    pm25 <- tbl_df(readRDS(pm25_file))
} else if ((dim(pm25)[1] != 6497651) |
    (dim(pm25)[2] != 6)) {
    pm25 <- tbl_df(readRDS(pm25_file))
}

# Summarize the pm 2.5 emissions by year and convert to KiloTonnes
pm25_summary <- group_by(pm25, year) %>%
    summarise(Emissions = sum(Emissions) / 1000)

# Create plot
png(file = "plot1.png", width = 640, height = 640, units = "px")
with (pm25_summary, {
    plot(year, 
         Emissions, 
         type = "n",
         main =  expression("Total " * PM[2.5] * " emissions from 1999 to 2008 for the United States"),
         xlab = "Year",
         ylab = expression(PM[2.5] * " Emissions (KiloTonnes)"))
    points(year, Emissions, pch = 19,  col = "blue", cex = 1.2)
    text(year, Emissions, labels = round(Emissions, 2), cex = 0.9, adj = c(0.5, -0.4))
    lines(year, Emissions, lty = "dashed", col = "blue", lwd = 1)
    abline(lm(Emissions ~ year), col = "steelblue", lwd = 2)
    legend("topright", c("Linear Trend"), col = c("steelblue"), lty = "solid", lwd = 2)
})
dev.off()
