## **HawaiiDust**: MATLAB code for MERRA-2 subset analysis of dust and precipitation

This repository accompanies an in-review manuscript (pre-print draft: https://essopenarchive.org/doi/full/10.22541/essoar.172072594.47905552/ ) that examines atmospheric dust concentrations in a portion of the South Pacific near Hawaii between the period 1980 to 2023. 

Code is written in MATLAB and is found in the primary (root) directory. 

Figure and table outputs are provided in so-named subdirectories (PNG only Github, though Matlab .FIG files are also generated by most plotting scripts).

To get the scripts to work, you will have to download MERRA-2 .NC files, which are too large to store on Github. These files can be downloaded via https://disc.gsfc.nasa.gov/datasets?project=MERRA-2

A general run-order for the scripts is:
- Download daily, spatially subset MERRA-2 data files (for dust/aerosols) into the "MERRA2-Hawaii_aer" subdirectory
- Download daily, spatially subset MERRA-2 data files (for precipitation) into the "MERRA2-Hawaii_flx" subdirectory
- Check, using the script "findMissingNCfiles.m" for any missing files in the data source/download directories
- Run "readMERRA2.m" and "readMERRA2_precip.m" to load and calculate key data tables for the dust and precipitation analyses
- Run "readClimateIndicators.m" to load the climate indicators (PDO and NINO) stored as text files in the "ClimateIndicators" subdirectory
- Run "makeAncillaryVars.m" to generate all ancillary variables used and plotted by the analysis
- Run any of the "plot..." scripts to create plots.
- Contact the lead author, dan at uga d0t edu, if you have questions