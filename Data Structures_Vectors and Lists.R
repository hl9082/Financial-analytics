# File:     Data Structures_Vectors and Lists.R
# Project:  R Learning

# Overview #################################################

# In this class, we will cover the foundational data structures in R: **vectors** and **lists**. 
# Understanding these is crucial for performing data manipulation, analysis, and working with financial data.


## 1. Vectors=================================
# Vectors are the most basic data structure in R. All elements in a vector must be of the same type.

### 1.1 Creating and Inspecting Vectors----------------------------
v <- c(1, 3, 6)        # create a numeric vector
length(v)              # get number of elements
class(v)               # check the type/class
is.vector(v)           # test if it is a vector
is.numeric(v)          # test if elements are numeric


### 1.2 Vector Indexing and Manipulation----------------------------
v[4] <- 8              # assign value 8 to the 4th element (creates it if not there)
v                      # print the vector
v[1:3]                 # select elements 1 through 3
v[-2]                  # select all except element 2
v[c(1, 3)]             # select the 1st and 3rd elements


### 1.3 Useful Vector Functions----------------------------
mean(v)                # calculate mean
min(v)                 # minimum value
max(v)                 # maximum value
sum(v)                 # sum of all elements
sd(v)                  # standard deviation
cumsum(v)              # cumulative sum


### 1.4 Logical Operations and Filtering----------------------------
v                      # print the vector
v < 5                  # check which elements are less than 5 (returns TRUE/FALSE)
which(v > 5)           # return positions of elements greater than 5
v[which(v > 5)]        # extract elements greater than 5


## 2. Lists==========================================
# Lists can hold objects of different types and are very flexible.

### 2.1 Creating Lists---------------------------------------
x <- list(1:3, "a", 4:6)  # list with numeric vector, string, numeric vector
x                        # print the list
class(x)                 # check the type/class


### 2.2 Indexing Lists---------------------------------------
x[1]                     # extract first element as a list
x[[1]]                   # extract first element as the underlying object (vector)
x[c(1, 3)]
# extract first and third elements as a list
x[[1]][2]                # extract the 2nd element from the first list item


### 2.3 Named Lists and Accessing Elements---------------------------------------
j <- list(name="Joe", salary=55000, union=TRUE)  # create named list
j$salary                # access element by name with $
j[["salary"]]           # access element by name with [[ ]]
j["salary"]             # returns a sub-list containing the element named "salary" (type = list)
j[[2]]                  # access element by position (2nd element)
j[1:2]                  # access first two elements as a list


## 2.4 Modifying Lists
# You can add or remove elements from a list.
z <- list(a="abc", b=12)  # create list with 2 named elements
z$c <- "new"              # add new element with name c
z[[4]] <- 28              # add unnamed element at 4th position
z[5:6] <- list(FALSE, TRUE) # add two more elements
z$b <- NULL               # remove element b
z                         # print the list


### 2.5 Applying Functions to Lists
lapply(list(1:3, 25:29), median)  # apply median to each list element, return list
sapply(list(1:4, 25:29), median)  # apply median, return simplified vector


## Summary
# Today, you learned:
# - How to create and manipulate vectors and lists
# - Indexing and subsetting techniques
# - Logical filtering
# - Applying functions to list elements
# 
# These concepts are essential for data manipulation and will serve as a foundation 
# for more advanced structures like matrices and data frames.
