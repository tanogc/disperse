#DISPERSE, a trait database to assess the dispersal potential of European aquatic macroinvertebrates

DISPERSE includes nine dispersal-related traits subdivided into 39 trait categories for 480 taxa, including Annelida, Mollusca, Platyhelminthes, and Arthropoda such as Crustacea and Insecta, generally at the genus level. Information within DISPERSE can be used to address fundamental research questions in metapopulation ecology, metacommunity ecology, macroecology and evolutionary ecology. Information on dispersal proxies can be applied to improve predictions of ecological responses to global change, and to inform improvements to biomonitoring, conservation and management strategies. 

This code re-creates analysis for "A trait space at an overarching-scale yields more conclusive macroecological patterns of functional diversity" and illustrate potential practical uses through the calculation of functional diversity metrics and mean community traits.

##Original article:

Please, use this citation to reference the database:
```
Sarremejane, R., Cid, N., Stubbington, R. et al. DISPERSE, a trait database to assess the dispersal potential of European aquatic macroinvertebrates. Sci Data 7, 386 (2020). https://doi.org/10.1038/s41597-020-00732-7
```

# R files description:

•	0_FD_functions.R: R script to estimate Functional Diversity (FD) metrics
•	0_quality_funct_space_fromdist.R: R function for computing the quality of functional dendrogramm and multidimensional functional spaces. This function is a simplified version of the Appendix S1 associated to Maire et al. 2015 Global Ecology and Biogeography 24, 728–740.
•	1_Exploring_Disperse.R: Main code to reproduce the results presented in the paper
•	2_Disperse_in_action: Illustration of potential practical uses through the calculation of functional diversity metrics and mean community traits

# Example data
•	taxa.txt: matrix including 44 macroinvertebrate taxa from 22 sites.

Please, cite the original taxonomic database and paper to reference this dataset:

```
Bonada, N., Rieradevall, M. & Prat, N. Macroinvertebrate community structure and biological traits related to flow permanence in a Mediterranean river network. Hydrobiologia 589, 91–106 (2007).

Jeliazkov, A., Mijatovic, D., Chantepie, S. et al. A global database for metacommunity ecology, integrating species, traits, environment and space. Sci Data 7, 6 (2020). https://doi.org/10.1038/s41597-019-0344-7
```

# Dependencies

To run the code and functions from this repository, you need to install the following packages: 'ade4','ape','clue', 'cluster', 'FD', 'geometry', 'gtools','plyr', 'MuMIn', 'vegan'. Use this code to install them:

```
install.packages(c("ade4","ape","clue", "cluster", "FD", "geometry",
                   "gtools","plyr", "MuMIn", "vegan"))

```

Along with other appropriate package citations, please, cite this code to reference R Functions to estimate functional diversity.

```
Múrria, C., Iturrarte, G., Gutiérrez-Cánovas, C., 2020. A trait space at an overarching-scale yields more conclusive macroecological patterns of functional diversity. Global Ecology and Biogeography 29 (10), 1729-1742
```

Please, send questions or problems related with the use of this code to Romain Sarremejane (romain.sarremejane@gmail.com) or Núria Cid (ncid@ub.edu) or Cayetano Gutiérrez-Cánovas (cayeguti@um.es).
