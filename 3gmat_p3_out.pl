#!/usr/bin/perl -w
# Author: Thomas Thiel
# Program name: prim_output.pl
# Description: converts the Primer3 output into an table
# Note: Modifyed by Manosh 2011 April 27 for get more analysis information

open (SRC,"<$ARGV[0]") || die ("\nError: Couldn't open Primer3 results file (*.p3out) !\n\n");
my $filename = $ARGV[0];
$filename =~ s/\.p3out//;
open (IN,"<$ARGV[1]") || die ("\nError: Couldn't open source file containing MISA (*.misa) results !\n\n");

open (OUT,">$filename.results") || die ("nError: Couldn't create file !\n\n");
open (OUT1,">$filename.inDMF") || die ("nError: Couldn't create file !\n\n"); # file for non redudent primer data 
#open (OUT2,">$filename.B2G.fasta") || die ("nError: Couldn't create file !\n\n"); # file for Blast2Go data 

my ($seq_names_failed,$count,$countfailed);


#ID	SSR nr.	SSR type	SSR	size	OnChr_start	OnChr_end	SSR_with400bp_flSeq 	SSR_seq_whole	SSR_on_New_start	SSR_on_New_end
#print OUT "Seq_ID\tSSR nr.\tSSR type\tSSR\tsize\tOnChr_start\tOnChr_end\tSSR_Sl_no\tSSR_with400bp_flSeq\tSSR_seq_whole\tSSR_on_New_start\tSSR_on_New_end\tSSR_class\t"; # added \tSSR_class {Mamosh}
#print OUT "SSR_rich_with\tSSR_Marker_ID\tInsilico_PCR_product_1\t"; 
#print OUT "FORWARD PRIMER1 (5'-3')\tTm(°C)\tsize\tREVERSE PRIMER1 (5'-3')\tTm(°C)\tsize\tPRODUCT1 size (bp)\tstart (bp)\tend (bp)\t";
#print OUT "FORWARD PRIMER2 (5'-3')\tTm(°C)\tsize\tREVERSE PRIMER2 (5'-3')\tTm(°C)\tsize\tPRODUCT2 size (bp)\tstart (bp)\tend (bp)\t";
#print OUT "FORWARD PRIMER3 (5'-3')\tTm(°C)\tsize\tREVERSE PRIMER3 (5'-3')\tTm(°C)\tsize\tPRODUCT3 size (bp)\tstart (bp)\tend (bp)\tInsilico_PCR_product_2\tInsilico_PCR_product_3\n";

undef $/;
my $in = <IN>;
study $in;

$/ = "=\n";

while (<SRC>)
  {
  my ($id,$ssr_nr) = (/PRIMER_SEQUENCE_ID=(\S+)_(\d+)/);
  
  $in =~ /($id\t$ssr_nr\t.*)\n/;
  my $misa = $1;
  
  /PRIMER_LEFT_SEQUENCE=(.*)/ || do {$count_failed++;print OUT "$misa\n"; next};
  my $info = "$1\t";
  
  /PRIMER_LEFT_TM=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT=\d+,(\d+)/; $info .= "$1\t";
  
  /PRIMER_RIGHT_SEQUENCE=(.*)/;  $info .= "$1\t";
  /PRIMER_RIGHT_TM=(.*)/; $info .= "$1\t";
  /PRIMER_RIGHT=\d+,(\d+)/; $info .= "$1\t";
  
  /PRIMER_PRODUCT_SIZE=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT=(\d+),\d+/; $info .= "$1\t";
  /PRIMER_RIGHT=(\d+),\d+/; $info .= "$1\t";
  
  
  /PRIMER_LEFT_1_SEQUENCE=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_1_TM=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_1=\d+,(\d+)/; $info .= "$1\t";
    
  /PRIMER_RIGHT_1_SEQUENCE=(.*)/;  $info .= "$1\t";
  /PRIMER_RIGHT_1_TM=(.*)/; $info .= "$1\t";
  /PRIMER_RIGHT_1=\d+,(\d+)/; $info .= "$1\t";
  
  /PRIMER_PRODUCT_SIZE_1=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_1=(\d+),\d+/; $info .= "$1\t";
  /PRIMER_RIGHT_1=(\d+),\d+/; $info .= "$1\t";
  
  
  /PRIMER_LEFT_2_SEQUENCE=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_2_TM=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_2=\d+,(\d+)/; $info .= "$1\t";
    
  /PRIMER_RIGHT_2_SEQUENCE=(.*)/;  $info .= "$1\t";
  /PRIMER_RIGHT_2_TM=(.*)/; $info .= "$1\t";
  /PRIMER_RIGHT_2=\d+,(\d+)/; $info .= "$1\t";
  
  /PRIMER_PRODUCT_SIZE_2=(.*)/; $info .= "$1\t";
  /PRIMER_LEFT_2=(\d+),\d+/; $info .= "$1\t";
  /PRIMER_RIGHT_2=(\d+),\d+/; $info .= "$1";
  
  $count++;

##  modify by Manosh 2013 October 25  for get insilico PCR product sequences 
##                                                0                   1       2                3              4      5             6               7          8               9              10      11            12                 13     14          15                16         17             18              19      20               21              22     23            24               25        26  
##                                          --------------          -----   ----   ----------------------   ----   -----   ------------------  ----------  -------  ---------------------   -----   ----    --------------------    -----   ----    -----------------   ---------   ------  ----------------------  -----   ---     ----------------------  -----   ---     -----------------   --------    -------
##      $info variable er data  stracture [FORWARD_PRIMER1_(5'-3')	Tm(°C)	size	REVERSE_PRIMER1_(5'-3')	Tm(°C)	size	PRODUCT1_size(bp)	start(bp)	end(bp)	FORWARD_PRIMER2_(5'-3')	Tm(°C)	size	REVERSE_PRIMER2_(5'-3')	Tm(°C)	size	PRODUCT2_size_(bp)	start_(bp)	end(bp)	FORWARD_PRIMER3_(5'-3')	Tm(°C)	size	REVERSE_PRIMER3_(5'-3')	Tm(°C)	size	PRODUCT3_size(bp)	start (bp)	end (bp)

	###     @1 ::   Extarct PCR product sequences. Code start here ----->
	@temp = split(/\t/, $info);

	$insilico_pcr_product1_start = $temp[7];  
    $insilico_pcr_product1_end =   $temp[6];

#	$insilico_pcr_product2_start = $temp[16];
#   $insilico_pcr_product2_end =   $temp[15];

#	$insilico_pcr_product3_start = $temp[25];
#    $insilico_pcr_product3_end =   $temp[24];

	@dataMISA = split(/\t/, $misa);

    $cutflseq = $dataMISA[8]; 

	$product1_seq = substr ($cutflseq, $insilico_pcr_product1_start, $insilico_pcr_product1_end);
#	$product2_seq = substr ($cutflseq, $insilico_pcr_product2_start, $insilico_pcr_product2_end);
#	$product3_seq = substr ($cutflseq, $insilico_pcr_product3_start, $insilico_pcr_product3_end);

	
	###     @2 ::   Formate and generate SSR primer universal ID and name etc. Code start here ----->
    ###  Data stracture MISA file :: [0]ID	[1]SSR nr.	[2]SSR type	[3]SSR	[4]size	[5]OnChr_start	[6]OnChr_end [7]SSR_Sl_no	[8]SSR_with400bp_flSeq 	[9]SSR_seq_whole	[10]SSR_on_New_start	[10]SSR_on_New_end
	###  SSR Marker ID: 
	###			Part1:	M01       =  M01 represent chromosome 01 and
	###			Part2:  P2        =  P2 represent SSR repeat type 
	###			Part3: AA0000001  =  AA is genome type; 0000001 is 7 digit code represent SSR locus id 
    ###			 
 		
	# 	$part1 = uc $dataMISA[0]; 
	#		while($part1 =~ /CHR/ig){ 
	#			  $position = pos($part1);
 	#				}
    #    $ssr_M_id_part1 = substr($part1, $position, 2);
	#
	#	if ($ssr_M_id_part1 ne 'UN') {
	#		$ssr_markerID_part1 = sprintf("%02d", $ssr_M_id_part1);
 	#								}
	#	else {$ssr_markerID_part1= "Un";}
	#
	#	$ssr_markerID_part2 = uc $dataMISA[2]; 
	#	if ($ssr_markerID_part2 eq C or $ssr_markerID_part2 eq "C*") { $ssr_markerID_part2 = "C0"; }
	#	$ssr_markerID_part3 = $dataMISA[7]; 
	# $SSR_Marker_ID = ($ssr_markerID_part1.$ssr_markerID_part2 .$ssr_markerID_part3); 
	
		$SSR_Marker_ID = $dataMISA[7]; 
		
   # print OUT "$misa\t".$SSR_Marker_ID."\t $product1_seq\t$info\t$product2_seq\t$product3_seq\n";
   
   print OUT "$misa\t$product1_seq\t$info\n";
	

	###   @3 ::  create input data file for non redudent SSR marker find 
	     print OUT1 "$SSR_Marker_ID \t $temp[0] \t$temp[3] \t$temp[6]\n";
      
	###   @4 ::  create data file for Blast2GO analysis of SSR marker for Functional annotation 
	#     print OUT2 ">$SSR_Marker_ID\n $product1_seq\n";

  };
print OUT "\nPrimer modelling was successful for $count sequences.\n"; # edited by manosh | before edit> print "\nPrimer modelling was successful for $count sequences.\n";
print OUT "Primer modelling failed for $count_failed sequences.\n";    # edited by manosh | before edit> print "Primer modelling failed for $count_failed sequences.\n";

print "$count Primer Design"; # edited by manosh | before edit> print "\nPrimer modelling was successful for $count sequences.\n";
