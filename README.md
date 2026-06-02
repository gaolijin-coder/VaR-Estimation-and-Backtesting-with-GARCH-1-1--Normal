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




PROJET : Estimation de la Value-at-Risk (VaR) avec un modèle GARCH(1,1)-Normal
Cours : Méthodes statistiques pour données financières
Auteur : Lijin Gao
Mazidath Imorou
Aida Diop

DESCRIPTION DU PROJET
Ce projet vise à estimer la Value-at-Risk (VaR) pour deux indices financiers (SP500 et FTSE100) en utilisant un modèle GARCH(1,1) avec erreurs normales.
L’objectif est de modéliser la volatilité conditionnelle des rendements financiers et de produire une prévision de risque sur une periode de 1000 jours.

STRUCTURE DU DOSSIER
Le projet est organisé de la manière suivante :


* Data : contient les données financières (fichier indices.rda)
* Code : contient les scripts R du projet
* Output : contient les graphiques et résultats générés
* Function : contient les fonctions utilisées dans le cadre du projet
* README.md : description du projet et information generale
* Rmarkdown : contient mélange texte, code R, et résultats du code

DONNÉES UTILISÉES
Le fichier indices.rda contient les prix de deux indices financiers :

* SP500
* FTSE100

Les données sont sous forme de séries temporelles.
Les rendements logarithmiques sont calculés à partir des prix.

MÉTHODOLOGIE
Les étapes principales du projet sont :

1. Chargement des données financières
2. Filtrage des observations à partir de janvier 2005
3. Calcul des rendements logarithmiques
4. Estimation d’un modèle GARCH(1,1) par la methode du maximum de vraisemblance
5. Calcul de la variance conditionnelle
6. Prévision de la Value-at-Risk (VaR) à 95%

MODÈLE UTILISÉ
Le modèle utilisé est un GARCH(1,1)-Normal :

σ²(t+1) = ω + α y(t)² + β σ²(t)

où :

* ω : constante
* α : effet ARCH (chocs passés)
* β : persistance de la volatilité

La VaR est calculée à partir de la variance conditionnelle prévue :

VaR = Φ⁻¹(1 − niveau) × σ(t+1)

LOGICIEL ET PACKAGES
Le projet est réalisé avec RStudio.

Packages utilisés :

* here (gestion des chemins de fichiers)
* xts (séries temporelles financières)
* PerformanceAnalytics (calcul du rendement)

COMMENT EXÉCUTER LE PROJET

1. Ouvrir le projet RStudio (.Rproj)
2. Vérifier que le dossier de travail contient les sous-dossiers data, output...
3. Exécuter le script principal dans l’ordre
4. Les résultats et graphiques seront générés automatiquement

OBJECTIF PÉDAGOGIQUE
Ce projet permet de comprendre :

* la modélisation de la volatilité financière
* l’estimation des parametres parla methode du maximum de vraisemblance
* l’utilisation du modèle GARCH 
* le calcul et l’interprétation de la Value-at-Risk
