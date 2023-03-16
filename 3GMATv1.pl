#!/usr/bin/perl
#---------------------------------------------------------------------------------------#
## 3GMAT.pl    is  a script for SSR analysis and primer design
## Author: MK Biswas  [ mkbcit@gmail.com ]
## 2010 March  
#---------------------------------------------------------------------------------------#
print "==========================================================================================================\n";
print "               This script use for SSR primer design from genomic sequences \n";
print "               Author: MK Biswas     mkbcit(at)gmail.com \n";
print "               3GMAT.pl       Version  0.1    March 2010  HZAU, PR China \n";
print "==========================================================================================================\n";

use strict;
## analysis datae and time; 
use Time::Localtime;


my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =localtime(time);
$year = $year + 1900;
$mon = $mon+1;
print "Analysis Start on  ";
print sprintf("%02d", $mday).'/'.sprintf("%02d", $mon).'/'.sprintf("%04d", $year).' at '.sprintf("%02d", $hour).':'.sprintf("%02d", $min).':'.sprintf("%02d", $sec);
##-------------------------end

 print "\nGive seq file name [genome seq fasta fromate]::>\t";

 my $fname = <STDIN>;

# my $fname =  $endata;
print  "Your Seq Data file is :\t $fname\n";
  print "Step:1 < SSR Search Began >  ";
 			my $start_run_MISA = time();
	  system ("3gmat_MISA.pl ./in_out/$fname"); 
			my $end_run_MISA = time();
			my $run_time_MISA = $end_run_MISA - $start_run_MISA;
			my $MISA_min = ($run_time_MISA/60);
			print " Search took ".sprintf("%.2f", $MISA_min)." Min\n";

 print "\nStep:2 <a> <Record creating for primer>  ";
    		chomp ($fname);
			my $start_run_P3in = time();
		system ("3gmat_p3_in.pl ./in_out/$fname.misa");
			my $end_run_P3in = time();
			my $run_time_P3in = $end_run_P3in - $start_run_P3in;
			my $P3in_min = ($run_time_P3in/60);
			print ", Search took ".sprintf("%.2f", $P3in_min)." Min\n";

 print "Step:2 <b> <SSR Primer Search   Began > ";
			my $start_run_P3cor = time();
		system ("primer3_core.exe <./in_out/$fname.p3in> ./in_out/$fname.p3out"); 
			my $end_run_P3cor = time();
			my $run_time_P3cor = $end_run_P3cor - $start_run_P3cor;
			my $P3cor_min = ($run_time_P3cor/60);
			print "\t\t\tSearch took ".sprintf("%.2f", $P3cor_min)." Min\n";

 print "Step:2 <c> <SSR Primer Modeling Began > ";
			my $start_run_P3out = time();
	  system ("3gmat_p3_out.pl ./in_out/$fname.p3out ./in_out/$fname.misa"); 
			my $end_run_P3out = time();
			my $run_time_P3out = $end_run_P3out - $start_run_P3out;
			my $P3out_min = ($run_time_P3out/60);
			print ", Search took ".sprintf("%.2f", $P3out_min)." Min\n";

 print "\nStep:3 < Removing duplicate SSR primer > ";
			my $start_run_dup = time();

	  system ("3gmat_dup_mark_finder.pl ./in_out/$fname.inDMF"); 


			my $end_run_dup = time();
			my $run_time_dup = $end_run_dup - $start_run_dup;
			my $dup_min = ($run_time_dup/60);
			print ", Search took ".sprintf("%.2f", $dup_min)." Min\n\n";

  print "Step:4 < Single Locus Marker Finding >  ";
 			my $start_run_ePCR = time();
  	system ("3gmat_ePCR_in.pl ./in_out/$fname"); ## Genome seq file prepare for epcr
 	## e-PCR input file name process
 			my @x = split (/\./, $fname);
 			my $gsq_fn = "mygseq$x[0].fa";
 			my $sts_dbfn = "$x[0].sts";
 			print "\n\tSYS SMS:: "; 
 	system ("e-PCR.exe -w9 -f 1 -m100 ./in_out/$sts_dbfn D=100-400 ./in_out/$gsq_fn N=1 G=1 T=3 >./in_out/$fname.ePCRout");
 	system ("3gmat_SiLocMar.pl ./in_out/$fname.ePCRout");
 
 			my $end_run_ePCR = time();
 			my $run_time_ePCR = $end_run_ePCR - $start_run_ePCR;
 			my $ePCR_min = ($run_time_ePCR/60);
 			print " Search took ".sprintf("%.2f", $ePCR_min)." Min\n\n";
			
			
# #####  Step 5 to be use for SSR marker database creation  
#  print "Step:5 < Marker Database Construction > $fname\n ";
# 	system ("3gmat_ePCRresultOrganizer.pl ./in_out/$fname.ePCRout");
# 			my $dbfn = "$x[0].dbVbeta";
# 			my $slmFile="$x[0].slm";
# 	system ("3gmat_nrMarkdb.pl ./in_out/$fname.ePCRout.Organized ./in_out/$fname.slm >./in_out/$dbfn");
# 	system ("3gmat_SSRdbFoV1.pl ./in_out/$dbfn");
 

 

print "==========================================================================================================\n";
my($sec_e,$min_e,$hour_e,$mday_e,$mon_e,$year_e,$wday_e,$yday_e,$isdst_e) =localtime(time);
$year_e = $year_e + 1900;
$mon_e = $mon_e+1;
print "\tGenome wide SSR marker modeling Successfully Complite on  ";
print sprintf("%02d", $mday_e).'/'.sprintf("%02d", $mon_e).'/'.sprintf("%04d", $year_e).' at '.sprintf("%02d", $hour_e).':'.sprintf("%02d", $min_e).':'.sprintf("%02d", $sec_e);
print "\n==========================================================================================================\n";


exit;


