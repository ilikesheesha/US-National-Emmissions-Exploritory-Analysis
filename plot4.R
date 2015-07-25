# Script showing how emissions from coal combustion related sources have changed between 1999 and 2008 
# across the United States.
# This script outputs plot4.png.

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

# Read the Source Classification Data (SCC) and filter those sources related to coal and combustion
#   NOTE: Only read the data if the data variable does not exist or does not have the expected dimensions
#         This was used to make the repeated execution of the script quicker.
if (!exists("scc")) {
    scc <- tbl_df(readRDS(scc_file)) %>%
        mutate(textkey = paste(Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four)) %>%
        filter(grepl("combustion", textkey, ignore.case = TRUE) & grepl("coal", textkey, ignore.case = TRUE))
} else if ((dim(scc)[1] != 104) |
           (dim(scc)[2] != 16)) {
    scc <- tbl_df(readRDS(scc_file)) %>%
        mutate(textkey = paste(Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four)) %>%
        filter(grepl("combustion", textkey, ignore.case = TRUE) & grepl("coal", textkey, ignore.case = TRUE))
}

# Read the pm 2.5 data filtered by the coal combustion sources
#   NOTE: Only read the data if the data variable does not exist or does not have the expected dimensions
#         This was used to make the repeated execution of the script quicker.
if (!exists("pm25")) {
    pm25 <- tbl_df(readRDS(pm25_file)) %>%
        filter(SCC %in% scc$SCC)
} else if ((dim(pm25)[1] != 40742) |
           (dim(pm25)[2] != 6)) {
    pm25 <- tbl_df(readRDS(pm25_file)) %>%
        filter(SCC %in% scc$SCC)
}

# Summarize the pm 2.5 emissions by year and convert to KiloTonnes
pm25_summary <- group_by(pm25, year) %>%
    summarise(Emissions = sum(Emissions) / 1000)

# Create plot
png(file = "plot4.png", width = 640, height = 640, units = "px")
ggplot(data = pm25_summary, aes(year, Emissions)) +
    geom_point(colour = "blue", size = 4) +
    geom_text(aes(label=round(Emissions, digits = 2)), hjust = 1/2, vjust = -1, size = 4) + 
    geom_line(color = "blue", alpha = 1/2, linetype = 2, size = 1) + 
    geom_smooth(color = "steelblue", linetype = 1, size = 1, method = "lm", se = FALSE) +
    labs(title =  expression("Coal Combustion " * PM[2.5] * " emissions from 1999 to 2008 for the United States")) +
    xlab("Year") +
    ylab(expression(PM[2.5] * " Emissions (KiloTonnes)"))
dev.off()
