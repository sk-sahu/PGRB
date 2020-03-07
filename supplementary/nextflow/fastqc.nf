params.forward = "./test_data/FASTQ/SRR1039508_1.fastq.gz"
params.reverse = "./test_data/FASTQ/SRR1039508_2.fastq.gz"

process fastqc {
	publishDir ".", mode: 'copy'

    input:
    params.forward
    params.reverse

    output:
    file("fastqc_output")

    script:
    """
    mkdir -p fastqc_output
    fastqc -o fastqc_output -f fastq -q ${params.forward} ${params.reverse}
    """ 
}