# A simple Nextflow guide

What are the basic things you need to a single step in a workflow?

* Input
* Output
* Executable Commands
* Environment (Ignore for now, will be get back to this in latter part)

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

> Each step in nextflow refereed as process.

Nextflow script written in a file called with extension `.nf`

Lets see a simple nextflow script to do quality check of FASTQ files.

File Name - [fastqc.nf](fastqc.nf)

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

File Name - [quality_check.nf](quality_check.nf)