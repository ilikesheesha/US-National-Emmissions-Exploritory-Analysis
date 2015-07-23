# Script to show how the emissions from motor vehicle sources have changed from 1999–2008 in Baltimore City.
# The script creates plot5.png
#
# OUtline:
#   1. Download the US National Emissions data if not available in the current working folder
#   2. Extract the US National Emissions data if not in the current working folder

# Data file constants
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataZipFile <- "NEI_data.zip"
classification_file <- "Source_Classification_Code.rds"
pm25_file <- "summarySCC_PM25.rds"

# 1. Download the US National Emissions data if not available in the current working folder
if ((!file.exists(classification_file) | !file.exists(pm25_file)) &
    !file.exists(dataZipFile)) {
    download.file(url = dataUrl,
                  destfile = dataZipFile,
                  mode = "wb")
}

# 2. Extract the US National Emissions data if not in the current working folder
if ((!file.exists(classification_file) | !file.exists(pm25_file)) &
    file.exists(dataZipFile)) {
    unzip(dataZipFile, exdir = ".")
}
