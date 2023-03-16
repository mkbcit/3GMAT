# 3GMAT [3rd Generations Micro-satellite Analysis Tool]
![image](https://user-images.githubusercontent.com/61458681/225617185-b9837901-9a78-44f9-a366-3a52c1ca1ac6.png)

3GMAT is a SSR-marker(micro-satellite) development, characterization and marker database creation pipeline. This pipeline written in Perl and friendly  for windows environment. 
The computational pipeline comprises several tools, including MISA for identifying SSRs, Primer3 for designing PCR primers,  3gmat_dup_mark_finder.pl  for  remove duplicate SSR primers, e-PCR for estimate the transferability of SSR-marker to the relatives species. 

#  Usage
1. Go to the 3GMAT folder 
2. copy input genome data as fasta file format in to the in_out dir
3.  run 3GMATv1.pl  then  type the input file name while  asking   
Results from different steps of analysis are store in separate file with different extension. All file able to open in notepad, docx, xlsx etc. 

#   Output files
All the outputs are store in folder called in_out.  The list and descriptions of output file  are presented in   table as follows: 
 
| File                          | Description                                                        |
|:---                           |:---                                                                |
| Test.fasta                    | Genome seq file FASTA format                                       |
| Test.fasta.misa               | MISA output contains SSR analysis data                             |
| Test.fasta_SSR_stat.xls       | Statistics of SSR analysis obtained from MISA output               |
| Test.fasta.p3in               | Data generated for Primer3 tools                                   |
| Test.fasta.p3out              | Output file from Primer3, contains SSR-primer and its attribute    |
| Test.fasta.results            | SSR analysis and primer design all attribute recorded in this file |
|Test.fasta.inDMF	              | Duplicate marker search input data file                            |
|Test.fasta.DMF.Stat	           | Duplicate marker search result                                     |
|Test.fasta.ePCRout	            | e-PCR result                                                       |
|Test.fasta.slm	                | Multilocus Primer list                                             |
|Test.fasta.Sloc               	| Single locus Primer list                                           |
