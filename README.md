# Value-at-Risk (VaR) Estimation Using a GARCH(1,1)-Normal Model

## Course

**Statistical Methods for Financial Data**

## Authors
* Lijin Gao
* Mazidath Imorou
* Aida Diop

## Project Description

This project aims to estimate the Value-at-Risk (VaR) of two financial indices (S&P 500 and FTSE 100) using a GARCH(1,1) model with normally distributed errors. The objective is to model the conditional volatility of financial returns and generate risk forecasts over a 1,000-day evaluation period.

## Project Structure

The project is organized as follows:

```text
Data/          Financial datasets
Code/          Main R scripts
Function/      User-defined functions
Output/        Generated figures and results
RMarkdown/     Reproducible report combining text, code, and outputs
README.md      Project documentation
```

## Data

The dataset (`indices.rda`) contains historical price series for:

* S&P 500
* FTSE 100

Logarithmic returns are computed from the price series and used for volatility modeling.

## Methodology

The main steps of the project are:

1. Load financial data.
2. Filter observations from January 2005 onward.
3. Compute logarithmic returns.
4. Estimate a GARCH(1,1) model using Maximum Likelihood Estimation (MLE).
5. Calculate conditional variances.
6. Generate one-step-ahead Value-at-Risk (VaR) forecasts at the 95% confidence level.
7. Evaluate forecast performance through backtesting.

## Model Specification

The conditional variance follows a GARCH(1,1) process:

σ²ₜ₊₁ = ω + αy²ₜ + βσ²ₜ

where:

* ω: constant term
* α: ARCH effect (impact of past shocks)
* β: volatility persistence parameter

The VaR forecast is computed as:

VaR = Φ⁻¹(1 − confidence level) × σₜ₊₁

where Φ⁻¹ denotes the inverse cumulative distribution function of the standard normal distribution.

## Software and Packages

The project was developed in **RStudio**.

Main packages used:

* `here` – file path management
* `xts` – financial time series handling
* `PerformanceAnalytics` – return calculations and performance analysis

## How to Run the Project

1. Open the `.Rproj` file in RStudio.
2. Ensure that all project folders (`Data`, `Code`, `Function`, `Output`, etc.) are present.
3. Run the main script.
4. Figures, volatility estimates, and VaR forecasts will be generated automatically.

## Learning Objectives

This project provides practical experience with:

* Financial volatility modeling
* Maximum Likelihood Estimation (MLE)
* GARCH models
* Value-at-Risk (VaR) forecasting and interpretation
* Financial risk management and backtesting techniques

