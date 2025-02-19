# MCA-analysis
MCA analysis of variables and openEHR CDRs. The variables/CDRs are taken from a survey

contents
README: this file
DimensionsReductionSurvey-12VARIAB_11CDR.ipynb : jupyter notebook
MCAAnalysis.r: R script tested with RStudio
AASER_11CDR.csv : input for DimensionsReductionSurvey-12VARIAB_11CDR.ipynb
input.csv : input for MCAAnalysis.r 

Configuration used in tests
For python notebook
Jupyter Notebook version 6.03
Python 3.8.10
Numpy 1.23.0
Pandas 1.3.2
Prince 0.7.1
matplotlib==3.4.3
matplotlib-inline==0.1.6
plotly==5.4.0
scikit-learn==0.24.2
scikit-learn-extra==0.2.0


For R script
R version base 4.3.3
R Studio 2023.12.1
FactoMineR 2.10
corrplot 0.92
factoextra 1.0.7
ggpubr 0.6.0
plotly 4.10.4
ggplot2 3.4.4
rgl (not used here but can be useful 1.3.1)
FactoInvestigate (used in MCA, not in FAMD) 1.9

# Acknowledgments
This work has been partially funded by the following sources:
<ul>
<li>    the “Total Patient Management” (ToPMa) project (grant by the Sardinian Regional Authority, grant number RC_CRP_077);</li>
<li>    the “Processing, Analysis, Exploration, and Sharing of Big and/or Complex Data” (XDATA) project (grant by the Sardinian Regional Authority);</li>
<li>    the “Piattaforma avanzata per Analisi massiva e Medicina digitale” project (grant by Sardegna Ricerche, ex art 9 L.R. 20/2015-year 2020).</li>
<li>    the “Pathology in Automated Traceable Healthcare” (PATH) project (grant by the Italian Ministry of Education, University and Research. grant number PON04a2_0055).</li>
</ul>
