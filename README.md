# Reproducibility in Bioinformatics (Work In Progress)

Reproducibility is very much essential for any kind of scientific research.

As Biology becoming more of computational and data driven, It is responsibility of the researcher to take advantage of available concepts/platforms/methods/tools to reproduce every piece of results/findings. 

With this training guide the intention is to familiarize you with those available concepts/platforms/methods/tools.

This is made keeping focus on the people from Biological background with good knowledge of bash scripting and programming.

By End of this training you will get an good idea of
* Reproducing Computation Environment
* Reproducing a Analysis
* Reproducing a Workflow/Pipeline

## Reproducing Computation Environment
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
* [Conda](conda/README.md) - An open-source package manager and environment management system.
* [Docker](docker/README.md) - A light weight platform which helps create portable virtual environment.


## Reproducing a Workflow/Pipeline

> What is a Workflow/Pipeline?
> 
> Workflow refers to running different steps in a serial manner, where each step output can be input of another.

Traditionally people used to write simple workflows using shell scripting and make files.

But writing workflows in Bioinformatics  can be quite challenging with those traditional methods. As sometime it involves lot of complex steps. For that purpose there are some dedicated languages available. 

One such language we are going to discuss here.

### Nextflow - [here](nextflow/README.md)

