README
==========

The files in this folder were prepared by Christian Hogrefe (U.S. EPA) to provide an example to participants in AQMEII4 Activity 1 of how the regridding of model output from a model's native grid to the common AQMEII4 latitude / longitude analysis grid may be accomplished. For questions or comments, please contact Christian Hogrefe at hogrefe.christian@epa.gov

This folder contains two example csh scripts ([regrid_cmaq_lambert_latlon_cdo_remapcon_example.csh](./regrid_cmaq_lambert_latlon_cdo_remapcon_example.csh) and [regrid_cmaq_lambert_latlon_cdo_remapnn_example.csh](./regrid_cmaq_lambert_latlon_cdo_remapnn_example.csh)) to regrid a CMAQ I/O API netCDF output file from its native Lambert Conformal grid over North America to the AQMEII4 common latitude / longitude grid using the Climate Data Operators (CDO) tool. The two example scripts use the CDO conservative remapping option (remapcon) and nearest neighbor remapping option (remapnn), respectively. The scripts also make use of several programs that are part of the netCDF Operator (NCO) suite of tools to edit variables, dimensions, and attributes from the regridded file created by CDO to make it usable with I/O API library functions*. Documentation of the CDO regridding options can be found in the [CDO user guide](https://code.mpimet.mpg.de/projects/cdo/embedded/index.html#x1-6020002.12).

The folder also contains the [CMAQ I/O API netCDF file](./CMAQ_O3_Example_Lambert_12US1_20160101.nc) used as input to the two regridding scripts as well as the two ASCII grid definition files required by CDO to describe the [source](./grid_file_12us1_459_299.txt) and [target](grid_file_aqmeii4_latlon_565_281_lonlat.txt) domain for regridding (note that the ASCII file used to describe the source grid is needed in this CMAQ example but may not be  needed for other input files if these other source files follow [Climate and Forecast (CF) conventions for coordinates](http://cfconventions.org/Data/cf-conventions/cf-conventions-1.8/cf-conventions.html#coordinate-types)).

The Fortran code used to create the two ASCII files is also provided as are the input files required by one of these two pieces of Fortran code. The [Fortran code creating the ASCII file describing the AQMEII4 common grid for North America](./write_cdo_gridfile_aqmeii4_latlon_565_281.f) does not require any external libraries for compilation. The [Fortran code creating the ASCII file describing the grid of the example CMAQ I/O netCDF file](./write_cdo_gridfile_12us1_459_299.f) requires the netCDF and I/O API libraries for compilation since it reads latitude and longitude information from the [GRIDCRO2D](./GRIDCRO2D_160808.nc) and [GRIDDOT2D](./GRIDDOT2D_160808.nc) I/O API netCDF files.

## Software requirements:

* [CDO](http://mpimet.mpg.de/cdo)
(required for regridding)

* [NCO](http://nco.sourceforge.net/)
(only required if editing variables, attributes, and/or dimensions after regridding as done in the example scripts)

* [I/O API](https://www.cmascenter.org/ioapi/)
(only required if modifying and recompiling the Fortran code used to describe the grid of a CMAQ file used as input to CDO regridding)

* [netCDF](https://www.unidata.ucar.edu/software/netcdf/)
(required by CDO, NCO, and I/O API)


## *NOTE:
This use of NCO programs is a hack to manipulate the output from CDO regridding to almost 'look like' a standard I/O API netCDF file. This is done by renaming dimensions, removing dimensions and variables, and editing attributes using the NCO suite of tools. It "works" in the sense that the final file can be opened by VERDI, I/O API tools like m3xtract, and used by  I/O API library funcions like OPEN3, READ3, etc. However, this is NOT a clean way of creating an "I/O API compliant" file - the proper way to do this
would be to write Fortran code linked with both the netCDF and I/O API libaries that would then read (via plain netCDF read commands) the CDO regridded output file, define the output grid and time structure using I/O API conventions, and create and write the
output file via calls to OPEN3 and WRITE3.
