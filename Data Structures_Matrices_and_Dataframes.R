# File:     Data Structures_Matrices and Dataframes.R
# Project:  R Learning

# Overview #################################################
# In this class, we explore two important data structures in R: 
# **matrices** and **data frames**. These are essential for 
# organizing and analyzing structured data, especially in finance.


## 1. Matrices ==============================================
# Matrices are two-dimensional, homogeneous data structures.

### 1.1 Creating and Accessing Matrices ----------------------
a <- matrix(1:9, nrow = 3)         # create 3x3 matrix from numbers 1–9
colnames(a) <- c("A", "B", "C")    # assign column names
a                                  # print matrix
a[1:2, 2:3]                        # subset rows 1–2, columns 2–3


### 1.2 Matrix Indexing --------------------------------------
m <- rbind(c(1,4), c(2,2))         # create 2x2 matrix by row binding
m                                  # print matrix
m[1,2]                             # element at row 1, col 2
m[2,2]                             # element at row 2, col 2
m[1,]                              # entire first row
m[,2]                              # entire second column


### 1.3 Creating Matrices from Functions ---------------------
z12 <- function(z) return(c(z, z^2))  # function returns z and z squared
x <- 1:8   # vector 1 to 8
matrix(z12(x), ncol = 2)              # build matrix with two columns (z, z^2)


## 2. Data Frames ============================================
# Data frames store tabular data. They are lists of equal-length vectors.

### 2.1 Creating and Viewing Data Frames ---------------------
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])  # create data frame
df                                                    # print data frame
str(df)                                               # inspect structure


### 2.2 Indexing Data Frames -------------------------------
df[1]                        # first column as a data frame
df[1:2]                      # first two columns as a data frame
df[c(1, 3), ]                # rows 1 and 3, all columns
df$x                         # access column x using $
df[,"x"]                     # access column x as a vector
df["x"]                     # access column x as a data frame
df[["x"]]                    # same as df$x, returns vector
                  


### 2.3 Creating and Modifying Data Frames ------------------
kids <- c("Jack", "Jill")                         # character vector
ages <- c(12, 10)                                 # numeric vector
d <- data.frame(kids, ages, stringsAsFactors=FALSE) # create data frame
d$grade <- c("6th", "5th")                        # add new column
d                                                 # print data frame


### 2.4 Handling Missing Data -------------------------------
x <- c(2, NA, 4)              # vector with missing value
mean(x)                       # mean with NA -> returns NA
mean(x, na.rm = TRUE)         # mean ignoring NA
complete.cases(x)             # TRUE/FALSE for non-missing values


## Summary ###################################################
# Today you learned:
# - How to work with matrices: creation, indexing, and reshaping
# - How to create and access data frames, including handling missing values
# - Why data frames are a fundamental structure in finance analytics
#
# These tools will help you manage and analyze structured financial 
# data in real-world settings.
