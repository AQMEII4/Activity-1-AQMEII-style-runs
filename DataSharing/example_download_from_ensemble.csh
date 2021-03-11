#!/bin/csh

set user = my_ensemble_user_name
set password = my_ensemble_password

set mcode = 10700

set case = 0241

set year = 2010

# start_date_hour is 01010100 for 10700 and 10701 and 01010000 for 10703 - 10705

set start_date_hour = 01010100

foreach sequence (001 002 005 012 022 032 042 052 062 072 082 092 102 112 122 132 142 152 162 172 182 192 202 212 222 232 242 252 262 272 282 292 302 312 322 332 342 352 362 372 382 392 402 412 422 432 442 452 462 472)

mkdir -p /work/MOD3EVAL/css/AQMEII4/work/data/ENSEMBLE_DOWNLOADS/${mcode}/${case}/${sequence}

cd /work/MOD3EVAL/css/AQMEII4/work/data/ENSEMBLE_DOWNLOADS/${mcode}/${case}/${sequence}

foreach var (01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99)

#wget --user=${user} --password=${password} https://ensemble.jrc.ec.europa.eu/ensemble/pvt/aqmeii4/${mcode}/${case}/${sequence}/${mcode}-${case}-${sequence}-${var}-01-${year}${start_date_hour}.ens.bz2
#
#if storing password in .netrc in home directory, the command below can be used and password does not need to be set above
#

wget --user=${user} https://ensemble.jrc.ec.europa.eu/ensemble/pvt/aqmeii4/${mcode}/${case}/${sequence}/${mcode}-${case}-${sequence}-${var}-01-${year}${start_date_hour}.ens.bz2

end

end

