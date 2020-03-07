# RPB
Reproducibility in Bioinformatics

This training guide is intended for the people from Biological background with good knowledge of bash scripting and programming.

Reproducibility become 

By End of this training you will get an good idea of
* Reproducing Computation Environment
* Reproducing a Workflow/Pipeline

## Reproducing Computation Environment
> What is a Computation Environments?
> 
> Computation Environments is an interface from where a tools/command can be called if it is installed in that environment.
> 
> Example:
> 
> Whenever you open a bash terminal there are certain tools/commands available to you for use. Those are most probably present in your `.bashrc` or a path is exported.

If you using different bioinformatics tools for sometime now you must have done exporting path at some point of time.

```bash
export PATH="tool-path:$PATH"
```

Basically you have tell the computer to make available the tool in you **current environment**. So that you can just call the tool name instead of giving the whole path every time.

But maintaining **this environments** becomes very difficult when you working with lots of tools or in a shared computer(HPC) and Cloud.

And what if tomorrow if you wants to change your system or you tell you collaborator to run the whole thing what you have run. Then in both the case all the tools need to be installed again from scratch.

In that case following tools/platforms comes handy 
* [Conda](conda/README.md) - An open-source package manager and environment management system.
* [Docker](#docker/README.md) - A light weight platform which helps create portable virtual environment.


## Reproducing a Workflow/Pipeline

> What is a Workflow/Pipeline?
> 
> Workflow refers to running different steps in a serial manner, where each step out output can be input of another.

Traditionally people used to write simple workflows using shell scripting and make files.

But in Bioinformatics writing workflows can be quite challenging as sometime it involves lot of complex steps. For that purpose there are some dedicated languages available. 

One such language we are going to discuss today.

### Nextflow - [here](nextflow/README.md)

