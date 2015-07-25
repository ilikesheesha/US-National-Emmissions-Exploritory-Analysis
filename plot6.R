# Script showing a comparison of emissions from motor vehicle sources in Baltimore City Maryland 
# (fips == "24510") with emissions from motor vehicle sources in Los Angeles County California 
# (fips == "06037").
# This script outputs plot6.png

# Data file constants
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataZipFile <- "NEI_data.zip"
scc_file <- "Source_Classification_Code.rds"
pm25_file <- "summarySCC_PM25.rds"

# Load required libraries
if (!require(dplyr)) {
    install.packages("dplyr")
}
if (!require(ggplot2)) {
    install.packages("ggplot2")
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

# Read the pm 2.5 data for Baltimore City Maryland (fips == "24510") and Los Angeles County California
# (fips == "06037") filtered by type 'ON-ROAD' where on road emissions are deemed to be motor vehicle
# emissions
#   NOTE: Only read the data if the data variable does not exist or does not have the expected dimensions
#         This was used to make the repeated execution of the script quicker.
if (!exists("pm25")) {
    pm25 <- tbl_df(readRDS(pm25_file)) %>%
        filter((fips == "24510" | fips == "06037") & type == "ON-ROAD") %>%
        mutate(County = ifelse(fips == "24510", "Baltimore City, Maryland", "Los Angeles County, California"))
} else if ((dim(pm25)[1] != 2097) |
           (dim(pm25)[2] != 7)) {
    pm25 <- tbl_df(readRDS(pm25_file)) %>%
        filter((fips == "24510" | fips == "06037") & type == "ON-ROAD") %>%
        mutate(County = ifelse(fips == "24510", "Baltimore City, Maryland", "Los Angeles County, California"))
}

# Summarize the pm 2.5 emissions by year and county and convert to KiloTonnes
pm25_summary <- group_by(pm25, year, County) %>%
    summarise(Emissions = sum(Emissions) / 1000)

# Create plot
png(file = "plot6.png", width = 640, height = 640, units = "px")
ggplot(data = pm25_summary, aes(year, Emissions)) +
    geom_point(aes(color = County), size = 4) +
    facet_wrap(~County, nrow = 1, ncol = 2) +
    geom_text(aes(label=round(Emissions, digits = 2)), hjust = 1/2, vjust = -1, size = 4) + 
    geom_line(aes(color = County), alpha = 1/2, linetype = 2, size = 1) + 
    geom_smooth(aes(color = County), linetype = 1, size = 1, method = "lm", se = FALSE) +
    labs(title =  expression("Motor Vehicle " * PM[2.5] * " emissions from 1999 to 2008 for Baltimore City and Los Angeles County")) +
    xlab("Year") +
    ylab(expression(PM[2.5] * " Emissions (KiloTonnes)")) +
    theme(legend.position = "none")
dev.off()