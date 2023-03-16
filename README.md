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


## Implimented in research projects
3GMAT pipeline used in many research project to develop and characterize the Micro-satellite markers. Some of them are listed here: 
- Nuraga GW, Feyissa T, Tesfaye K, Biswas MK, Schwarzacher T, Borrell JS, Wilkin P, Demissew S, Tadele Z, Heslop-Harrison J: The Genetic Diversity of Enset (Ensete ventricosum) Landraces Used in Traditional Medicine Is Similar to the Diversity Found in Non-medicinal Landraces. Frontiers in Plant Science:3166.
- Wang Z, Rouard M, Biswas MK, Droc G, Cui D, Roux N, Baurens FC, Ge XJ, Schwarzacher T, Heslop-Harrison J: A chromosome-level reference genome of Ensete glaucum gives insight into diversity, chromosomal and repetitive sequence evolution in the Musaceae. GigaScience, Volume 11, 2022, giac027,
- Biswas MK, Biswas D, Bagchi M, Yi G, Deng G: A Comprehensive Plant microRNA Simple Sequence Repeat Marker Database to Accelerate Genetic Improvements in Crops. Agronomy 2021, 11(11):2298.
- Biswas MK, Darbar JN, Borrell JS, Bagchi M, Biswas D, Nuraga GW, Demissew S, Wilkin P, Schwarzacher T, Heslop-Harrison J: The landscape of microsatellites in the enset (Ensete ventricosum) genome and web-based marker resource development. Scientific Reports 2020, 10(1):1-11.
- Biswas MK, Bagchi M, Nath UK, Biswas D, Natarajan S, Jesse DMI, Park J-I, Nou I-S: Transcriptome wide SSR discovery cross-taxa transferability and development of marker database for studying genetic diversity population structure of Lilium species. Scientific reports 2020, 10(1):1-13.
- Biswas MK, Bagchi M, Biswas D, Harikrishna JA, Liu Y, Li C, Sheng O, Mayer C, Yi G, Deng G: Genome-Wide Novel Genic Microsatellite Marker Resource Development and Validation for Genetic Diversity and Population Structure Analysis of Banana. Genes 2020, 11.
- Biswas MK, Nath UK, Howlader J, Bagchi M, Natarajan S, Kayum A, Kim HT, Park JI, Kang JG, Nou IS: Exploration and Exploitation of Novel SSR Markers for Candidate Transcription Factor Genes in Lilium Species. Genes 2018 9(2):97.
- Biswas MK, Liu Y, Li C, Sheng O, Mayer C, Yi G: Genome-Wide Computational Analysis of Musa Microsatellites: Classification Cross-Taxon Transferability Functional Annotation Association with Transposons & miRNAs and Genetic Marker Potential. PLoS ONE 2015 10(6).
- Chai L*, Biswas MK*, Yi H, Guo W, Deng XX: Transferability polymorphism and effectiveness for genetic mapping of the Pummelo (Citrus grandis Osbeck) EST-SSR markers. Sci Hortic-Amsterdam 2013 155(0):85-91.
- Biswas MK, Chai L, Mayer C, Xu Q, Guo W, Deng XX: Exploiting BAC-end sequences for the mining characterization and ut,ility of new short sequences repeat (SSR) markers in Citrus. Molecular Biology Reports 2012:1-14.
