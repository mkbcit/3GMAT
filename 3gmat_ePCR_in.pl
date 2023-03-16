#!/usr/bin/perl -w
## Author: MK Biswas   [ mkbcit@gmail.com ]
# Program name: Seq file formater for ePCR analysis input file 


open (SEQ,"<$ARGV[0]") || die ("\nError: FASTA file doesn't exist !\n\n");

### code for file name  manipulation
my $SQ_fname = $ARGV[0];
chomp ($SQ_fname);
my @SQf_name_get = split (/\//, $SQ_fname);
my $SQfn= $SQf_name_get[2];
my @x = split (/\./, $SQfn);
my $y= $SQf_name_get[1];
my $existingdir = "./$y/";
open my $fileHandle, ">>", "$existingdir/mygseq$x[0].fa" or die "Can't open '$existingdir/mygseq$x[0].fa'\n";


$/ = ">";
while (<SEQ>)
  {
  next unless (($id,$seq) = /(.*?)\n(.*)/s);
   $seq = uc $seq;
	printf $fileHandle ">$id\n$seq\n";
    } 








