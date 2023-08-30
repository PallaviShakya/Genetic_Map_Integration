# Genetic_Map_Integration

We currently have two genetic maps of VW9 made from two different crosses: VW8 X VW9 and VW9 X LM. We integrated both these maps in the new _M. hapla_ genome. 

Steps for integration: 

1. The genetic maps were organized into linkage groups. These linkage groups and the marker associated with them were organized in multiple excel files, i.e. each linkage group had a different excel file.  

|Contig|	Start|	Stop|	Distance|	LG|	Source|	Type|
|------|---------|------|-----------|-----|-------|-----|
|MhA1_Contig1109|	7250|	7250|	0|	1a|	D|	SNP|
|MhA1_Contig402|	9673|	9673|	0|	1a|	D|	SNP|

A customized R script was made that reads the excel file, modifies it and makes a bed file associated with it. These bed files include reads spanning 500 nucleotides (250 upstream and 250 downstream around the marker). This creates enough sequences to identify blast hits in the new genome. The customized R script can be found in ```library_contigs.R```

2. _bedtools getfasta_ was used to get the 500 nucleotide sequences corresponsing to the marker information from the M. hapla genome published in 2008. 

```
for bed_file in ~/Markers/*.bed; 
    do  filename=$(basename "$bed_file" .bed); 
    bedtools getfasta -fi ~/meloidogyne_hapla.PRJNA29083.WBPS16.genomic.fa -bed "$bed_file" > $filename.fasta; 
done
```
3. These fasta sequences were blasted against the new draft genome of _M. hapla_. The job that was submitted can be found in ```blast.sh```

4. The data obtained from BLAST was manually put together in the format recognized by ALLMAPS (https://github.com/tanghaibao/jcvi/wiki/ALLMAPS). For example: 

|Contig| Position1|Position2|LinkageGroup|
|----------|----------|-------|-------------------|
|ptg000018l|	285249|	285748|	genetic_map-lg1a:0|
|ptg000018l|	29032|	29531|	genetic_map-lg1a:0|

5. ALLMAPS was downloaded and installed as stated in the (https://github.com/tanghaibao/jcvi/wiki/ALLMAPS). To integrate the genetic map, following command was run: 

```
python -m jcvi.assembly.allmaps path final_genetic_map.bed purged_hifiasm_assembly_v1.fasta -w weights.txt  

```




