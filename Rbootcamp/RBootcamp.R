####################################
### WELCOME TO SINAI R BOOTCAMP! ###
####################################

# Authors: Spencer Kiehm, Christopher Bellaire, Samuel Lee

#get acquainted with RStudio environment
#Case-sensitivity and no spaces
y=3
print(y)
b<-"Unicorn" # this is a  CHARACTER variable (aka a string)
print(b)
#print(Y) throws an error because we have not set Y to anything
#Use command + enter or ctrl + enter on Windows to run

#vectors
vec <- 1:4 # this is a vector of integers
vec2 <- c("hello", "world", "hi")
vec3 <- c(1, 2, 5)
print(vec)
print(vec2)
print(vec3)

#how do I access the 4th element of the first vector?
vec[4]
vec2[3]

#what about a 2D matrix
mat <- matrix(1:12, nrow=3, ncol=4)
mat[2,3] # this grabs the entry on the 2nd row and 3rd column
mat[3,]
mat[,2]

##########################################################
#libraries
##########################################################

install.packages("tidyverse")
library("tidyverse")

##########################################################
#import data
##########################################################
data <- read.csv("NRD.csv")

class(data$AGE)
class(data$KEY_NRD)
class(data$DISCWT)
class(data$LOS)

#your first plot!
ggplot(data) + geom_point(aes(LOS, DISCWT))


#V2
library(datasets) # Built-in datasets
head(iris)
data<-iris

class(data$Sepal.Length)
class(data$Species)

#i'm too lazy I just wanna know the classes
sapply(data, class)

#what kind of species are we dealing with?
levels(data$Species)

#let's summarize
summary(data)

#your first plot
ggplot(data) + geom_point(aes(Sepal.Length, Sepal.Width))

#let's color it by species and add labels
ggplot(data) + geom_point(aes(Sepal.Length, Sepal.Width, color = Species)) +
  labs(title = "my first plot baby", x="Sepal Length", y = "Sepal Width")

#what if i only care about setosa flowers
setosa <- data %>% filter(Species=="setosa")

#let's plot sepal.length and petal length
ggplot(setosa, aes(Sepal.Length, Petal.Length)) +
  geom_point(col="steelblue") + geom_smooth(col="firebrick",method="lm")

#i'm tired of stupid scatterplots
ggplot(data, aes(Species, Petal.Length, color=Species)) +geom_boxplot()

#barplot
ggplot(data, aes(Species)) + geom_bar()

#histogram
ggplot(data, aes(Sepal.Length)) + geom_histogram(color="blue", fill="lightblue")

#histogram by class
ggplot(data, aes(Sepal.Length, color=Species)) + geom_histogram( fill="white", alpha = 0.2)


########################################################
#YOUR TURN
########################################################

#make a scatterplot with sepal width and petal width
#now add a linear line with it
#make a box and whisker plot of the petal length
#make a histogram of petal.width
#make a histogram of petal width and color it by species


ggplot(data) + geom_point(aes(Sepal.Length, Sepal.Width, color = Species)) +
  labs(title = "my first plot baby", x="Sepal Length", y = "Sepal Width")


#Data types

#Directions: Pull-->Make Edits-->Save-->Commit-->Push

#####################################################################################
# I worked through part of a tutorial and added some plotting examples below -Spencer
# Feel free to use as much/little as you guys want
# Maybe can use as a guide/outline for visualizing the clinical data

##################################
### TUTORIAL PLOTTING EXAMPLES ###
##################################

# 1 Getting Acquainted with R/RStudio
# 2 Basic X-Y Plotting
# 3 Bar Charts
# 4 Histograms
# 5 Scatterplots
# 6 Overlaying Plots
# 7 Data Summary

###########################################
### 1 Getting Acquainted with R/RStudio ###
###########################################

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

############################
### 2 Basic X-Y Plotting ###
############################

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

######################
### 3 BAR CHARTS #####
######################

# LOAD DATA
library(datasets) # Built-in datasets
?mtcars           # Motor Trend car road tests
head(mtcars)      # First few rows of dataset

# RECONFIGURE DATA
barplot(mtcars$cyl)            # Doesn't work, need a frequency table
cylinders <- table(mtcars$cyl) # Create table, feed into variable cylinders
barplot(cylinders)             # Proper bar chart
plot(cylinders)                # X-Y plot (lines)

####################
### 4 HISTOGRAMS ###
####################

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

######################
### 5 SCATTERPLOTS ###
######################

# LOAD DATA
library(datasets) # Built-in datasets
?mtcars           # Motor Trend car road tests
head(mtcars)      # First few rows of dataset

# UNIVARIATE DISTRIBUTIONS
hist(mtcars$wt)  # Car weights
hist(mtcars$mpg) # Car miles per gallon

# X-Y PLOT (WT vs MPG)
plot(mtcars$wt, mtcars$mpg,        # Car weight vs MPG
     pch = 19,                     # Solid circle
     col = "red",                  # Color points red
     main = "Car Weight vs MPG",   # Main title
     xlab = "Weight (in 1000lbs)", # X axis label
     ylab = "MPG")                 # Y axis label

##########################
### 6 OVERLAYING PLOTS ###
##########################

# LOAD DATA
library(datasets) # Built-in datasets
?lynx           # Annual Canadian lynx trappings 1921-1934
head(lynx)      # First few rows of dataset

# PLOT HISTOGRAM
hist(lynx,                                        # Plot time series as histogram
     breaks = 14,                                 # Suggest 14 bins
     freq = FALSE,                                # Density plot
     col = "red",                                 # Color red
     main = "Canadian Lynx Trappings: 1821-1934", # Main title
     xlab = "Number of Lynx Trapped")             # X axis label

# ADD NORMAL DISTRIBUTION
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)), # Plot normal distribution
      col = "blue",                               # Color blue
      add = TRUE)                                 # Superimpose over histogram

# ADD RUG PLOT
rug(lynx, col = "green") # Shows each point as tick mark below histogram

######################
### 7 DATA SUMMARY ###
######################

# LOAD DATA
library(datasets) # Built-in datasets
head(iris)        # First few rows of dataset

# DATA SUMMARIES
summary(iris$Species)      # Categorical variable
summary(iris$Sepal.Length) # Quantatative variable
summary(iris)              # Entire data frame