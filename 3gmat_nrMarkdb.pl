#!/usr/bin/perl -w
########################################################################
## nrMarkdb.pl    script prepare Marker Data Base  
## Author: MK Biswas   [ mkbcit@gmail.com ]
## Date: 5 December 2013 [update]
## Syntax :
##  nrMarkdb.pl    abcdef.ePCRout.Organized	  abcdef.slm   > out.dbVbeta
##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###
open (IN,"<$ARGV[0]") || die ("\nError: Not found input file (*.ePCRout) !\n\n");

 while (<IN>) {
	chomp; 
## data stracture ::|| 	[1]C01P2AA0000013	[2]	EPCR|chrUn_random,CUnC0chrUn000013,+,47167,47365,199/199-199,0,0|

	 @data = split(/\t/);
			$data1 = join("\t",@data);
			push @data_epcr, $data1;
	};

open (MDB,"<$ARGV[1]") || die ("\nError: Not found input file (*.slm) !\n\n");
 while (<MDB>) {
	chomp; 
	 @mdbs = split(/\t/);
			$data2 = join("\t",@mdbs);
			push @data_a1l_info, $data2;
	};
#=========================================
###  Retrive common id information
#=========================================
	foreach $data_all (@data_a1l_info) {
			my @ifo_data = split (/\t/, $data_all);
			my	$SSR_id = $ifo_data[0];
			    $SSR_id =~ s/\s//g; # romove blank space from id
				#print "$SSR_id\n";
			next unless defined $SSR_id; ## remove error SMS during run time 
			my $ifo_data_1 = join ("\t", @ifo_data);

				foreach $epcr_info (@data_epcr) {
					my @epcr_data = split (/\t/, $epcr_info);
					my $epcr_id = $epcr_data[0];
					next unless defined $epcr_id; ## remove error SMS during run time 
			           $epcr_id =~ s/\s//g; # romove blank space from id
						if ($epcr_id eq $SSR_id) { 
							print  "$ifo_data_1\t $epcr_data[1]\n";
							}
			 }
			}
##------->

