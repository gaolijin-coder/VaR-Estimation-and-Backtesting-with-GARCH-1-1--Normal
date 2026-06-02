# ============================================================
# scripts/Code.R
# Project: VaR estimation with GARCH(1,1)-Normal
# ============================================================

# Clear workspace
rm(list = ls())

# Load required packages
library(here)   # For reproducible file paths
library(xts)    # For time series manipulation
library("PerformanceAnalytics")
#  Load data
load(here("Data", "indices.rda"))


# Inspect class and structure of the price data
class(prices)
str(prices)

# Display first observations
head(prices)

#  Keep observations from January 2005 onwards
prices <- prices["2005-01/"]

# Analyse de l'évolution des indices à partir de 2005.
png(here("Output", "indices_evolution.png"), 
    width = 1400, 
    height = 900)

plot(prices, 
     type = "l",
     yaxis.right = FALSE,
     legend.loc = "topleft",
     major.ticks = "years",  # Afficher les ticks majeurs sur les années
     minor.ticks = NULL,   # Ne pas afficher les ticks mineurs
     main = "Indices SP 500 and FTSE 100",
     grid.ticks.on = "years",   # Afficher les ticks de la grille sur les années
     grid.ticks.lty = 2)

dev.off()


# Calcul des rendements logarithmiques.
rets <- CalculateReturns(prices, method = "log")
rets <- rets[-1] # Remove first NA observation created by differencing
head(rets)


# Plot log-return series
png(here("Output", "cumulative_log_returns.png"), 
    width = 1400, 
    height = 900)

par(mfrow = c(2, 1),
    cex = 0.8) # Réinitialiser la disposition des graphiques

# First index (SP500)
plot(rets[,1], 
     main = "Log-Returns - SP500", 
     ylab = "Log-Return", 
     xlab = "Time")

# Second index (FTSE100)
plot(rets[,2], 
     main = "Log-Returns - FTSE100", 
     ylab = "Log-Return", 
     xlab = "Time")
dev.off()

source(here("Function", "f_forecast_var.R"))

# ============================================================
# Estimation statique de la VaR
# ============================================================

T <- 1000
level <- 0.95
y_SP500 <- rets$SP500
y_FTSE100 <- rets$FTSE100
 
VaR_SP500 <- f_forecast_var(y_SP500[1:T], level)
VaR_FTSE100 <- f_forecast_var(y_FTSE100[1:T], level)


VaR_SP500 <- VaR_SP500$VaR_Forecast
VaR_FTSE  <- VaR_FTSE100$VaR_Forecast

VaR_SP500
VaR_FTSE


# ============================================================
# BACKTESTING
# ============================================================

# Estimation de la VaR à un niveau de confiance de 95% à l'horizon T + 1.
# o T est une fenetre glissante et = 1000.
# o Horizon T + 1 : on veut estimer la VaR pour les prochains jours (T + 1) en utilisant les 1000 premiers.
# o Alpha = 0.95

T        <- 1000
level    <- 0.95
n        <- nrow(rets)
n_forecast <- 1000  # Next 1000 days

# Initialize storage vectors
VaR_roll_SP500  <- numeric(n_forecast)
VaR_roll_FTSE   <- numeric(n_forecast)

# Rolling window loop
for (i in 1:n_forecast) {
  # Extract rolling window of size T
  window_SP500 <- rets[i:(i + T - 1), 1]
  window_FTSE  <- rets[i:(i + T - 1), 2]
  
  # Estimate GARCH and forecast next-step VaR
  VaR_roll_SP500[i] <- f_forecast_var(as.numeric(window_SP500), level)$VaR_Forecast
  VaR_roll_FTSE[i]  <- f_forecast_var(as.numeric(window_FTSE),  level)$VaR_Forecast
}

# Realized returns for the out-of-sample period (T+1 to T+n_forecast)
realized_SP500 <- as.numeric(rets[(T + 1):(T + n_forecast), 1])
realized_FTSE  <- as.numeric(rets[(T + 1):(T + n_forecast), 2])

# Dates for the out-of-sample period
dates_oos <- index(rets)[(T + 1):(T + n_forecast)]

# Convert to xts for plotting
VaR_xts_SP500  <- xts(VaR_roll_SP500,  order.by = dates_oos)
VaR_xts_FTSE   <- xts(VaR_roll_FTSE,   order.by = dates_oos)
ret_xts_SP500  <- xts(realized_SP500,   order.by = dates_oos)
ret_xts_FTSE   <- xts(realized_FTSE,    order.by = dates_oos)

# ============================================================
# PLOT & SAVE AS PNG
# ============================================================

png(here("Output", "backtest_VaR.png"), width = 1200, height = 800)

par(mfrow = c(2, 1), mar = c(4, 4, 3, 2))

# =========================
# SP500 (TOP PANEL)
# =========================
plot(index(ret_xts_SP500),
     coredata(ret_xts_SP500),
     type = "l",
     main = "Backtesting VaR 95% - SP500",
     ylab = "Log-Return",
     xlab = "",
     col  = "black",
     lwd  = 0.8)

lines(index(VaR_xts_SP500),
      coredata(VaR_xts_SP500),
      col = "red",
      lwd = 1.5)

legend("bottomleft",
       legend = c("Realized Returns", "VaR 95%"),
       col = c("black","red"),
       lty = 1,
       bty = "n")

# =========================
# FTSE100 (BOTTOM PANEL)
# =========================
plot(index(ret_xts_FTSE),
     coredata(ret_xts_FTSE),
     type = "l",
     main = "Backtesting VaR 95% - FTSE100",
     ylab = "Log-Return",
     xlab = "",
     col  = "black",
     lwd  = 0.8)

lines(index(VaR_xts_FTSE),
      coredata(VaR_xts_FTSE),
      col = "red",
      lwd = 1.5)

legend("bottomleft",
       legend = c("Realized Returns", "VaR 95%"),
       col = c("black","red"),
       lty = 1,
       bty = "n")

dev.off()
# ============================================================
# SAVE BACKTEST RESULTS AS .rda
# ============================================================

# Violation indicator: 1 if realized return < VaR (VaR is negative here)
violations_SP500 <- as.integer(realized_SP500 < VaR_roll_SP500)
violations_FTSE  <- as.integer(realized_FTSE  < VaR_roll_FTSE)


# Collect all results
backtest_results <- list(
  dates            = dates_oos,
  realized_SP500   = realized_SP500,
  realized_FTSE    = realized_FTSE,
  VaR_SP500        = VaR_roll_SP500,
  VaR_FTSE         = VaR_roll_FTSE,
  violations_SP500 = violations_SP500,
  violations_FTSE  = violations_FTSE
)

save(backtest_results, file = here("Data", "backtest_results.rda"))
