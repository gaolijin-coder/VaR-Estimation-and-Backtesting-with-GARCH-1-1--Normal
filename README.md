PROJET : Estimation de la Value-at-Risk (VaR) avec un modèle GARCH(1,1)-Normal
Cours : Méthodes statistiques pour données financières
Auteur : Mazidath Imorou - 11279605
         Lijin Gao - 11364985
         Aida Diop - 11364669

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
