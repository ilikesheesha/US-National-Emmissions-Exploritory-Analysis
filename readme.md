# US National Emissions Exploratory Analysis
This repository is in partial fulfillment of the second course project of the **<a href="https://www.coursera.org/course/exdata" target="_blank">Coursera Exploratory Data Analysis</a>** Course.

##Purpose of Project
The purpose of the project was to demonstrate an ability to answer various questions about data visually using various plotting methods provided in the R ecosystem.

#Data Used
The Fine Particulate (PM2.5) database from the National Emissions Inventory (NEI) was used in this project. More information about the NEI can be found at the **<a href="http://www.epa.gov/ttn/chief/eiinformation.html" target="_blank">EPA National Emissions Inventory web site</a>**.

##Project Requirement
The project requirement was to explore the following 6 questions, and to create an R script for each question that outputs a graphical representation of the data, providing an answer to the question. The six questions were:

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
	* Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
	* Use the base plotting system to make a plot answering this question.
3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonrandom) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
	* Use the ggplot2 plotting system to make a plot answer this question.
4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

##Project Output
Each question has an associated script that filters and summarizes the PM2.5 data appropriately and outputs a graph that provides an answer to the question. There are 6 scripts and 6 associated graphs in png format, namely:

* [plot1.R](plot1.R) - Answers question 1 and outputs the graph [plot1.png](plot1.png)
* [plot2.R](plot2.R) - Answers question 2 and outputs the graph [plot2.png](plot2.png)
* [plot3.R](plot3.R) - Answers question 3 and outputs the graph [plot3.png](plot3.png)
* [plot4.R](plot4.R) - Answers question 4 and outputs the graph [plot4.png](plot4.png)
* [plot5.R](plot5.R) - Answers question 5 and outputs the graph [plot5.png](plot5.png)
* [plot6.R](plot6.R) - Answers question 6 and outputs the graph [plot6.png](plot6.png)
