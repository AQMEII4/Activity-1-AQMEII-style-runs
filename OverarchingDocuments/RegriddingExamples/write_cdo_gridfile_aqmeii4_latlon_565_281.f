!! ifort -extend-source write_cdo_gridfile_aqmeii4_latlon_565_281.f -o write_cdo_gridfile_aqmeii4_latlon_565_281

        implicit none

	integer i,j,k
	integer nx,ny
	integer ncols3d, nrows3d
	real xorig,yorig,dx,dy
	real, allocatable:: lat_crs(:,:),lon_crs(:,:)
	real, allocatable:: lat_crs_bnds(:,:,:),lon_crs_bnds(:,:,:)
	real, allocatable:: lat_dot(:,:),lon_dot(:,:)

	character*120 filenamecdf

c	*******************************************************************
c	******************************************************************


c
c	grid cell corners (dot points)
c

        NX = 565 !AQMEII4 domain has nx=565 cells
	NY = 281 !AQMEII4 domain has nx=565 cells

	XORIG = -130.
	YORIG = 23.5
	
	DX = 0.125
	DY = 0.125
		
        NCOLS3D = NX + 1 ! this is for dot points
        NROWS3D = NY + 1 ! this is for dot points
	
	
	allocate(lat_dot(NCOLS3D,NROWS3D))
	allocate(lon_dot(NCOLS3D,NROWS3D))
	
	do i = 1, NCOLS3D
	 do j = 1, NROWS3D
	  lat_dot(i,j) = YORIG + (j-1) * DY
	  lon_dot(i,j) = XORIG + (i-1) * DX
	 enddo !j
	enddo !i



c
c	grid cell center (cross points)
c
		
        NCOLS3D = NX ! this is for cross points
        NROWS3D = NY ! this is for cross points
	
	allocate(lat_crs(NCOLS3D,NROWS3D))
	allocate(lon_crs(NCOLS3D,NROWS3D))
	allocate(lat_crs_bnds(NCOLS3D,NROWS3D,4))
	allocate(lon_crs_bnds(NCOLS3D,NROWS3D,4))

	do i = 1, NCOLS3D
	 do j = 1, NROWS3D
	  lat_crs(i,j) = YORIG + (j-1) * DY + 0.5 * DY
	  lon_crs(i,j) = XORIG + (i-1) * DX + 0.5 * DX
	 enddo !j
	enddo !i
	
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
c	create CDO grid file, following the example at the link above, defining it as 'curvilinear'
c       also see the description at code.mpimet.mpg.de/project/cdo/embedded/index.html
c
	open (unit=14,file='grid_file_aqmeii4_latlon_565_281.txt',status='unknown')
	
	write(14,'(a)') '# AQMEII4 LATLON NA File'
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
	


c
c	create CDO grid file, following the example at the link above, defining it as 'lonlat'
c       also see the description at code.mpimet.mpg.de/project/cdo/embedded/index.html
c       in this example, we only use 2 rather than 2 "bounds" / verteces for each grid
c
	open (unit=14,file='grid_file_aqmeii4_latlon_565_281_lonlat.txt',status='unknown')
	
	write(14,'(a)') '# AQMEII4 LATLON NA File'
	write(14,'(a)') ''
	write(14,'(a)') 'gridtype = lonlat'
	write(14,'(a,i0)') 'gridsize = ',NCOLS3D * NROWS3D
	write(14,'(a,i0)') 'xsize = ',NCOLS3D
	write(14,'(a,i0)') 'ysize = ',NROWS3D
	write(14,'(a)') ''

	write(14,'(a)') '# Longitudes'
	write(14,'(a)') 'xvals ='
	do i = 1, NCOLS3D
	 write(14,'(f0.6)') lon_crs(i,1)
	enddo !i
	write(14,'(a)') ''
	  
	write(14,'(a)') '# Longitudes of cell corners'
	write(14,'(a)') 'xbounds ='
	do i = 1, NCOLS3D
	 write(14,'(2(f0.6,1x))') lon_crs_bnds(i,1,3),lon_crs_bnds(i,1,2)
	enddo !i
	write(14,'(a)') ''
	
	write(14,'(a)') '# Latitudes'
	write(14,'(a)') 'yvals ='
	do j = 1, NROWS3D
	 write(14,'(f0.6)') lat_crs(1,j)
	enddo !j
	write(14,'(a)') ''
	  
	write(14,'(a)') '# Latitudes of cell corners'
	write(14,'(a)') 'ybounds ='
	do j = 1, NROWS3D
	 write(14,'(2(f0.6,1x))') lat_crs_bnds(1,j,1),lat_crs_bnds(1,j,2)
	enddo !j

	close(unit=14)
	

	
	end


 



