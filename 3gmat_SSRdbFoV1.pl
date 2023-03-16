#!/usr/bin/perl -w
########################################################################
## SSRdbFoV1.pl    script prepare DATA file for 1. Mapchartr 
##												2. B2Go
##												3. miRNA Association
##												4. TE association
##												5. nr db V.0.01
## 
## 
## 
##  Developed: MK Biswas 2010 [ mkbcit@gmail.com ]
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~###

open (Mdb,"<$ARGV[0]") || die ("\nError: Not found input file (*.slm) !\n\n");

my $filename = $ARGV[0];
$filename =~ s/\.slm//;

### code for file name  manipulation
my $fname = $filename;
chomp ($fname);
my @f_name_get = split (/\//, $fname);
my $fname1= $f_name_get[2];
my @x = split (/\./, $fname1);
#open (OUT2,">$x[0].sts");   ## Out put file for  EPCR 
my $y= $f_name_get[1];
my $existingdir = "./in_out/";

## open nr Database result Out put  file  and write data-------------------->
 open my $Datafile_nrdb, ">>", "$existingdir/$x[0].nrdbV001"   or die "Can't open '$existingdir/$x[0].sts'\n"; # nrDatabse V001
	printf $Datafile_nrdb "MarkerID\tF_primer_1_seq\tR_primer_1_seq\tSSR_motif_type\tSSR_Class(I _II)\tSSR_Rich_with\tLocustype\t";
	printf $Datafile_nrdb "SSR_info|[SSR_id_(Chr_ssr-sl)],[SSR_Sl],[On_the_Chr],[SSR_Type],[SSR_motif_length],[SSR_Start_Pos_on_chr],[SSR_End_Pos_on_chr],[SSR_start_Pos_on_flank_seq],[SSR_end_Pos_on_flank_seq],[SSR_motif]|\t";
	printf $Datafile_nrdb "200bp_SSRmotif_200bp\tPCR_product_1_Seq\t";
	printf $Datafile_nrdb "PrimerSet1|[MarkerID],[F_primer_1],[F_primer_1_tem],[F_primer_1_Length],[R_primer_1],[R_primer_1_tem],[R_primer_1_Length],[PCR_product_1_Size],[Fprimer1_bind_on_Flank],[Rprimer1_bind_on_Flank]|\t";
	printf $Datafile_nrdb "PrimerSet2|[F_primer_2_seq],[F_primer_2_tem],[F_primer_2_Length],[R_primer_2_seq],[R_primer_2_tem],[R_primer_2_Length],[PCR_product_2_Size],[Fprimer2_bind_on_Flank],[Rprimer2_bind_on_Flank],[PCR_product_2_Seq]|\t";
	printf $Datafile_nrdb "PrimerSet3|[F_primer_3_seq],[F_primer_3_tem],[F_primer_3_Length],[R_primer_3_seq],[R_primer_3_tem],[R_primer_3_Length],[PCR_product_3_Size],[Fprimer3_bind_on_Flank],[Rprimer3_bind_on_Flank],[PCR_product_3_Seq]|\t";
	printf $Datafile_nrdb "SelfEPCR|[Chr],[MarkerID],[Stand],[hitStart_marker],[HitEnd_marker],[ProductSize],[Missmatch],[Gap]|\n";


 open my $DatafileB2GO, ">>", "$existingdir/Data_B2GO_$x[0].fasta"    or die "Can't open '$existingdir/$x[0].sts'\n"; # data file for B2GO
 open my $DatafileMiRNAAsso, ">>", "$existingdir/Data_miRNA_Asso_$x[0].fasta" or die "Can't open '$existingdir/$x[0].sts'\n"; # data file for miRNA Association
 open my $DatafileSSRPos, ">>", "$existingdir/Data_SSPositionCalulate_$x[0].fasta"   or die "Can't open '$existingdir/$x[0].sts'\n"; # data file for SSr position calculation
 open my $DatafileMap, ">>", "$existingdir/Data_mapchart_$x[0].txt"   or die "Can't open '$existingdir/$x[0].sts'\n"; # data file for Mapchart 

 while (<Mdb>) {
	chomp; 
## 
###	Data Stracture      dbVbeta	------------------------------------------					
#	MarkerID   .....            [0]	CUnP2chrUn000001		                  F_primer_2_seq	    [27] CACGCAATCAAGAAGAGGCT
#	Locustype  .....            [1]	Sing_Loc=CUnP2chrUn000001=1		          F_primer_2_tem	    [28] 60.538
#	On_the_Chr .....            [2]	chrUn_random		                      F_primer_2_Length	    [29] 20
#	SSR_Sl	  .....             [3]	1		                                  R_primer_2_seq	    [30] CTTTTAGGCTCCCTCTGCCT
#	SSR_Type  .....             [4]	p2		                                  R_primer_2_tem	    [31] 59.976
#	SSR_motif_type	            [5]	(GA)6		                              R_primer_2_Length	    [32] 20
#	SSR_motif_length            [6]	12		                                  PCR_product_2_Size	[33] 109
#	SSR_Start_Pos_on_chr        [7]	930		                                  Fprimer2_bind_on_Flank[34] 129
#	SSR_End_Pos_on_chr	        [8]	941		                                  Rprimer2_bind_on_Flank[35] 237
#	SSR_id_(Chr_ssr-sl)      	[9]	chrUn000001				
#	200bp_SSRmotif_200bp        [10] CTGAAAACCTA.............GATCTCATTCAT	  F_primer_3_seq	    [36] AGGGGCTACAAAGATGCTCC
#	SSR_motif	                [11] GAGAGAGAGAGA		                      F_primer_3_tem	    [37] 60.599
#	SSR_start_Pos_on_flank_seq	[12] 200		                              F_primer_3_Length	    [38] 20
#	SSR_end_Pos_on_flank_seq	[13] 211		                              R_primer_3_seq	    [39] CTTTTAGGCTCCCTCTGCCT
#	SSR_Class(I _II)	        [14] Class II		                          R_primer_3_tem	    [40] 59.976
#	SSR_Rich_with	            [15] AT/GC Balance SSR		                  R_primer_3_Length	    [41] 20
#	MarkerID:	                [16] CUnP2chrUn000001				
#	PCR_product_1_Seq	        [17] ATAGTATA.........CTAAAAG		          PCR_product_3_Size	[42] 164
#	F_primer_1_seq	            [18] ATGCTCCTCAAATCGTTGCT		              Fprimer3_bind_on_Flank[43] 74
#	F_primer_1_tem	            [19] 59.843		                              Rprimer3_bind_on_Flank[44] 237
#	F_primer_1_Length	        [20] 20				
#	R_primer_1_seq	            [21] CTTTTAGGCTCCCTCTGCCT		              PCR_product_2_Seq	    [45] CACGCAATCAAGAAGAGGC-----------GAGAATAGGCAGAGGGAGCCTAAAAG
#	R_primer_1_tem	            [22] 59.976		                              PCR_product_3_Seq	    [46] AGGGGCTA-----------------------AGAATAGGCAGAGGGAGCCTAAAAG
#	R_primer_1_Length	        [23] 20		                                 
#	PCR_product_1_Size	        [24] 151				
#	Fprimer1_bind_on_Flank	    [25] 87				                          Self_EPCR|[Chr],[MarkerID],[Stand],[hitStart_marker],[HitEnd_marker],[ProductSize],[Missmatch],[Gap]|	[47]	 EPCR|chrUn_random,CUnP2chrUn000001,+,818,968,151/151-151,0,0|
#	Rprimer1_bind_on_Flank	    [26] 237				
###---------------------------							

	 @data = split(/\t/);

###   nr database V001 construct 
#-------------------------------------------------------------------------
	 my @d1= split ("=",$data[1]); #Locus information manupulation
	 my $Locd = $d1[0].$d1[2];
	 my $SSR_other_info ='SSR_info|'.$data[9].','.$data[3].','.$data[2].','.$data[4].','.$data[6].','.$data[7].','.$data[8].','.$data[12].','.$data[13].','.$data[11].'|';
	 printf $Datafile_nrdb "$data[0]\t$data[18]\t$data[21]\t$data[5]\t$data[14]\t$data[15]\t$Locd\t$SSR_other_info\t$data[10]\t$data[17]\t";

	 my	$PrmSet1_info =	'PrimSet1|'.$data[16].','.$data[18].','.$data[19].','.$data[20].','.$data[21].','.$data[22].','.$data[23].','.$data[24].','.$data[25].','.$data[26].'|';
    my	$PrmSet2_info =	'PrimSet2|'.$data[27].','.$data[28].','.$data[29].','.$data[30].','.$data[31].','.$data[32].','.$data[33].','.$data[34].','.$data[35].','.$data[45].'|';
    my	$PrmSet3_info =	'PrimSet3|'.$data[36].','.$data[37].','.$data[38].','.$data[39].','.$data[40].','.$data[41].','.$data[42].','.$data[43].','.$data[44].','.$data[46].'|';
	 printf $Datafile_nrdb "$PrmSet1_info\t$PrmSet2_info\t$PrmSet3_info\t";
	 printf $Datafile_nrdb "Self$data[47]\n";
#------------------------------------------------------------------------------------
#
	 printf $DatafileB2GO ">$data[0]\n$data[17]\n";       ## [  ok  ]
	 printf $DatafileMiRNAAsso ">$data[0]\n$data[17]\n";  ## [  ok  ]


###   Generate data for SSR Position Claculation on The Genome 
#-------------------------------------------------------------------------	
	my $flseq = $data[10],
	my $start = $data[12],
   my $end   = $data[13];

	my $cut_start = ($start - 10);
	my $cut_end = ($end - $start +20);
	my $SSR_bp = substr ($flseq, $cut_start, $cut_end);
   printf $DatafileSSRPos ">$data[0]\t $data[2]:$data[7]:$data[8]\n $SSR_bp\n";
##--------------End -----------------------------------------------------


### Map MARKE Based on Chromosome Location 
#----------------------------------------------------------
## Data Starcture 
#  EPCR|chrUn_random,CUnP2chrUn000001,+,818,968,151/151-151,0,0|
	my @epcr_data = split (",", $data[47]);
    my $Physical_loc =(($epcr_data[3])/1000000);
    my $ccode = $data[4];
      if ($ccode eq "c" or $ccode eq "c*") { $ccode = C0;   } 
	  else {$ccode =~ s/p/C/g;}
printf $DatafileMap "$data[2]\t$epcr_data[1]\t$Physical_loc\t$ccode\n"; 

	};






