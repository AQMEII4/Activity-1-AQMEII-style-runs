use strict;
use Data::Dumper;
use File::Path;
use Parallel::ForkManager;

#
# note: this script requires the perl module Parallel::ForkManager to be available in your perl installation
#

my $user = 'my_ensemble_user_name';
my $password = 'my_ensemble_password';

#Maximum number of cuncurrent downloads;
my $max_parallel_runs = 4;

#my $basedir = '.';
my $basedir = '/work/MOD3EVAL/css/AQMEII4/work/data/ENSEMBLE_DOWNLOADS/';
my @models = qw(10700);
my %data = (
    '0241' => [qw(001 002 005 012 022 032 042 052 062 072 082 092 102 112 122 132 142 152 162 172 182 192 202 212 222 232 242 252 262 272 282 292 302 312 322 332 342 352 362 372 382 392 402 412 422 432 442 452 462 472)],#[qw(001 002 005 012 022 032 042 052 062 072 082 092 102 112 122 132 142 152 162 172 182 192 202 212 222 232 242 252 262 272 282 292 302 312 322 332 342 352 362 372 382 392 402 412 422 432 442 452 462 472)]
);
my @releases = qw(01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99);# 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99);

my %years = (
    '0241' => 2010,
    '0251' => 2016,
);
my %datestart = (
    '10700' => '01010100',
    '10701' => '01010100',
    '10703' => '01010000',
    '10704' => '01010000',
    '10705' => '01010000',
);

my @commands;
foreach my $model (@models) {
    die Dumper %datestart,$model unless (exists($datestart{$model}));
    my $dt = $datestart{$model};
    foreach my $sequence (keys %data) {
        my $year = $years{$sequence};
        foreach my $case (@{$data{$sequence}}) {
            my $dir = "$basedir/$model/$sequence/$case";
            mkpath($dir) unless (-e $dir);
            foreach my $release (@releases) {
                my $file = "https://ensemble.jrc.ec.europa.eu/ensemble/pvt/aqmeii4/$model/$sequence/$case/$model-$sequence-$case-$release-01-$year$dt.ens.bz2";
# if password is specified in .netrc file in home directory
#                my $cmd = "wget --user=$user -P $dir $file";
                my $cmd = "wget --user=$user --password=$password -P $dir $file";
                push @commands,$cmd;
            }
        }
    }
}

my $pm = Parallel::ForkManager->new($max_parallel_runs);
foreach my $cmd (@commands) {

    my $pid = $pm->start and next; # do the fork

    print "Now running $cmd\n";

    my @command = ($cmd);
    if( system(@command) != 0 ) {
        die "Command system \"".$cmd."\" failed: ".$!;
    }
    $pm->finish;  # do the exit in the child process
}
