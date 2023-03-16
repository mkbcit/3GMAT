#!/usr/bin/perl -w
# Author: Thomas Thiel
# Program name: primer3_in.pl
# Description: creates a PRIMER3 input file based on SSR search results

##  Modufyed by Dr. Manosh K Biswas  at 23 october 2013
##  Note: This script reduce the memory uses during the Genomic sequences analysis. 
##        This script only useful for chromosome wise genome sequences analysis.
##		   

open (IN,"<$ARGV[0]") || die ("\nError: Couldn't open misa.pl results file (*.misa) !\n\n");

my $filename = $ARGV[0];
$filename =~ s/\.misa//;
open (SRC,"<$filename") || die ("\nError: Couldn't open source file containing original FASTA sequences !\n\n");
open (OUT,">$filename.p3in");

undef $/;
$in = <IN>;
study $in;

$/= ">";

my $count;
while (<SRC>)
  {
  next unless (my ($id,$seq) = /(.*?)\n(.*)/s);
  $seq =~ s/[\d\s>]//g;#remove digits, spaces, line breaks,...

  while ($in =~ /$id\t(\d+)\t\S+\t\S+\t(\d+)\t(\d+)/g)
    {
    my ($ssr_nr,$size,$start) = ($1,$2,$3);
    $count++;
    
###   manosh modify to get flanking primer sequences 	
	
	if ($start < 200 ) {
		$cut_start = 0;
		$target = $start-3;
	}
	else 
		{$cut_start = $start - 200;
			$target = 196
			} ;
	
	$cut_end = $size+400;
#print "$cut_start     $cut_end        ";
	$flseq = substr ($seq, $cut_start, $cut_end);
#print "$flseq";

#	print "ssr_nr, Size, start = $ssr_nr,    $size,   $start, TARGET=",$target,",",$size+6,"\n";
	#print "ID: $id \n";

    print OUT "PRIMER_SEQUENCE_ID=$id"."_$ssr_nr\nSEQUENCE=$flseq\n";
    print OUT "PRIMER_PRODUCT_SIZE_RANGE=100-280\n";
    print OUT "TARGET=",$target,",",$size+6,"\n";
    print OUT "PRIMER_MAX_END_STABILITY=250\n=\n"
    };
  };
print "$count records created";