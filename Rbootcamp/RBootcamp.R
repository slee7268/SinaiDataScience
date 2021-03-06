####################################
### WELCOME TO SINAI R BOOTCAMP! ###
####################################

# Authors: Spencer Kiehm, Chris Bellaire, Sam Lee

# Download anonymized data at bit.ly/sinaibootcamp

#Introduce data science club and goals for the bootcamp
#get acquainted with RStudio environment (different panels/windows)
#Case-sensitivity and no spaces

y=3 #numeric variable
print(y)
#print(Y) throws an error because we have not set Y to anything

b<-"Unicorn" # this is a  CHARACTER variable (aka a string)
print(b)
#Use command + enter or ctrl + enter on Windows to run

#vectors
vec$num <- 1:4 # this is a vector of integers
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
view(mat)
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
# Download anonymized data at bit.ly/sinaibootcamp

#Two ways of importing data: 1) Using "Import Dataset" Button and 2) Read Path
#data <- read.csv("path name")
data <- read.csv("/Users/christopherbellaire/Desktop/NRD.csv")
data <- NRD
view(data)
head(data)
str(data)
summary(data)
class(data$AGE)
unique(data$AGE)
range(data$AGE)
summary(data$AGE)
boxplot.stats(data$AGE)

#Recoding Variables
colnames(data)
install.packages("data.table")
library("data.table")
setnames(data, "PAY1", "insurance")
unique(data$insurance)
class(data$insurance)
data$insurance <-recode(data$insurance, 
                  "1" = "Medicare", 
                  "2" = "Medicaid", 
                  "3" = "Private", 
                  "4" = "Self-Pay", 
                  "5" = "No Charge", 
                  "6" = "Other")
unique(data$insurance)

setnames(data, "DISPUNIFORM", "Discharge_Location")
data$Discharge_Location <-recode(data$Discharge_Location, 
                         "1" = "Home", 
                         "2" = "Hospital", 
                         "5" = "Other", 
                         "6" = "Hospice/Nursing")

#Subsetting and Binding Data
young <- subset(data, data$AGE < 30)
boxplot.stats(young$AGE)
#or 
summary(young$AGE)

Not_Readmitted <- subset(data, data$readminUnder90d==0)
Not_Readmitted$Readmission <- "Not Readmitted"
view(Not_Readmitted)

readmit_within_30_days <- subset(data, data$readminUnder30d==1)
readmit_within_30_days$Readmission <- "30-Day Readmissions"

readmit_30_90_days <- subset(data, data$readminUnder90d==1 & data$readminUnder30d==0)
readmit_30_90_days$Readmission <- "30-90 Day Readmissions"

data <- rbind(Not_Readmitted, readmit_within_30_days, readmit_30_90_days)
unique(data$Readmission)

#Two Way Tables Table 1: Patient Population Descriptions
install.packages("Gmisc")
library("Gmisc")

getTable1Stats <- function(x, digits = 0, ...){
  getDescriptionStatsBy(x = x, 
                        by = data$Readmission,
                        header_count = TRUE,
                        statistics = TRUE,
                        digits = 2,
                        statistics.sig_lim = 10^-4,
                        useNA = "no",
                        ...)}

t1 <- list()
t1[["Age"]] <-
  getTable1Stats(data$AGE)

t1[["Insurance Status"]] <- 
  getTable1Stats(data$insurance)

t1[["Length of Stay"]] <- 
  getTable1Stats(data$LOS)

mergeDesc(t1,
          getTable1Stats(data$Readmission)) %>%
  htmlTable(css.rgroup = "",
            css.cell = "padding-left: 2em; padding-right: 1em",
            caption  = "Patient Population Description Statistics for Readmission Populations")

                                                #Regressions

#Binary Logistic Regression using glm function
#binary_logistic <- glm(Y VARIABLE~X VARIABLE + CONTROL1 + CONTROL2, data = DATASET, family = "binomial")
unique(data$readminUnder30d)
binary_logistic <- glm(data$readminUnder30d~data$AGE, family = "binomial")
summary(binary_logistic)

binary_logistic_controls <- glm(data$readminUnder30d~data$AGE + data$LOS, family = "binomial")
summary(binary_logistic_controls)

#Linear Regression using lm function
#fit <- lm(Y VARIABLE ~ X VARIABLE + CONTROL1 + CONTROL2, data=DATASET)
#summary(fit)
summary(data$TOTCHG)
fit <- lm(data$TOTCHG~data$AGE)
summary(fit)

fit2 <- lm(data$TOTCHG~data$AGE + data$LOS)
summary(fit2)

                                                    #Day 1 Review

#Recode "FEMALE" column as a character vector, changing 1 to "Female" and 0 to "Male")


#What was the average age of female patients?

#Make a two-way table comparing age, length of stay, and total charge based on gender (using the column "FEMALE", where 1 = female, 0 = male)

#Controlling for gender, does age have a statistically significant effect on length of stay (LOS)?


                              ####################################
                              ### WELCOME TO SINAI R BOOTCAMP ####
                              #############DAY 2##################
                              ####################################


                                           #Data Visualizations
#Plot example
#plot(X VARIABLE, Y VARIABLE, ylab = "Y AXIS LABEL NAME", xlab = "X AXIS LABEL NAME")
plot(data$AGE, data$TOTCHG, ylab = "Total Charge ($)", xlab = "Age")

#Boxplot example
#boxplot(Y VARIABLE ~ X VARIABLE,
        #data= final_data,
        #main= "BOXPLOT TITLE",
        #xlab = "X AXIS LABEL",
        #ylab="Y AXIS LABEL",
        #col="COLOR, EX. Light Blue",
        #border="BORDER COLOR, EX. Black")

boxplot(data$AGE ~ data$Discharge_Location,
  data= data,
  main= "Patient Age by Discharge Location",
  xlab = "Discharge Location",
  ylab="Age (in years)",
  col="Light Blue",
  border="Black")

#ggplot
#https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

ggplot(data, aes(x=data$Discharge_Location, y=data$AGE)) + geom_boxplot() + xlab("Discharge Location") + ylab("Age") + ggtitle("Patient Age by Discharge Location")

ggplot(data, aes(x=data$Discharge_Location, y=data$AGE)) + geom_boxplot(aes(colour=FEMALE)) + xlab("Discharge Location") + ylab("Age") + ggtitle("Patient Age by Discharge Location and Insurance Type")

                                            #dplyr and chaining/pipelining using %>%

#Functions: filter, select, arrange, mutate, summarise, group_by, as well as SQL-type functions such as inner_join, left_join, etc.

#Recall yesterday that we created the subset "young" using the subset function with the condition of data$AGE<30
young <- subset(data, data$AGE<30)
view(young)

#Using dplyr's filter function, we can achieve the same subset with cleaner code:
young_dplyr <- data %>%
  filter(AGE < 30)
view(young_dplyr)

#Then, using additional dplyr chaining, we can further manipulate the data.  For example, if we want to select only specific columns from our dataset:
young2_dplyr <- data %>%
  filter(AGE < 30) %>%
  select("AGE", "FEMALE", "insurance")
view(young2_dplyr)

#More advanced dplyr to analyze hospital readmissions.
by_date <- data %>%
  select(daysToNextAdmin, readminUnder90d) %>% #Step 1: selecting relevant vectors (columns/variables)
  group_by(daysToNextAdmin) %>% #Step 2: Organize the data based on the number of days to readmission
  summarise(readmits = sum(readminUnder90d)) %>% #Step 3: Create a new variable "readmits" for the total number of readmits
  mutate(cum_readmits = cumsum(readmits)) #Step 4: Create a new variable "cum_readmits" for cumulative readmits

view(by_date)

#Combining what we've learned about ggplot with dplyr data
ggplot(by_date, aes(x=daysToNextAdmin, y=cum_readmits)) + geom_line() + xlab("Days") + ylab("Cumulative Readmissions") + ggtitle("Readmissions over Time") + xlim(0, 90) + geom_vline(xintercept=30, linetype = "dotted")


#Question: Using dplyr, create a dataframe "medicaid" that includes only patients on Medicaid.  Only include columns "insurance", "TOTCHG", and "readminUnder90d" and "Year".  Then create a NEW column "annual_readmits" with the number of readmissions by year (ex. there were 48 medicaid readmissions in 2014)

#Answer
medicaid <- data %>%
  filter(insurance == "Medicaid") %>%
  select(insurance, TOTCHG, readminUnder90d, Year) %>%
  group_by(Year) %>%
  mutate(annual_readmits = sum(readminUnder90d)) 

view(medicaid)

#To determine the number of medicaid readmissions in 2014,
medicaid %>%
  filter(Year == 2014) %>%
  tally(readminUnder90d)

#We get the same result using the subset function from Monday's session
medicaid_readmits_2014 <- subset(data, data$Year==2014 & data$readminUnder90d==1 & data$insurance=="Medicaid")
nrow(medicaid_readmits_2014)
view(medicaid_readmits_2014)

                                           #Review Together

#Use ggplot's geom_density plot to show the age distributions for men and women

class(data$FEMALE)
data$FEMALE <- as.factor(data$FEMALE)
ggplot(data, aes(x=AGE, fill = FEMALE)) + geom_density(alpha=.5) + labs(x = "Age", y = "Frequency", title = "Density Plots of Age and Gender")

#Make a barchart of number of male and female patients by insurance type

ggplot(data, aes(x=insurance, fill=FEMALE)) + geom_bar() + labs(x="Insurance Type", y = "Number of Patients", title = "Patients by Insurance Status and Gender")


                                                  #Day 2 review on your own

#Make a boxplot (using ggplot or boxplot function) comparing the age distributions (vector name: AGE) based on gender (vector name: FEMALE)

#Using the ggplot package, make a line plot plotting length of stay (LOS) on the x axis and total charge (TOTCHG) on the y axis

#Make a barchart using ggplot with number of patients by insurance type, with a fill for whether or not they were readmitted during the 90 days following their procedure (data$readminUnder90d)



                                            ####################################
                                            ### WELCOME TO SINAI R BOOTCAMP ####
                                            #########Additional Practice#########
                                            ####################################


                                        


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