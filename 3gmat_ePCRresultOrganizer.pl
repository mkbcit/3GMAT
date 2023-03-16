#!/usr/bin/perl -w
################################################################################################
## ePCRresultOrganizer.pl    script prepare ePCR result in organized form
## Author: MK Biswas   [ mkbcit@gmail.com ]                  
## Developed:  2 December 2013
##
## Syntax :
##   ePCRresultOrganizer.pl    abcdef.ePCRout [Note: this is out put file from e-PCR]
##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

open (IN,"<$ARGV[0]") || die ("\nError: Not found input file (*.ePCRout) !\n\n");

my $filename = $ARGV[0];
#$filename =~ s/\.ePCRout//;
open (OUT2,">$filename.Organized");   ## Out put file for Organized EPCR result

my %EPCRdata;         # this hashes store epcr dada and organized 

##===================================
#  Core for EPCR Result manipulation
##===================================
 while (<IN>) {
	chomp; 
## data stracture ::|| [0]AA_chr1	[1]C01P2AA0000003	[2]+	[3]10883	[4]11047	[5]165/165-165	[6]0	[7]0	
	 @data = split(/\t/);
	   my $data_epcr = join(",",@data);
	   #data for organized EPCR result
	   push @{ $EPCRdata{"$data[1]"} }, [ $data_epcr."|" ]; #data store for organized EPCR result
	};

## organized EPCR result and generated  [ *.Organized_ePCRout] result file 
for my $key (sort keys %EPCRdata) {
	my $val = $EPCRdata{$key};
	my $x = scalar(@$val);
	print OUT2 join('', $key."\t".'EPCR:'.$x."|\t",(map $_->[0], @$val)), "\n";
}


