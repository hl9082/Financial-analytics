# File:     R_intro.R
# Project:  R Learning

# THIS IS A LEVEL 1 HEADER #################################

## This Is a Level 2 Header ================================

### This is a level 3 header. ------------------------------


# Navigating R ############################################
## Load packages
library(datasets)   # Loads the built-in datasets

## Load and prepare data
?iris       # Get help on `iris` dataset
df <- iris  # Save dataset to `df` (optional)
head(df)    # Display first six lines of data
View(df)

## Analyze data 
# The R $ operator selects a variable from a data frame.
# Usage: dataset$variable
hist(df$Sepal.Width,            # Make basic histogram
     main = "Iris Sepal Width",    # Add title to chart
     xlab = "Sepal Width (in cm)"  # Add X-axis label
)  

# Data Types ############################################
# Numeric
n1 <- 15.0  # Double precision by default
n1
typeof(n1)

# Character
c1 <- "c"
c1
typeof(c1)

c2 <- "a string of text"
c2
typeof(c2)

# Logical
l1 <- TRUE
l1
typeof(l1)

l2 <- F
l2
typeof(l2)


# Basic Commands #########################################
2+2  # Basic math; press cmd/ctrl enter

1:100  # Prints numbers 1 to 100 across several lines

print("Hello World!")  # Prints "Hello World" in console

## Assigning Values ============================================
# Individual values
a <- 1            # Use <- and not =
2 -> b            # Can go other way, but silly

# Multiple values
x <- c(1, 2, 5, 9)  # c = Combine/concatenate
x                   # Displays contents of x in Console
(y <- c(1, 2, 5, 9))

## Sequences ============================================
# Create sequential data
0:10     # 0 through 10
10:0     # 10 through 0
seq(10)  # 1 to 10
seq(20, -10, by = -3)  # Count down from 20 to -10 by 3

## Math ============================================
# Surround command with parentheses to also display
(y <- c(5, 1, 0, 10)) 
x           # Display x again
x + y       # Adds corresponding elements in x and y
x * 2       # Multiplies each element in x by 2
2^6         # Powers/exponents
sqrt(64)    # Square root
log(100)    # Natural log: base e (2.71828...)
log10(100)  # Base 10 log



# Extended Example ######################################### 
  #Extended Example: Stock Price Analysis Using `quantmod`
  #Let’s use `quantmod` to retrieve and analyze stock data for Apple Inc. (AAPL).

# Import and Load Packages ============================================
# Note: It's okay to load packages in your script if you are
# doing "interactive" analysis on open scripts. However, for
# projects where the script is executed without being
# opened, like a source file, code to load or install
# packages should not be included. Rather, the packages
# should be loaded previously in a separate file.
install.packages("quantmod")   # Financial data and analysis
install.packages("tidyverse")  # Data wrangling, visualization, and more
library(quantmod)
## Download Stock Data ============================================
getSymbols("AAPL", from = "2024-01-01", to = "2025-01-01")
head(AAPL)
#This fetches historical stock data from Yahoo Finance.

## Plot the Closing Prices ============================================
chartSeries(AAPL, theme = chartTheme("white"), TA = "addVo()")
#This plots the time series of Apple’s stock price along with trading volume.


## Compute Daily Returns ============================================
daily_returns <- dailyReturn(Cl(AAPL))  # Cl() extracts closing prices
head(daily_returns)
plot(daily_returns, main = "Daily Returns of AAPL", col = "blue")


# Summary Statistics ============================================
summary(daily_returns)
sd(daily_returns)
#This gives a quick overview of the distribution and volatility.


# Clear R #########################################
##   Restart R  ============================================
#   To clear objects from the environment, clear
#   plots, unload external packages, reset options, relative
#   paths, dependencies, etc. Use the RStudio menu Session > 
#   Restart R, or use Ctrl+Shift+F10 (for Windows)
#   or Command+Shift+0 (for MacOS).

## Clear console ============================================
cat("\014")  # Mimics ctrl+L


# Summary #########################################
# In this class, we:
# - Installed R and RStudio
# - Learned basic commands in R
# - Downloaded and analyzed real-world stock price data
