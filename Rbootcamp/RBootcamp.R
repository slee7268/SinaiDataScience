####################################
### Welcome to Sinai R Bootcamp! ###
####################################

# Table of Contents:
# DAY 1 - Monday, February 3, 2020
#     1.1 Getting Acquainted with R/RStudio
#     1.2 Basic X-Y Plotting
#     1.3 Bar Charts
#     1.4 Histograms
#     1.5 Scatterplos

# DAY 2 - Wednesday, February 5, 2020

#############################################
### 1.1 Getting Acquainted with R/RStudio ###
#############################################

# WINDOWS
# (1) This is the script/source window
# (2) Below is the console/text output window
# (3) Upper-right is the environment window, which displays variables you are using
# (4) Lower-right contains files, plots, packages, et al.
# Can resize windows by click+dragging borders
# Can rearrange windows by clicking "workspace panes" icon above
# ctrl+1/2/3 zooms into script/console/files(etc) windows, respectively

# PACKAGES
# Bundles of pre-written code
# (1) Base packages = installed with R but not loaded by default
# (2) Contributed packages = 3rd party that need to be downloaded, installed, and loaded separately
# Where to get packages? The Comprehensive R Archive Network (cran.r-project.org)...also Crantastic and GitHub

##############################
### 1.2 Basic X-Y Plotting ###
##############################

# LOAD DATA
library(datasets) # Built-in datasets
head(iris)        # First few rows (sepal & petal dimensions, 3 species)

# PLOT DATA
?plot()                                   # Shows command info in lower-right window
plot(iris$Species)                        # Plot categorical variable
plot(iris$Petal.Length)                   # Plot quantitative variable
plot(iris$Species, iris$Petal.Length)     # Plot x=Species, y=Petal Length
plot(iris$Petal.Length, iris$Petal.Width) # Plot x=Petal Length, y=Petal Width
plot(iris)                                # Plot entire data frame

# PLOT W/ OPTIONS
plot(iris$Petal.Length, iris$Petal.Width,
     col = "#cc0000",                             # Change color of points (hex code)
     pch = 19,                                    # Change style of points
     main = "Iris: Petal Length vs. Petal Width", # Main title
     xlab = "Petal Length",                       # X axis label
     ylab = "Petal Width")                        # Y axis label

# PLOT FORMULAS
plot(cos, 0, 2*pi)  # Cosine 0 to 2pi
plot(exp, 1, 5)     # Exponential, 1 to 5
plot(dnorm, -3, +3) # Normal distribution, -3 to +3

# PLOT FORMULA W/ OPTIONS
plot(dnorm, -3, +3,                         # Same as above
     col = "#cc0000",                       # Change color of points (hex code)
     lwd = 5,                               # Change line width
     main = "Standard Normal Distribution", # Main title
     xlab = "z-scores",                     # X axis label
     ylab = "Density")                      # Y axis label

########################
### 1.3 BAR CHARTS #####
########################

# LOAD DATA
library(datasets) # Built-in datasets
?mtcars           # Motor Trend car road tests
head(mtcars)      # First few rows of dataset

# RECONFIGURE DATA
barplot(mtcars$cyl)            # Doesn't work, need a frequency table
cylinders <- table(mtcars$cyl) # Create table, feed into variable cylinders
barplot(cylinders)             # Proper bar chart
plot(cylinders)                # X-Y plot (lines)

######################
### 1.4 HISTOGRAMS ###
######################

# LOAD DATA
library(datasets) # Built-in datasets
?iris             # Iris sepal and petal dimensions
head(iris)        # First few rows of dataset

# BASIC HISTOGRAMS
hist(iris$Sepal.Length) # Sepal Length
hist(iris$Sepal.Width)  # Sepal Width
hist(iris$Petal.Length) # Petal Length
hist(iris$Petal.Width)  # Petal Width

# HISTOGRAMS BY GROUPS
par(mfrow = c(3,1))                                   # Put graphs in 3 rows, 1 column
hist(iris$Petal.Width [iris$Species == "setosa"],     # SETOSA PETAL WIDTH
     xlim = c(0, 3),                                  # Set x from 0 to 3
     breaks = 9,                                      # Set 9 bars
     col = "red")                                     # Change color
hist(iris$Petal.Width [iris$Species == "versicolor"], # VERSICOLOR PETAL WIDTH
     xlim = c(0, 3),                                  # Set x from 0 to 3
     breaks = 9,                                      # Set 9 bars
     col = "green")                                   # Change color
hist(iris$Petal.Width [iris$Species == "virginica"],  # VIRGINICA PETAL WIDTH
     xlim = c(0, 3),                                  # Set x from 0 to 3
     breaks = 9,                                      # Set 9 bars
     col = "blue")                                    # Change color
par(mfrow = c(1,1))                                   # Restore graphic parameter

########################
### 1.5 SCATTERPLOTS ###
########################

# LOAD DATA
library(datasets) # Built-in datasets
?mtcars           # Motor Trend car road tests
head(mtcars)      # First few rows of dataset

# UNIVARIATE DISTRIBUTIONS
hist(mtcars$wt)  # Car weights
hist(mtcars$mpg) # Car miles per gallon





#get acquainted with RStudio environment
#Case-sensitivity and no spaces
y=3
print(y)

#print(Y) throws an error because we have not set Y to anything
#Use command + enter or ctrl + enter on Windows to run

#import data

#install.packages and library

typeof(y)
#Data types

#This comment is from Spencer
#This comment is from Chris
#Directions: Pull-->Make Edits-->Save-->Commit-->Push
#Practice