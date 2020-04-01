!! ifort -extend-source write_cdo_gridfile_12us1_459_299.f -I/home/wdx/lib/x86_64/ifc-18.0/netcdf-4.4.1/include -L/home/wdx/lib/x86_64/ifc-18.0/netcdf-4.4.1/lib -lnetcdff -lnetcdf -I/home/wdx/lib/x86_64/ifc-18.0/ioapi_3.1/Linux2_x86_64ifort -L/home/wdx/lib/x86_64/ifc-18.0/ioapi_3.1/Linux2_x86_64ifort  -lioapi -o write_cdo_gridfile_12us1_459_299

cc
        use m3utilio
        implicit none

	integer i,j,k
	real, allocatable:: lat_crs(:,:),lon_crs(:,:)
	real, allocatable:: lat_crs_bnds(:,:,:),lon_crs_bnds(:,:,:)
	real, allocatable:: lat_dot(:,:),lon_dot(:,:)

	character*120 filenamecdf

c	*******************************************************************
c	******************************************************************


c
c	GRIDDOT2D
c
	filenamecdf =
     *    '/work/MOD3EVAL/css/AQMEII4/inputs/met/mcip/'//
     *    '2016/mcip_v50_wrf_v411_noltng/'//
     *    'GRIDDOT2D_160808.nc' 

 	if (.not. SETENVVAR ('GRIDDOT2D',filenamecdf)) then
	  print *, "Not able to set environment variable"
	endif

	if (.not. OPEN3('GRIDDOT2D',FSREAD3,'cdf2uamv')) then
	  print *, "Not able to open CCTM file"
	  call M3EXIT('map_conc_8hrdm',0,0,'input file not available',2)
	endif
	
	if (.not. DESC3('GRIDDOT2D')) then
	  print *, "Not able to describe CCTM file"
	  call M3EXIT('map_conc_8hrdm',0,0,'input file not describable',2)
	endif
	
	allocate(lat_dot(NCOLS3D,NROWS3D))
	allocate(lon_dot(NCOLS3D,NROWS3D))

	if (.not.READ3('GRIDDOT2D','LATD',1,SDATE3D,STIME3D,lat_dot)) then
	 print *, 'problem reading at ',SDATE3D,STIME3D
	endif

	if (.not.READ3('GRIDDOT2D','LOND',1,SDATE3D,STIME3D,lon_dot)) then
	 print *, 'problem reading at ',SDATE3D,STIME3D
	endif


	if (.not. close3('GRIDDOT2D')) print *, 'Problem closing GRIDDOT2D'

c
c	GRIDCRO2D
c
	filenamecdf =
     *    '/work/MOD3EVAL/css/AQMEII4/inputs/met/mcip/'//
     *    '2016/mcip_v50_wrf_v411_noltng/'//
     *    'GRIDCRO2D_160808.nc' 

 	if (.not. SETENVVAR ('GRIDCRO2D',filenamecdf)) then
	  print *, "Not able to set environment variable"
	endif

	if (.not. OPEN3('GRIDCRO2D',FSREAD3,'cdf2uamv')) then
	  print *, "Not able to open CCTM file"
	  call M3EXIT('map_conc_8hrdm',0,0,'input file not available',2)
	endif
	
	if (.not. DESC3('GRIDCRO2D')) then
	  print *, "Not able to describe CCTM file"
	  call M3EXIT('map_conc_8hrdm',0,0,'input file not describable',2)
	endif
	
	allocate(lat_crs(NCOLS3D,NROWS3D))
	allocate(lon_crs(NCOLS3D,NROWS3D))
	allocate(lat_crs_bnds(NCOLS3D,NROWS3D,4))
	allocate(lon_crs_bnds(NCOLS3D,NROWS3D,4))

	if (.not.READ3('GRIDCRO2D','LAT',1,SDATE3D,STIME3D,lat_crs)) then
	 print *, 'problem reading at ',SDATE3D,STIME3D
	endif

	if (.not.READ3('GRIDCRO2D','LON',1,SDATE3D,STIME3D,lon_crs)) then
	 print *, 'problem reading at ',SDATE3D,STIME3D
	endif

	if (.not. close3('GRIDCRO2D')) print *, 'Problem closing GRIDCRO2D'
	
c
c	store the cell bounds ("dot points") from the GRIDDOT2D file
c	store counter-clockwise, starting with lower right (SE) corner
c	example: climate-cryosphere.org/wiki/index.php?title=Regridding_with_CDO
c

	do i = 1, NCOLS3D
	 do j = 1, NROWS3D
	  lat_crs_bnds(i,j,1) = lat_dot(i+1,j) !SE corner
	  lon_crs_bnds(i,j,1) = lon_dot(i+1,j) !SE corner
	  lat_crs_bnds(i,j,2) = lat_dot(i+1,j+1) !NE corner
	  lon_crs_bnds(i,j,2) = lon_dot(i+1,j+1) !NE corner
	  lat_crs_bnds(i,j,3) = lat_dot(i,j+1) !NW corner
	  lon_crs_bnds(i,j,3) = lon_dot(i,j+1) !NW corner
	  lat_crs_bnds(i,j,4) = lat_dot(i,j) !SW corner
	  lon_crs_bnds(i,j,4) = lon_dot(i,j) !SW corner
	 enddo !j
	enddo !i
	
c
c	create CDO grid file, following the example at the link above
c
	open (unit=14,file='grid_file_12us1_459_299.txt',status='unknown')
	
	write(14,'(a)') '# 12 US1 459x299 Lambert Conformal Grid File'
	write(14,'(a)') ''
	write(14,'(a)') 'gridtype = curvilinear'
	write(14,'(a,i0)') 'gridsize = ',NCOLS3D * NROWS3D
	write(14,'(a,i0)') 'xsize = ',NCOLS3D
	write(14,'(a,i0)') 'ysize = ',NROWS3D
	write(14,'(a)') ''

	write(14,'(a)') '# Longitudes'
	write(14,'(a)') 'xvals ='
	do j = 1, NROWS3D
	 do i = 1, NCOLS3D
	  write(14,'(f0.6)') lon_crs(i,j)
	 enddo !i
	enddo !j
	write(14,'(a)') ''
	  
	write(14,'(a)') '# Longitudes of cell corners'
	write(14,'(a)') 'xbounds ='
	do j = 1, NROWS3D
	 do i = 1, NCOLS3D
	  write(14,'(4(f0.6,1x))') (lon_crs_bnds(i,j,k),k=1,4)
	 enddo !i
	enddo !j
	write(14,'(a)') ''
	
	write(14,'(a)') '# Latitudes'
	write(14,'(a)') 'yvals ='
	do j = 1, NROWS3D
	 do i = 1, NCOLS3D
	  write(14,'(f0.6)') lat_crs(i,j)
	 enddo !i
	enddo !j
	write(14,'(a)') ''
	  
	write(14,'(a)') '# Latitudes of cell corners'
	write(14,'(a)') 'ybounds ='
	do j = 1, NROWS3D
	 do i = 1, NCOLS3D
	  write(14,'(4(f0.6,1x))') (lat_crs_bnds(i,j,k),k=1,4)
	 enddo !i
	enddo !j

	close(unit=14)
	
	
	end


 



