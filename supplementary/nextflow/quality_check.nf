// this program takes two fasta file and do pre and post quality check

params.reads = "$baseDir/test_data/FASTQ/SRR*_{1,2}.fastq.gz"
params.outdir = "test_out"

Channel
    .fromFilePairs( params.reads, checkExists:true )
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }
    .into { read_pairs_ch; read_pairs_ch2 }

process fastqc_before_trim {
	publishDir params.outdir, mode: 'copy'
    tag "FASTQC on $sample_id"

    input:
    set sample_id, file(fq1), file(fq2) from read_pairs_ch

    output:
    file('*') into fastqc_before_trim_ch

    script:
    """
    mkdir fastqc_${sample_id}_before_trim_logs
    fastqc -o fastqc_${sample_id}_before_trim_logs -f fastq -q ${fq1} ${fq2}
    """ 
}

process trim {
    tag "trim on $pair_id"
    publishDir params.outdir, mode: 'copy'

    input:
    set pair_id, file(reads) from read_pairs_ch2

    output:
    set pair_id, file("filtred_${pair_id}/${reads[0]}"), file("filtred_${pair_id}/${reads[1]}") into fastp1_ch
    
    script:
    """
    mkdir filtred_${pair_id}
    fastp -i ${reads[0]} -I ${reads[1]} \
        -o filtred_${pair_id}/${reads[0]} \
        -O filtred_${pair_id}/${reads[1]} \
        --json filtred_${pair_id}/${pair_id}_fastp.json \
		--html filtred_${pair_id}/${pair_id}_fastp.html \
        --detect_adapter_for_pe \
        --disable_length_filtering \
        --correction
    """ 
}


process fastqc_after_trim {
	publishDir params.outdir, mode: 'copy'
    tag "FASTQC on $sample_id"

    input:
    set sample_id, file(fq1), file(fq2) from fastp1_ch

    output:
    file('*') into fastqc_after_trim_ch


    script:
    """
    mkdir fastqc_${sample_id}_after_trim_logs
    fastqc -o fastqc_${sample_id}_after_trim_logs -f fastq -q ${fq1} ${fq2}
    """ 
}