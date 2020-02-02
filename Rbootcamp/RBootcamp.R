####################################
### Welcome to Sinai R Bootcamp! ###
####################################

# Table of Contents:
# DAY 1 - Monday, February 3, 2020
#     1.1 Getting Acquainted with R/RStudio
#     1.2 Basic X-Y Plotting
#     1.3

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
head(iris) # First few rows (sepal & petal dimensions, 3 species)

# PLOT DATA
?plot() # Shows command info in lower-right window
plot(iris$Species) # Plot categorical variable
plot(iris$Petal.Length) # Plot quantitative variable
plot(iris$Species, iris$Petal.Length) # Plot x=Species, y=Petal Length
plot(iris$Petal.Length, iris$Petal.Width) # Plot x=Petal Length, y=Petal Width
plot(iris) # Plot entire data frame









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