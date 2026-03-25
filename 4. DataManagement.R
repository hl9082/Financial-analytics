############################################################
## Stock Prices Example: Read, Inspect, Clean, Summarize
## Purpose:
##   1) Read CSV into a data.frame
##   2) Inspect structure and data types
##   3) Create Date variables + Day-of-week
##   4) Compute descriptive stats by group (Ticker, Day)
##   5) Sort, select columns, and subset rows
############################################################


## A. READ IN DATA =======================================================

# File path (relative). Adjust if needed.
myfile <- "data/BACSX.csv"

# (Recommended) Check if the file exists before reading
if (!file.exists(myfile)) {
  stop("File not found: ", myfile, "\nCheck your working directory or file path.")
}

# Read CSV
# header=TRUE: first row contains column names
# sep=",": comma-separated file
mydat <- read.csv(myfile, header = TRUE, sep = ",", stringsAsFactors = FALSE)

# (Optional but helpful) Confirm dimensions
cat("Rows:", nrow(mydat), " | Cols:", ncol(mydat), "\n")


## B. INSPECT DATA =======================================================

# Column names
names(mydat)

# Structure: types + a preview of values
str(mydat)

# First rows
head(mydat)

# Class/type for each column (quick check)
sapply(mydat, class)

# (Recommended) Basic summary statistics
summary(mydat)


## C. CLEAN / PREPARE VARIABLES ==========================================
## Goal: ensure Date is a Date type and add weekday information.

# 1) Convert Date column to Date type
# NOTE: This assumes mydat$Date is in a standard format like "YYYY-MM-DD".
# If your date format is different (e.g., "01/31/2024"), you MUST specify format=.
mydat$Date2 <- as.Date(mydat$Date)

# If you need a specific format, use for example:
# mydat$Date2 <- as.Date(mydat$Date, format = "%m/%d/%Y")

# Check for parsing problems (NAs after conversion usually mean format mismatch)
if (any(is.na(mydat$Date2))) {
  warning("Some Date values could not be converted to Date. Check date format in mydat$Date.")
}

# 2) Add Day-of-week
# weekdays() returns "Monday", "Tuesday", etc.
mydat$Day <- weekdays(mydat$Date2)

# Re-check first rows and classes
head(mydat)
sapply(mydat, class)

# 3) Convert Day to an ordered factor (Mon -> Fri)
# This is useful for sorting and for consistent output in tables/plots
mydat$Day <- factor(
  mydat$Day,
  levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
  ordered = TRUE
)

# (Optional) Ensure expected columns exist
required_cols <- c("Ticker", "Adj.Close", "Date", "Date2", "Day")
missing_cols <- setdiff(required_cols, names(mydat))
if (length(missing_cols) > 0) {
  stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
}

# (Optional) Handle missing values (common in real data)
# Here we keep it simple: remove rows missing key fields
mydat <- mydat[!is.na(mydat$Ticker) & !is.na(mydat$Adj.Close) & !is.na(mydat$Date2), ]


## D. GROUPED DESCRIPTIVE STATISTICS =====================================
## Two common base-R approaches: by() and aggregate()

### D1. Using by() --------------------------------------------------------

# Mean Adj.Close for each ticker
by(mydat$Adj.Close, mydat$Ticker, mean, na.rm = TRUE)


### D2. Using aggregate() -------------------------------------------------

# Mean Adj.Close by Ticker
aggregate(mydat$Adj.Close, list(Ticker = mydat$Ticker), mean, na.rm = TRUE)

# Mean Adj.Close by Ticker and Day
aggregate(mydat$Adj.Close, list(Ticker = mydat$Ticker, Day = mydat$Day), mean, na.rm = TRUE)

# Formula interface: Mean Adj.Close by Ticker
aggregate(Adj.Close ~ Ticker, data = mydat, FUN = mean, na.rm = TRUE)

# Formula interface: SD Adj.Close by Ticker and Day
aggregate(Adj.Close ~ Ticker + Day, data = mydat, FUN = sd, na.rm = TRUE)

# Multiple summaries (mean + count) using a custom function
agg_stats <- aggregate(
  Adj.Close ~ Ticker + Day,
  data = mydat,
  FUN = function(x) c(mean = mean(x, na.rm = TRUE), n = length(x))
)

# (Optional) Clean up the output into separate columns
# aggregate returns a matrix in the third column; convert it to columns:
agg_stats$mean <- agg_stats$Adj.Close[, "mean"]
agg_stats$n    <- agg_stats$Adj.Close[, "n"]
agg_stats$Adj.Close <- NULL

head(agg_stats)


## E. SORTING AND SUBSETTING =============================================
## Sorting helps verify time ordering; subsetting helps answer specific questions.

### E1. Sorting -----------------------------------------------------------

# Sort by Date2 ascending
mydat_sorted_date <- mydat[order(mydat$Date2), ]
head(mydat_sorted_date)

# Sort by Date2 then Adj.Close ascending
mydat_sorted_date_price <- mydat[order(mydat$Date2, mydat$Adj.Close), ]
head(mydat_sorted_date_price)

# Sort by Date2 then Adj.Close descending (note the minus sign)
mydat_sorted_date_price_desc <- mydat[order(mydat$Date2, -mydat$Adj.Close), ]
head(mydat_sorted_date_price_desc)


### E2. Select columns ----------------------------------------------------

# Keep only a few columns (Ticker, Date2, Adj.Close)
mydat_core <- mydat[, c("Ticker", "Date2", "Adj.Close")]
head(mydat_core)


### E3. Subset rows (filtering) ------------------------------------------

# Version A: Base R with which()
mydat_ba_monday <- mydat[which(mydat$Day == "Monday" & mydat$Ticker == "BA"), ]
head(mydat_ba_monday)

# Filter + select columns
mydat_ba_monday_small <- mydat[which(mydat$Day == "Monday" & mydat$Ticker == "BA"),
                               c("Date2", "Day", "Adj.Close")]
head(mydat_ba_monday_small)

# Version B: Using subset() (often easier to read)
mydat_csx_friday_small <- subset(
  mydat,
  Day == "Friday" & Ticker == "CSX",
  select = c("Date2", "Day", "Adj.Close")   # use Date2 to stay consistent
)
head(mydat_csx_friday_small)


## F. (Optional but Useful) Quick Sanity Checks ==========================
# How many rows per ticker?
table(mydat$Ticker)

# How many rows per weekday?
table(mydat$Day)

# Check date range
range(mydat$Date2)

# Any duplicate rows? (simple check)
sum(duplicated(mydat))


