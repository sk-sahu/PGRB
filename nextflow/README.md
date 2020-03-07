# A simple Nextflow guide

What are the basic things you need to a single step in a workflow?

* Input
* Outut
* Exicutatble Commands
* Enviroment (Ignore for now, will be get back to this in latter part)

Nextflow basic structure

```nextflow
process process_name {

    input:
    Single/Multiple Input

    output:
    Single/Multiple Output

    script:
    """
    whatever commands you like to execute.
    """ 
}
```

> Each step in nextflow refered as process.

All nextflow script writen in a file called with extntion `.nf`

Lets see a simple nextflow script to do quality check of FASTQ files.

File - fastqc.nf

```nextflow
params.forward = "./test_data/FASTQ/SRR1039508_1.fastq.gz"
params.reverse = "./test_data/FASTQ/SRR1039508_2.fastq.gz"

process fastqc {
	publishDir ".", mode: 'copy'

    input:
    params.forward
    params.reverse

    output:
    file("*") into fastqc_ch

    script:
    """
    mkdir -p fastqc_output
    fastqc -o fastqc_output -f fastq -q ${params.forward} ${params.reverse}
    """ 
}
```

Now lets extend it.

File - [quality_check.nf](quality_check.nf)