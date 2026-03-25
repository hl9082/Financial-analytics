# Load necessary libraries
if (!require("quantmod")) install.packages("quantmod")
if (!require("ggplot2")) install.packages("ggplot2")
library(quantmod)
library(ggplot2)

# ==========================================
# Part 1 & 2: Choose Assets & Import Data
# ==========================================
# NVDA = Risky Equity | BRK-B = Lower-risk Equity
tickers <- c("NVDA", "BRK-B")

# Download data (2020-12-31 to 2025-12-31)
getSymbols(tickers, from = "2020-12-31", to = "2025-12-31")

# Extract Adjusted Prices
# Note: backticks are used because of the hyphen in BRK-B
price.nvda <- Ad(NVDA)
price.brkb <- Ad(`BRK-B`)

# Compute Daily Simple Returns
ret.nvda <- Delt(price.nvda)
ret.brkb <- Delt(price.brkb)

# Combine into one dataset and remove NAs
rets <- na.omit(merge(ret.nvda, ret.brkb))
colnames(rets) <- c("NVDA", "BRKB")

# ==========================================
# Part 3: Cumulative Returns
# ==========================================
# Arithmetic Method: Growth of $1
cum.path <- cumprod(1 + rets)

# Plot $1 Investment (Deliverable 1)
plot(cum.path, col = c("darkgreen", "navy"), lwd = 2,
     main = "Growth of $1 Investment (2021-2025)",
     ylab = "Value ($)", legend.loc = "topleft")

# Report Final Cumulative Return (Deliverable 2)
final.cum <- (tail(cum.path, 1) - 1) * 100
cat("Final Cumulative Returns (%):\n")
print(round(final.cum, 2))

# ==========================================
# Part 4: Risk Measurement
# ==========================================
# 1-2. Annualized Volatility (Daily SD * sqrt(252))
ann.vol <- apply(rets, 2, sd) * sqrt(252)

# 4. Mean Annualized Return (Daily Mean * 252)
ann.ret <- colMeans(rets) * 252

# 5. Sharpe Ratio (Assume Risk-Free = 0)
sharpe <- ann.ret / ann.vol

# Deliverable: Performance Table
perf.table <- data.frame(
  Asset = c("NVDA", "BRKB"),
  Annual_Return = round(ann.ret, 4),
  Annual_Volatility = round(ann.vol, 4),
  Sharpe_Ratio = round(sharpe, 4)
)
print(perf.table)

# ==========================================
# Part 5: Risk-Return Scatter Plot
# ==========================================
# Create Scatter Plot (Deliverable 3)
ggplot(perf.table, aes(x = Annual_Volatility, y = Annual_Return, label = Asset)) +
  geom_point(size = 5, color = "steelblue") +
  geom_text(vjust = -1.5, fontface = "bold") +
  scale_x_continuous(labels = scales::percent, limits = c(0, max(ann.vol)*1.2)) +
  scale_y_continuous(labels = scales::percent, limits = c(0, max(ann.ret)*1.2)) +
  labs(title = "Risk-Return Profile: NVDA vs BRK-B",
       subtitle = "Data: 2021 - 2025",
       x = "Annualized Volatility (Risk)",
       y = "Annualized Return (Reward)") +
  theme_minimal()