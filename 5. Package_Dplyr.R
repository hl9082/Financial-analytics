# dplyr Demo — Fully Commented R Script
# Author: JQ
# Date: 2026-01-29
# Purpose: Demonstrate core dplyr verbs: filter, select/rename, mutate, arrange,
#          grouping & summarising, boolean counts, and piping chains.


## A. Read Data file================================
# Load dplyr; prefer library() to require() so it errors if not installed
#install.packages("dplyr")  # Uncomment to install if needed
library(dplyr)                 # Attach dplyr functions to the search path

myfile <- 'data/Compustat data small 2000-17.csv' # CSV path
d1 <- read.csv(myfile, na.strings = "")  # Read CSV; treat empty strings as NA
d1 <- d1[!(d1$tic == "BAC"), ]          # Remove rows where ticker equals "BAC"
names(d1)                              
class(d1)                              
summary(d1)                                 # Quick univariate summaries per column


## B. Filter ================================
# Method 1: Use filter() as a plain function to select rows for fyear == 2005
d2005 <- filter(d1, fyear == 2005)  # Keep only year 2005 observations
head(d2005, n = 2)                  # Preview first two rows of the filtered data
class(d2005)                       

# Method 2: Use the pipe operator %>% to chain operations
d2006 <- d1 %>%                     # Start with d1
  filter(fyear == 2006)             # Keep only rows where fyear equals 2006


## C. Select & Rename ================================
# Select a subset of columns using select()
tmp <- d1 %>%                       # Start with original data
  select(gvkey, fyear, tic, ni)     # Keep only these four columns

names(tmp)                          # Confirm selected column names

# Rename a column: ni -> NetInc using rename()
tmp1 <- tmp %>%                     # Take tmp
  rename(NetInc = ni)               # Rename column ni to NetInc
names(tmp1)                         # Verify new column name


## D. Mutate ================================
# Create new variables using mutate(): GrossMargin, NetMargin, ROA
d2 <- mutate(d1,                    # Start from d1
             GrossMargin = gp / revt,  # Gross margin as gross profit / revenue
             NetMargin   = ni / revt,  # Net margin as net income / revenue
             ROA         = ni / at)    # Return on assets as net income / assets

head(d2, n = 2)    

# Chain operator approach
d2c <- d1 %>% mutate(GrossMargin = gp / revt,  # Gross margin as gross profit / revenue
                    NetMargin   = ni / revt,  # Net margin as net income / revenue
                    ROA         = ni / at)
head(d2c, n = 2)


## E. Arrange ================================
# Keep only relevant columns then sort by NetMargin ascending
d3 <- d2 %>%                        # Start from d2
  select(tic, fyear, NetMargin) %>% # Keep ticker, fiscal year, NetMargin
  arrange(NetMargin)                # Sort rows by NetMargin (lowest first)

head(d3, n = 3)                    


##  F. Booleans ================================
# Count rows per ticker (frequency table)
d2 %>% count(tic)                   # Returns tibble with columns: tic, n

# Count by ticker and a logical condition (ROA > 0.1)
d2 %>% count(tic, ROA > 0.1)        # Adds a boolean grouping column

# Count by year and ROA > 0.1
d2 %>% count(fyear, ROA > 0.1)      # Useful for quick conditional distributions


d2 %>%
  group_by(fyear) %>%                               # Group observations by fiscal year
  summarize(meanNetMargin = mean(NetMargin, na.rm = TRUE)) %>%  # Compute yearly mean
  filter(meanNetMargin > 0.12)   %>%               # Keep only years above 12%
  count()

## G. Chain Functions (Grouping, Summarizing, Filtering, Sorting) ================================
# Example: compute mean NetMargin by year, keep years with mean > 12%, sort desc
d2 %>%
  group_by(fyear) %>%                               # Group observations by fiscal year
  summarize(meanNetMargin = mean(NetMargin, na.rm = TRUE)) %>%  # Compute yearly mean
  filter(meanNetMargin > 0.12) %>%                  # Keep only years above 12%
  arrange(-meanNetMargin)                      # Sort from highest to lowest
# Example output (from the demo) is a tibble of 10 rows with fyear and meanNetMargin



