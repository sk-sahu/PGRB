Reproducibility is very much essential for any kind of scientific research.

As Biology becoming more of computational and data driven, It is responsibility of the researcher to take advantage of available concepts/platforms/methods/tools to reproduce every piece of results/findings. 

With this training guide the intention is to familiarize you with those available concepts/platforms/methods/tools.

This is made keeping focus on the people from Biological background with good knowledge of bash scripting and programming.

By End of this training you will get an good idea of
* Reproducing Computation Environment
* Reproducing a Analysis
* Reproducing a Workflow/Pipeline

# Reproducing Computation Environment
> What is a Computation Environments?
> 
> Computation Environments is an interface from where a tools/command can be called if it is installed in that environment.
> 
> Example:
> 
> Whenever you open a bash terminal there are certain tools/commands available to you for use. Those are most probably present in your `.bashrc` or a path is exported.

If you using lots of different bioinformatics tools at some point of time must have downloaded a tool, complied (if not already in binary) and then exported path.

```bash
export PATH="tool-path:$PATH"
```

Or if you are lucky, then downloaded using some system package manager, which automatically exports the path for you.

```bash
apt-get install fastqc
```

Basically you have told the computer to make available the tool in you **current environment**. So that you can just call the tool name instead of giving the whole path every time.

But maintaining **this environments** becomes very difficult when you working with lots of tools or in a shared computer(HPC) and Cloud.

And what if tomorrow if you wants to change your system or you tell you collaborator to run the whole thing what you have run. Then in both the case all the tools need to be installed again from scratch.

In that case following tools/platforms comes handy 

* [Conda](#a-basic-conda-guide) - An open-source package manager and environment management system.
* [Docker](#a-basic-docker-guide) - A light weight platform which helps create portable virtual environment.

## A basic conda guide

Conda is a package manager and environment management system. That means you can install any tool using this and at the same time you can use this to manager those tools in different environments.

I work with quite a lot of tools and packages. Personally conda have been a life saver for me. Which you will also realize once you start using it.

Most of the tools used by Bioinformatics applications are available in **bioconda** channel. 

So for say if you just wants to install `fastqc` then you simply need to do - 

```bash
conda install fastqc -c bioconda
```


TODO

## A basic docker guide

Docker is a tool which helps you create light weight **containers**, which are portable.

You can think a container as a Computer system where all you tools are installed and ready to use.

The logic to make a container can be write in a **Dockerfile**

An example Dockerfile

```docker
FROM ubuntu:19.10

RUN apt-get update
RUN apt-get install -y fastqc 
```

Built the docker image

```bash
cd docker
docker build -t fastqc:latest .
```

Run the docker container

```bash
docker run --rm fastqc:latest fastqc --help
```

You should see the `fastqc` help menu

# Reproducing a Workflow/Pipeline

> What is a Workflow/Pipeline?
> 
> Workflow refers to running different steps in a serial manner, where each step output can be input of another.

Traditionally people used to write simple workflows using shell scripting and make files.

But writing workflows in Bioinformatics  can be quite challenging with those traditional methods. As sometime it involves lot of complex steps. For that purpose there are some dedicated languages available. 

One such language we are going to discuss here.

## A basic Nextflow guide

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

File Name - [fastqc.nf](supplementary/nextflow/fastqc.nf)

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

File Name - [quality_check.nf](supplementary/nextflow/quality_check.nf)
