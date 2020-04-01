#!/bin/csh

set EXEC1 = /home/chogrefe/atmos_intel18_netcdf463/bin/cdo
set EXEC2 = /home/chogrefe/atmos_intel18_nco473/bin/ncrename
set EXEC3 = /home/chogrefe/atmos_intel18_nco473/bin/ncks
set EXEC4 = /home/chogrefe/atmos_intel18_nco473/bin/ncatted


set INDIR = /home/chogrefe/work_tmp/aqmeii4/data/combine/Example
set OUTDIR = /home/chogrefe/work_tmp/aqmeii4/data/combine/Example_LatLon

set INFILE = CMAQ_O3_Example_Lambert_12US1_20160101.nc

set OUTFILE = CMAQ_O3_Example_LATLON_CDO_REMAPCON_12US1_20160101.nc

set OUTFILE_IOAPI = CMAQ_O3_Example_LATLON_CDO_IOAPI_REMAPCON_12US1_20160101.nc

date

###Horizontal interpolation can be done with the CDO operators:
###remapbil - Bilinear interpolation
###remapbic - Bicubic interpolation
###remapdis - Distance-weighted average remapping
###remapnn - Nearest neighbor remapping
###remapcon - First order conservative remapping

### Perform first order conservation remapping of the IOAPI/netcdf
### file with hourly CMAQ fields for the entire year
### The original file uses the 12US1 (459x299 grid cell) 12 km 
### Lambert conformal grid. Since the IOAPI/netcdf file does not
### contain standard lat/lon dimensions and variables, the structure
### of the source grid is specified via the 'setgrid' option and 
### corresponding ASCII file
### The structure of the target grid (NA latlon domain 585x281 cells)
### is defined via the grid_file_aqmeii4_latlon_565_281_lonlat.txt
### ASCII file
### The missing value is set to -9.999E+36 (IOAPI BADVAL3) instead of
### the CDO standard -9E+33 for IOAPI compatiblity
###
### To perform nearest neighbor remapping, replace 'remapcon'
### with 'remapnn'
###

time ${EXEC1} -m -9.999E+36 \
              remapcon,/home/chogrefe/work1/aqmeii4/scripts/grid_file_aqmeii4_latlon_565_281_lonlat.txt \
              -setgrid,/home/chogrefe/work1/aqmeii4/scripts/grid_file_12us1_459_299.txt \
	      ${INDIR}/${INFILE} \
	      ${OUTDIR}/${OUTFILE}

### Make the regridded file "ioapi compliant"
### NOTE: this is a hack to manipulate the output
### from 'CDO remapcon' to almost 'look like' a
### standard IOAPI/netcdf file. This is done by
### renaming dimensions, removing dimensions and
### variables, and editing attributes using the
### NCO suite of tools. It 'works' in the sense 
### that the final file can be opened by VERDI,
### ioapi tools like m3xtract, and used by 
### ioapi library funcions like OPEN3, READ3,
### etc.
### However, this is NOT a clean way of creating
### an "ioapi compliant" file - the proper way
### to do this would be to write fortran code
### linked with both the netcdf and ioapi libaries
### that would then read (via plain netcdf read
### commands) the 'CDO remapcon' output file, 
### define the output grid and time structure
### using IOAPI global variables, and create and
### write the output file via calls to OPEN3 and
### WRITE3.
###

### First, rename the time, lon, and lat dimensions to TSTEP, COL, and ROW
### see https://sourceforge.net/p/nco/discussion/9830/thread/e9f6a7f2a8/
### why ncrename has to be invoked 3 times

time ${EXEC2} -O -d time,TSTEP  ${OUTDIR}/${OUTFILE}
time ${EXEC2} -O -d lon,COL  ${OUTDIR}/${OUTFILE}
time ${EXEC2} -O -d lat,ROW ${OUTDIR}/${OUTFILE}

### Next, delete unneeded variables added by CDO regridding
### These are time, lon, lon_bnds, lat, and lat_bnds
### This creates a new output file

time ${EXEC3} -x -v time,lon,lon_bnds,lat,lat_bnds \
              ${OUTDIR}/${OUTFILE} \
	      ${OUTDIR}/${OUTFILE_IOAPI}

### Remove the intermediate OUTFILE if desired

# 'rm' ${OUTDIR}/${OUTFILE}

### Next, rename the history attribute to HISTORY as needed by IOAPI

time ${EXEC2} -a global@history,HISTORY ${OUTDIR}/${OUTFILE_IOAPI}

### Finally, modify the projection and grid global attributes
### from their IOAPI values of the source (Lambert) grid to
### their target IOAPI values of the target (NA LatLon) grid
### and remove unnecessary global and variable attributes
### Note, removing the NCO global attribute via an additional
### line similar to the 'CDO' like below did not work in 
### my tests, ncatted (which is part of NCO) may not allow
### that deletion. However, the NCO attribute in the final
### file does not appear to cause a problem for VERDI etc.

time ${EXEC4} -O -a _FillValue,,d,, \
                 -a missing_value,,d,, \
                 -a CDI,global,d,, \
                 -a Conventions,global,d,, \
                 -a CDO,global,d,, \
                 -a NCOLS,global,m,l,565 \
                 -a NROWS,global,m,l,281 \
                 -a GDTYP,global,m,l,1 \
                 -a P_ALP,global,m,f,0. \
                 -a P_BET,global,m,f,0. \
                 -a P_GAM,global,m,f,0. \
                 -a XORIG,global,m,f,-130. \
                 -a YORIG,global,m,f,23.5 \
                 -a XCELL,global,m,f,0.125 \
                 -a YCELL,global,m,f,0.125 \
		 ${OUTDIR}/${OUTFILE_IOAPI}

date


