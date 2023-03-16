#!/usr/bin/perl -w
######################################################################################################
## dup_mark_finder.pl    script identify duplicate  SSR marker from the *.inDMF file 
## Author: MK Biswas   [ mkbcit@gmail.com ]
## Developed  31 October 2018 [update]
## Syntax :
##       dup_mark_finder.pl   XXXXXX.inDMF
##											   
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

open (IN,"<$ARGV[0]") || die ("\nError: Not found input file (*.results) !\n\n");

my $filename = $ARGV[0];
$filename =~ s/\.inDMF//;
open (OUT,">$filename.DMF.Stat");   ## Out put file for list of match F and R primer marker 


### code for file name  manipulation
my $fname = $filename;
chomp ($fname);
my @f_name_get = split (/\//, $fname);
my $fname1= $f_name_get[2];
my @x = split (/\./, $fname1);
#open (OUT2,">$x[0].sts");   ## Out put file for  EPCR 
my $y= $f_name_get[1];
my $existingdir = "./$y/";
open my $fileHandle, ">>", "$existingdir/$x[0].sts" or die "Can't open '$existingdir/$x[0].sts'\n";


my %F_primer = ();   
my %R_primer = ();  


 while (<IN>) {
	chomp; 

## data stracture ::|| [0]ID_primer	[1]F_primer	[2]R_primer	[3]PCR product size	 
	 @ data = split(/\t/);
				$ID_SSR_marker=	$data[0],
				$F_primer     =	$data[1],
				$R_primer	  =	$data[2],
			    $PCR_product  =	$data[3],

				$F_primer    =~ s/\s//g; # romove blank space from primer seq
				$R_primer	  =~s/\s//g; # romove blank space from primer seq

			$F_primer{$ID_SSR_marker}=$F_primer;
			$R_primer{$ID_SSR_marker}=$R_primer;

			$data1 = $ID_SSR_marker.",".$F_primer.",".$R_primer.",".$PCR_product;
			push @data_a1_info, $data1;
	};

## duplicace find among  FROWARD primer sets and retrive unique Froward primer ID
		my %counts_F = ();
		my @counts_F = ();
		my %unique_F = ();
		foreach my $key (sort keys %F_primer) {
			my $value = $F_primer{$key}; 
			if (not exists $counts_F{$value}) {
				$unique_F{$key} = $value;
			}
			$counts_F{$value}++;
		};
		my @unique_keys_F = sort keys %unique_F; 
		foreach my $key (@unique_keys_F) {
			push @counts_F, $counts_F{ $unique_F{$key} }
		};
		print OUT "\n ===================================\n \tUnique key for F primer\n ====================================\n";
		foreach  $u_el_key_F (@unique_keys_F) {$c++, print OUT "Unique F primer: $c \t $u_el_key_F\n"; }


## duplicace find among  REVERSE primer sets and retrive unique Reverse primer ID
		my %counts_R = ();
		my @counts_R = ();
		my %unique_R = ();
		foreach my $key (sort keys %R_primer) {
			my $value = $R_primer{$key}; 
			if (not exists $counts_R{$value}) {
				$unique_R{$key} = $value;
			}
			$counts_R{$value}++;
		};
		my @unique_keys_R = sort keys %unique_R; 
		foreach my $key (@unique_keys_R) {
			push @counts_R, $counts_R{ $unique_R{$key} }
		};
		print OUT "\n ===================================\n \tUnique key for R primer\n ====================================\n";
		foreach  $u_el_key_R (@unique_keys_R) {$cr++, print OUT "Unique R primer: $cr \t $u_el_key_R\n"; }

## join unique F and R primer ID in to an arry  for get unique F_R primer id
		print OUT "\n ===================================\n \tUnique key List F+R primer\n ====================================\n";
		my @uF_uR_id = (@unique_keys_F, @unique_keys_R);
		foreach  $u_el_key_FR(@uF_uR_id) {$cun++, print OUT "$cun \t $u_el_key_FR\n"; }

		my %counts_nr_FR_id = ();
		for (@uF_uR_id) {
		   $counts_nr_FR_id{$_}++;
				}
		foreach my $keys (keys %counts_nr_FR_id) {
					#print OUT "$keys\t$counts_nr_FR_id{$keys}\n";
					push @list_uniq_FR, $keys; # this array story the  primer id that are redudent in the database with Reverse primer
							}
		print OUT "\n ===================================\n \tUnique key for R and F primer\n ==================================\n";
		foreach  $list_uFR(@list_uniq_FR) {$n++, print OUT "unF+R: $n \t $list_uFR\n"; }


## F primer set compare with R primer set and find match primer sets 
##--------------------------------------------------------------------------------------------------------------
		while ( ($k1, $v1) = each %F_primer) { 
				while ( ($k2, $v2) = each %R_primer) { 
						 if ($v1 eq $v2) { 
							push @red_R_Prim_id, $k2;
							push @F_prim_id, $k1;
								  }
				   } # End of first while......			 
		} # End of second while......	

## step1.  Retrive redudent primer's ID for remove primer from data base
		print OUT "\n ===================================\n \tId list redudent F with R primer\n ==================================\n";
		my @array_K2_id = sort {$a cmp $b} @red_R_Prim_id;
		my %counts_nr_K2 = ();
		for (@array_K2_id) {
		   $counts_nr_K2{$_}++;
				}
		foreach my $keys (keys %counts_nr_K2) {
					$mac++;
					print OUT "id with red no:$mac $keys\t$counts_nr_K2{$keys}\n";
					push @pri_list_for_delet, $keys; # this array story the  primer id that are redudent in the database with Reverse primer
							}

# close IN;

#print "array value all data: @data_a1_info\n";
#print "array value ID: @SSR_marker_id\n";
#print "array value list for delete: @pri_list_for_delet\n";


## Prepare Non redudent marker lists 
		my @array1 = sort {$a cmp $b} @list_uniq_FR;
		my @array2 = sort {$a cmp $b} @pri_list_for_delet;
		my %array2_elements;
		@array2_elements{ @array2 } = ();
		my @array3 = grep ! exists $array2_elements{$_}, @array1;
		#print "array3 List nr Marker: @array3\n"; 
		print OUT "\n =====================================================================\nLists of nr SSR Primer id {F Primer not common with R primer seq}\n =====================================================================\n";
		foreach  $element_ar3 (@array3) {$cu++, print OUT "$cu \t $element_ar3\n"; }
		

## retrive non redudent SSR marker 
foreach $data_all (@data_a1_info) {
		my ($SSR_id, $SSR_F, $SSR_R, $PCR_pro) = split (/,/, $data_all);
		
				foreach $nr_marker_id (@array3) {
					if ($nr_marker_id eq $SSR_id) { 
						printf $fileHandle "$SSR_id\t$SSR_F\t$SSR_R\t$PCR_pro\n";
						$nr_primer_set++;
						#print "Non redudent primer:: $nr_marker_id = $SSR_id :$SSR_F : $SSR_R: $PCR_pro\n";	
					    }
		 }
	    }
##------->
 @F_prim_id = sort @F_prim_id; # use for 
 print "$nr_primer_set non Duplicate Primer Found";
