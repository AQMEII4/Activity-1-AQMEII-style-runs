# Overarching Document AQMEII4 (Activity 1)


## Input data for the simulations

Input data necessary to run the simulation have been prepared and are accessible to all participants. 

### Emission Inventory

_NA anthropogenic emissions:_

2010 and 2016 gridded files in CMAQ-ready format for the CB6 and SAPRC mechanisms have been prepared and are available at:

```
https://drive.google.com/drive/folders/1uyMXMs5yDAHNmq58YqJfApkMkrZVZCKW
```

_EU anthropogenic emissions_ 

Data for 2009 and 2010 are available at:

```
Host            : web-ftp81.tno.nl
Protocol        : FTP
Encryption      : Require explicit FTP over TLS
Logon type      : normal
User            : macc_iii@ftp0015.web-ftp81
Password        : AH2qzFtK64Uw
```

_EU forest fires emissions_

Data for 2009 and 2010 were kindly produced by FMI and are available at:

```
https://drive.google.com/drive/folders/1oBwX01iwE3Qz3S4PTU7d-K5jjFk2GqDH
```

_NA forest fires emissions_

Be aware that NA FF emissions are already included in the 2010/2016 CB6/SAPRC files EPA had prepared and posted on CMAS:

```
 https://drive.google.com/drive/folders/1uyMXMs5yDAHNmq58YqJfApkMkrZVZCKW
```

_Global data on NOx produced by lightning_

Data were assembled for AQMEII by the US-EPA starting from those gathered by GEIA and GEIA_ECCAD are available at:

```
https://drive.google.com/drive/folders/1R83HYZgn6qd0L01UN_u5nHeQ5swbMCYj
```

_Biogenic emissions_

Data are not available and should be accounted for by each modelling group according to the model set up:


### Boundary conditions 

_ECMWF reanalysis data for 2009/2010 (EU) and 2010/2016 (NA)_

Data, kindly provided by ECMWF, are available at:

```
ftp server      : dissemination.ecmwf.int
username        : htap
password        : dh45ya09
Data directory  : DATA/MACC_HTAP/eac4

or at:

https://drive.google.com/drive/folders/1rOLHivePbNqC4dIGG4ldQu5jFMyJj4Hq
```



## Output data expected

This activity of AQMEII4 relates to the regional scale simulations. Therefore output data will be expected in three different flavours:

1. _at all grid points of the computational domain projected on the common grid_
2. _at monitoring sites at surface_
3. _at monitoring sites as profiles_


_The space domains of the two common grids and the two years to be modelled are respectively for NA and EU:_

NA:

The origin (lower left corner) of the NA domain is at xmin=130°W and ymin=23.5°N. The domain consists of nx=565 grid points in the West-East direction and ny=281 grid points in the South-North direction. Because the domain origin represents the lower left corner of the first grid cell, the center of that first grid cell (nx=1, ny=1) is at 129.9375°W and 23.5625°N, and its upper right corner is at 129.875°W and 23.625°N. The model values to be reported for the first grid cell (nx=1, ny=1) therefore represent the range 130°W <-> 129.875°W, 23.5°N <-> 23.625°N.

Correspondingly, the total horizontal extent of the common NA domain, from the lower left corner of the first grid cell (nx=1, ny=1) to the upper right corner of the last grid cell (nx=565, ny=281), is defined as follows:

```
130°W <-> 59.375°W, 23.5°N <-> 58.625°N,
```

The years to be modeled are 2010 and 2016.

EU:

The origin (lower left corner) of the EU domain is at xmin=30°W and ymin=25°N. The domain consists of nx=721 grid points in the West-East direction and ny=361 grid points in the South-North direction. Because the domain origin represents the lower left corner of the first grid cell, the center of that first grid cell (nx=1, ny=1) is at 29.9375°W and 25.0625°N, and its upper right corner is at 29.875°W and 25.125°N. The model values to be reported for the first grid cell (nx=1, ny=1) therefore represent the range 30°W <-> 29.875°W, 25°N <-> 25.125°N.

Correspondingly, the total horizontal extent of the common EU domain, from the lower left corner of the first grid cell (nx=1, ny=1) to the upper right corner of the last grid cell (nx=721, ny=361), is defined as follows:

```
30 W <-> 60.125°E, 25°N <-> 70.125°N
```
The years to be modeled are 2009 and 2010.

_Spatial resolution:_ 

```
For both domains the spatial resolution of the common grids is 0.125° x 0.125° 
```

AQMEII4 simulations are identified by a "sequence-case" code SSSS-CCC, where SSSS is a four-digit number for the sequence and CCC is a three-digit number for the case.

_AQMEII4 sequences (SSSS) are:_

```
- 0241: North America (02), year 2010 (4), Grid (1)
- 0246: North America (02), year 2010 (4), Receptors (6)

- 0251: North America (02), year 2016 (5), Grid (1)
- 0256: North America (02), year 2016 (5), Receptors (6)

- 0341: Europe (03), year 2009 (4), Grid (1)
- 0346: Europe(03), year 2009 (4), Receptors (6)

- 0351: Europe (03), year 2010 (5), Grid (1)
- 0356: Europe(03), year 2010 (5), Receptors (6)
```

### 1. Output at all gridpoints 
The variables requested at every grid point of the common grid as described in the classifications above mentioned are presented in:

- [NA2010](../domains/NA2010/0241/)
- [NA2016](../domains/NA2016/0251/)
- [EU2009](../domains/EU2009/0341/)
- [EU2010](../domains/EU2010/0351/)

### 2. Output at receptors
The variables requested at every receptor as described in the classifications above mentioned are presented in:

- [NA2010](../domains/NA2010/0246/) 
- [NA2016](../domains/NA2016/0256/) 
- [EU2009](../domains/EU2009/0346/) 
- [EU2010](../domains/EU2010/0356/)

For every set of variables presented, the corresponding Technical Specification Document (TSD) see next sectiion, and metafile for the encoding precedure is included in the corresponding directory.


## Submitting model output to ENSEMBLE: Technical Specification Documents, Metafiles, and ENFORM

Prior to the preparation of the output, we strongly advice all participants to read the document in Appendix one which gives the rational behind the variable selection how to interpret themaccording to the varous schemes used.

Information relating to submission of model results for the runs to be performed for the XX20YY (where XX will be NA and EU for the North American and European case respectively and YY for the corresponding years) case study is contained in the archive file named “TSD-metafile-enform-XX20YY-2D.zip” that will be delivered to you following your request of a user ID and password to access to input data.

This archive includes:

- documents called Technical Specification Documents (TSDs);
- ASCII files called Metafiles (extension src);
- one archive containing Fortran programs.

The TSDs provide detailed instructions on the preparation and transmittal of model-predicted. Every other data type (gridded, point evaluation, vertical profile, volume, satellite, etc) will have a dedicated TSD which will also be different if it applies to EU or NA case. Much of the information contained in the TSDs is repeated but every TSD contains all information necessary to prepare the model output.

The suite of ENFORM programs to convert model output into ENSEMBLE data file is standard and applies to all data types. One program named enform_aq.f will manage the transformation of format for 2D model output and a companion program, enform_aqr.f, will manage model output for receptors and vertical profiles. These programs will need some meta data information that will be delivered with the zip file.
 
The model output submission procedure has been devised to be simple and standardized.  It is based on experience gathered over the last 10 years of using the ENSEMBLE system for emergency response applications of air quality mesoscale models.  Several communities of AQ modellers have used it to date with no major problems.  

As you will realize we have opted for separating the outputs into the smallest possible information set (one variable per file) as we want you to transfer your model results via FTP rather than by shipping hard disks to the JRC.  Once the files reach us they will be uploaded to the ENSEMBLE system and you will then be able to access them remotely through the web interface.  This will allow you to check on the correct upload of your results and then to compare your model results with other model results and with monitoring data and to perform ensemble analyses.

### Land Use Types
Model results on deposition will have to be reported on specific common land use (LU) types. This common list of LU types is presented in the following table. An [excel spread sheet](https://github.com/AQMEII4/Activity-1-AQMEII-style-runs/blob/master/OverarchingDocuments/AQMEII4_LanduseCategories_20200501.xlsx) was created in which all model native LU types were mapped to the types listed in the table. This spreadsheet was created based on a particpant survey conducted in spring 2019 and contains the suggested mapping of the native LU types reported by the survey respondents to the common AQMEII4 LU types. Participants are free to adjust this suggested mapping from their native LU types to the 16 AQMEII4 LU types but are expected to document and report whatever mapping approach they implement. Please also see item #3 in the [FAQ document](./AQMEII4%20FAQ%20version%205_20200213.pdf).

When reporting the results per land type the numbering in the table should be considered as reference:

|Type Number|Generic LU Categories for Remapping|
|:---:|:---:|
|01|Water|
|02|Developed-Urban|
|03|Barren|
|04|Evergreen needleleaf forest|
|05|Deciduous needeleaf forest|
|06|Evergreen broadleaf forest|
|07|Deciduous broadleaf forest|
|08|Mixed forest|
|09|Shrubland|
|10|Herbaceous|
|11|Planted/Cultivated|
|12|Grassland|
|13|Savanna|
|14|Wetlands|
|15|Tundra|
|16|Snow and Ice|




## Appendix 1

Guidelines to the interpretation of the output requested in relation to the various kinds of schemes used within the community.  by P.A. Makar, O. Clifton, D. Schwede, July 15, 2019 (version 6.0)

[download](AQMEII-4_Reported_gas_phase_deposition_terms_guidance_July15_2019.pdf)


## Appendix 2

This appendix provides evidence of the importance of acquiring the components of different deposition schemes, in order to understand the  different roles that different path ways can have in determining  values of total deposition. by O. Clifton

[download](Clifton_diagnostics_AQMEII.pdf)

## Appendix 3

This appendix provides example spatial maps of the requested output variables from several participating models as well as selected presentatations given by AQMEII4 team members.

[WRF-Chem Example, provided by A. Lupascu](./WRF-Chem_Example_deposition_variables.pdf)

[GEM-MACH Example, provided by P. Makar](./GEM-MACH_Example-Net_Values_All.pdf)

[Paul Makar's NADP 2021 Spring Meeting Presentation](./Makar_NADP_Spring2010_AQMEII4_Overview.pptx)

[Christian Hogrefe's 2020 CMAS Conference Presentation](https://www.cmascenter.org/conference/2020/slides/HogrefeEtAl_CMAS_Presentation_AQMEII4_CMAQ_Final.pdf)

## Appendix 4

This appendix provides a list of errata, corrections, and FAQ for Activity 1. It was developed by Paul Makar following participant feedback during the [Hamburg workshop](https://github.com/AQMEII4/Activity-1-AQMEII-style-runs/blob/master/ParticipantCallNotes/AQMEII4_WorkshopNotes_20190926.pdf) in September 2019. It is being updated regularly by Paul Makar and Christian Hogrefe based on additional feedback obtained during [participant calls](https://github.com/AQMEII4/Activity-1-AQMEII-style-runs/blob/master/ParticipantCallNotes/ListOfCalls.md) and through email exchanges between participants.

[FAQ](./AQMEII4%20Errata_Corrections_FAQ%20version%206_20201111.pdf)

## Appendix 5

This appendix provides an example of how to use CDO to regrid model output from its native grid to the common AQMEII4 latitude / longitude grid.

[Regridding example](https://github.com/AQMEII4/Activity-1-AQMEII-style-runs/blob/master/OverarchingDocuments/RegriddingExamples/README.md)


